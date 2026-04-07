
provider "google" {
  project = "cloud-secure-lab"
  region  = "europe-west2"
}

resource "google_compute_network" "vpc_network" {
  name                    = "secure-vpc"
  auto_create_subnetworks = false
}