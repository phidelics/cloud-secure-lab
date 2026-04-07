output "firewall_rules" {
  value = [
    google_compute_firewall.allow_internal.name,
    try(google_compute_firewall.allow_iap_ssh[0].name, null)
  ]
}
``
