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

# Enable IAM + Compute APIs used in later labs
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

# Service account for Terraform automation
resource "google_service_account" "tf_automation" {
  account_id   = var.tf_sa_name
  display_name = "Terraform Automation Service Account"
  depends_on   = [google_project_service.iam]
}

# Service account for VM workloads
resource "google_service_account" "vm_workload" {
  account_id   = var.vm_sa_name
  display_name = "Workload VM Service Account"
  depends_on   = [google_project_service.iam]
}

# Minimal example roles (tighten later based on what you deploy)
# VM workload SA: allow writing logs/metrics (common baseline)
resource "google_project_iam_member" "vm_log_writer" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.vm_workload.email}"
}

resource "google_project_iam_member" "vm_metric_writer" {
  project = var.project_id
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.vm_workload.email}"
}
