output "vm_name" {
  value = google_compute_instance.private_vm.name
}

output "vm_internal_ip" {
  value = google_compute_instance.private_vm.network_interface[0].network_ip
}

output "vm_service_account" {
  value = google_service_account.vm_workload.email
}
