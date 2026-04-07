variable "project_id" { type = string }
variable "region"     { type = string default = "europe-west2" }

variable "vpc_name" {
  type    = string
  default = "secure-vpc"
}

variable "public_subnet_name" {
  type    = string
  default = "public-subnet-euw2"
}

variable "private_subnet_name" {
  type    = string
  default = "private-subnet-euw2"
}

variable "public_cidr" {
  description = "CIDR for public subnet"
  type        = string
  default     = "10.10.1.0/24"
}

variable "private_cidr" {
  description = "CIDR for private subnet"
  type        = string
  default     = "10.10.2.0/24"
}
``
