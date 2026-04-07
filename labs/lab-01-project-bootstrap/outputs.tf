output "project_id" {
  value       = var.project_id
  description = "Project ID used for this lab"
}

output "vpc_name" {
  value       = google_compute_network.vpc.name
  description = "Created VPC name"
}

output "vpc_self_link" {
  value       = google_compute_network.vpc.self_link
  description = "VPC self_link"
}
