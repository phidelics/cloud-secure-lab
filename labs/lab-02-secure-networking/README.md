## Lab 02 – Secure Networking (VPC & Subnets)

### Why this lab exists
Network design is a foundational security control in cloud environments.
Default networks expose unnecessary routes and increase attack surface.

This lab focuses on designing a secure network layout that supports
least privilege, isolation, and future security controls.

### What I built
- Custom VPC network (no default configuration)
- Public subnet for controlled ingress
- Private subnet with no public IP exposure
- Regional placement for locality and resilience

### Design decisions
- Subnets separated by trust level
- No compute resources created at this stage
- Network kept minimal and auditable

### Security outcome
- Reduced attack surface
- Clear segmentation boundary
- Foundation ready for firewall rules, NAT, and IAM controls

### What this prepares for
- Secure firewall rules
- Controlled outbound access (NAT)
- Private workloads
