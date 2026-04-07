# Cloud Secure Lab (Multi-Cloud: GCP → AWS → Azure)

## Overview
This project demonstrates how to design and deploy secure cloud infrastructure using Terraform across multiple cloud providers.
## Learning Approach (How I Built This)

This repository is a hands-on learning portfolio built iteratively. My goal is not to “dump a lot of code”, but to demonstrate real cloud engineering habits: designing deliberately, automating safely, and documenting decisions clearly.

### How I learn and build
- **Incremental labs:** I build in small, independent labs (Lab 01 → Lab 05), each focused on one concept (project setup, networking, firewall rules, IAM, secure compute).
- **Why-first documentation:** Every lab includes a README that explains *why* the design exists, *what* I built, and *what outcome* it achieves from a security perspective.
- **Troubleshooting is part of the work:** I document real issues I hit (e.g., project ID vs display name, API enablement, Terraform provider state) and how I resolved them. This mirrors real-world engineering.
- **Use of references and guidance:** Like real engineers, I use official documentation, examples, and guidance when writing Terraform. The key is that I can explain each resource, why it exists, and how to verify it.
- **Security-by-default mindset:** I avoid insecure defaults (default networks, broad ingress rules, public SSH) and build foundations before workloads.

### How to run the labs (repeatable + cost-aware)
Each lab is designed to be runnable without keeping resources running permanently:
1. `terraform init`
2. `terraform plan` (review changes)
3. `terraform apply` (deploy)
4. Verify in console + Terraform outputs
5. `terraform destroy` (clean up to control cost and avoid conflicts)

### What this portfolio demonstrates
- Infrastructure as Code using Terraform
- Secure networking patterns (segmentation + least privilege)
- Identity-first cloud security (service accounts and scoped permissions)
- Practical debugging and operational discipline
- Multi-cloud translation of the same principles (GCP first, then AWS and Azure)
``

## Phase 1: GCP (Current)
- Custom VPC (no default network)
- Public + Private subnets (segmentation)
- Firewall rules (least privilege, no public SSH)
- IAM and service accounts (identity-first security)
- Secure VM deployment (private VM, controlled access)

## Future Phases
- AWS implementation (planned)
- Azure implementation (planned)

## Tools Used
- Terraform
- Google Cloud Platform (GCP)
- AWS (planned)
- Azure (planned)
)
