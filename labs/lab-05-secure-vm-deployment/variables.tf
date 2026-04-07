variable "project_id" { type = string }
variable "region"     { type = string default = "europe-west2" }
variable "zone"       { type = string default = "europe-west2-a" }

variable "vpc_name"     { type = string default = "secure-vpc" }
variable "private_cidr" { type = string default = "10.10.2.0/24" }

variable "vm_name" {
  type    = string
  default = "private-vm-01"
}

variable "machine_type" {
  type    = string
  default = "e2-micro"
}

variable "admin_tag" {
  type    = string
  default = "admin-access"
}
