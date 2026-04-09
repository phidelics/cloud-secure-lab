terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_project_service" "compute" {
  project = var.project_id
  service = "compute.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "iam" {
  project = var.project_id
  service = "iam.googleapis.com"
  disable_on_destroy = false
}

resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  depends_on              = [google_project_service.compute]
}

resource "google_compute_subnetwork" "private" {
  name          = "private-subnet-euw2"
  ip_cidr_range = var.private_cidr
  region        = var.region
  network       = google_compute_network.vpc.id
  private_ip_google_access = true
}

# Allow SSH only via IAP to tagged VMs (still no public IP)
resource "google_compute_firewall" "allow_iap_ssh" {
  name    = "fw-allow-iap-ssh"
  network = google_compute_network.vpc.name

  direction = "INGRESS"
  priority  = 1000

  source_ranges = ["35.235.240.0/20"]
  target_tags   = [var.admin_tag]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

# Workload service account
data "google_service_account" "vm_workload" {
  account_id = "workload-vm-sa"
}

resource "google_project_iam_member" "vm_log_writer" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${data.data.google_service_account.vm_workload.email}"
}

resource "google_project_iam_member" "vm_metric_writer" {
  project = var.project_id
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${data.data.google_service_account.vm_workload.email}"
}

# Private VM: NO public IP (no access_config block)
resource "google_compute_instance" "private_vm" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = [var.admin_tag]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.private.id
    # Intentionally no access_config => no external IP
  }

  service_account {
    email  = data.google_service_account.vm_workload.email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  depends_on = [
    google_compute_firewall.allow_iap_ssh,
    google_project_iam_member.vm_log_writer,
    google_project_iam_member.vm_metric_writer
  ]
}
