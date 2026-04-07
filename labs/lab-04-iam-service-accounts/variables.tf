variable "project_id" { type = string }
variable "region"     { type = string default = "europe-west2" }

variable "tf_sa_name" {
  type    = string
  default = "tf-automation-sa"
}

variable "vm_sa_name" {
  type    = string
  default = "workload-vm-sa"
}
