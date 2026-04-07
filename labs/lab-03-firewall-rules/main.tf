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
}

resource "google_project_service" "compute" {
  project = var.project_id
  service = "compute.googleapis.com"
  disable_on_destroy = false
}

resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  depends_on              = [google_project_service.compute]
}

resource "google_compute_subnetwork" "public" {
  name          = "public-subnet-euw2"
  ip_cidr_range = var.public_cidr
  region        = var.region
  network       = google_compute_network.vpc.id
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "private" {
  name          = "private-subnet-euw2"
  ip_cidr_range = var.private_cidr
  region        = var.region
  network       = google_compute_network.vpc.id
  private_ip_google_access = true
}

# Allow INTERNAL traffic within VPC subnets (east-west)
resource "google_compute_firewall" "allow_internal" {
  name    = "fw-allow-internal"
  network = google_compute_network.vpc.name

  direction = "INGRESS"
  priority  = 1000

  source_ranges = [var.public_cidr, var.private_cidr]

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "icmp"
  }
}

# Allow SSH only from IAP proxy range to instances with a specific tag
resource "google_compute_firewall" "allow_iap_ssh" {
  count   = var.allow_iap_ssh ? 1 : 0
  name    = "fw-allow-iap-ssh"
  network = google_compute_network.vpc.name

  direction = "INGRESS"
  priority  = 1000

  source_ranges = ["35.235.240.0/20"] # IAP TCP forwarding range
  target_tags   = [var.admin_tag]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}
