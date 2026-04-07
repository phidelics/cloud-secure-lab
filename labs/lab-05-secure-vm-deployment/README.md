## Lab 05 – Secure VM Deployment (Private Compute with Controlled Access)

### Why this lab exists
Compute resources are only as secure as the foundation beneath them.
This lab deploys a VM in a secure way:
- placed into a private subnet
- no public IP address
- protected by least-privilege firewall rules (Lab 03)
- running with a least-privilege service account (Lab 04)

This mirrors real enterprise patterns where workloads are private by default.

### What I built
- A VM instance deployed into the private subnet
- No public IP exposure
- VM identity attached via the workload service account
- Access controlled by firewall rules (no open SSH from the internet)

### Design decisions (Security reasoning)
- Private subnet placement reduces exposure and attack surface
- Service account separation prevents workloads from inheriting human permissions
- Controlled admin access (e.g., IAP SSH) avoids opening inbound SSH to the world

### What I achieved (Outcome)
- A secure compute deployment pattern suitable for production-like environments
- Demonstrated end-to-end security thinking: network + firewall + IAM + compute
- A repeatable Terraform workflow that builds safe infrastructure consistently

### Common problems encountered (and fixes)
- Cannot SSH:
  - Confirm you are using IAP SSH (if that’s your model)
  - Confirm firewall rule allows tcp:22 from IAP range
  - Confirm the VM has the correct network tag or target service account
- VM accidentally got a public IP:
  - Ensure the network interface config disables access_config / public IP
- Permission denied errors:
  - Confirm the VM service account has required roles (and nothing more)

### How to verify (quick checks)
- GCP Console → Compute Engine → VM instances:
  - Confirm External IP is empty (no public IP)
  - Confirm correct subnet (private)
  - Confirm correct service account attached
- VPC Firewall:
  - Confirm no inbound SSH from 0.0.0.0/0 exists
  - Confirm only controlled access path is allowed

### Next steps
After this lab, the secure foundation is complete.
The next phase can extend into:
- NAT for controlled outbound access
- Logging & alerting
- Multi-cloud replication (AWS then Azure) using the same security principles
