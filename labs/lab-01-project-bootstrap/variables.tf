variable "project_id" {
  description = "GCP Project ID (NOT display name). Example: cloud-secure-lab-492609"
  type        = string
}

variable "region" {
  description = "Default region for resources"
  type        = string
  default     = "europe-west2"
}

variable "vpc_name" {
  description = "Name of the VPC network"
  type        = string
  default     = "secure-vpc"
}
