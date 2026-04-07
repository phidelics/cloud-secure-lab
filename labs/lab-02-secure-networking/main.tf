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
  name          = var.public_subnet_name
  ip_cidr_range = var.public_cidr
  region        = var.region
  network       = google_compute_network.vpc.id
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "private" {
  name          = var.private_subnet_name
  ip_cidr_range = var.private_cidr
  region        = var.region
  network       = google_compute_network.vpc.id
  private_ip_google_access = true
}
