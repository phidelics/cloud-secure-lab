variable "project_id" { type = string }
variable "region"     { type = string default = "europe-west2" }

variable "vpc_name" { type = string default = "secure-vpc" }
variable "public_cidr"  { type = string default = "10.10.1.0/24" }
variable "private_cidr" { type = string default = "10.10.2.0/24" }

variable "admin_tag" {
  description = "Network tag applied to admin-manageable VMs"
  type        = string
  default     = "admin-access"
}

variable "allow_iap_ssh" {
  description = "Allow SSH via IAP range (recommended) to tagged instances"
  type        = bool
  default     = true
}
