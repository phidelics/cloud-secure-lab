## Lab 03 – Firewall Rules (Least Privilege Traffic Control)

### Why this lab exists
A secure network design is incomplete without traffic controls.
In GCP, VPC firewall rules determine which traffic is allowed or denied.
This lab implements least-privilege access to reduce attack surface and
limit lateral movement if a workload is compromised.

### What I built
- Firewall rules to control ingress/egress traffic
- A secure baseline that avoids broad "0.0.0.0/0" access
- Rules designed to support future workloads (VMs) without exposing them

### Design decisions (Security reasoning)
- No public SSH from the internet
- Prefer controlled admin access (e.g., IAP SSH) over open ingress
- Use explicit allow rules only where needed, keep everything else blocked

### What I achieved (Outcome)
- A network that is secure by default (least privilege)
- Reduced risk of accidental public exposure
- Clear, auditable traffic rules ready for secure workload deployment

### Common problems encountered (and fixes)
- Rules don’t apply: ensure firewall targets match (network tags or service accounts)
- Connectivity blocked: confirm source ranges and ports are correct
- “It worked yesterday”: check if you renamed tags or changed subnet ranges

### How to verify (quick checks)
- In GCP Console: VPC network → Firewall rules → confirm rules exist and are enabled
- Confirm no broad inbound rules exist (e.g., tcp:22 from 0.0.0.0/0)
- If using tags: confirm the target VM tag matches the firewall rule target

### Notes for the next lab
Lab 04 will create service accounts and least-privilege IAM so workloads
don’t run with excessive permissions.
