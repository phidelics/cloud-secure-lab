output "tf_automation_sa_email" {
  value = google_service_account.tf_automation.email
}

output "vm_workload_sa_email" {
  value = google_service_account.vm_workload.email
}

