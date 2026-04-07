## Lab 04 – IAM & Service Accounts (Least Privilege Identity)

### Why this lab exists
In cloud environments, IAM is often the most important security control.
Over-permissioned identities are a common cause of major incidents.
This lab creates dedicated service accounts and assigns least-privilege roles
so workloads and automation do not rely on user accounts or broad permissions.

### What I built
- A dedicated service account for Terraform automation (optional if already in use)
- A dedicated service account for workloads (VMs)
- Least-privilege IAM bindings for required capabilities only
- Clear separation between:
  - Human access (admin tasks)
  - Automation access (Terraform)
  - Workload identity (VM runtime permissions)

### Design decisions (Security reasoning)
- Avoid using Owner/Editor for day-to-day automation
- Prefer small, purpose-built roles for each function
- Prepare for secure compute deployment (Lab 05) without static keys in repo

### What I achieved (Outcome)
- Reduced blast radius by limiting what each identity can do
- A safer operational model: “humans deploy, workloads run with minimal rights”
- A foundation aligned with cloud security best practices (least privilege)

### Common problems encountered (and fixes)
- Permissions errors during apply:
  - Confirm your human account can create service accounts & set IAM bindings
- Confusion between user auth and service accounts:
  - Terraform uses provider credentials; workload permissions come from the VM service account
- Risk of leaking credentials:
  - Never commit service account keys; prefer secure auth methods (e.g., Workload Identity)

### How to verify (quick checks)
- GCP Console → IAM:
  - Confirm service accounts exist
  - Confirm only minimal roles were granted
- Ensure no secrets/keys are committed to GitHub

### Notes for the next lab
Lab 05 deploys a VM securely into the private subnet using the workload
service account created here. No public IP will be used.
