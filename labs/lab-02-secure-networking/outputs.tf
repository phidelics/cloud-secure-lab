output "vpc_name" { value = google_compute_network.vpc.name }
output "public_subnet" { value = google_compute_subnetwork.public.name }
output "private_subnet" { value = google_compute_subnetwork.private.name }

output "public_cidr" { value = google_compute_subnetwork.public.ip_cidr_range }
output "private_cidr" { value = google_compute_subnetwork.private.ip_cidr_range }

