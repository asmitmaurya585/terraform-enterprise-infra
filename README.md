# 🚀 Terraform Azure Infrastructure

Production-ready Azure Infrastructure using **Terraform** with reusable modules and multi-environment deployment (**Dev**, **PreProd**, **Prod**).

---

# Terraform Azure Infrastructure

## Overview

This project provisions enterprise-grade Microsoft Azure infrastructure using Terraform with a modular Infrastructure as Code (IaC) approach.

The repository is organized into reusable Terraform modules and environment-specific configurations for development, pre-production, and production deployments.

## Features

* Modular Terraform architecture
* Environment-based deployment (Dev, PreProd, Prod)
* Azure Resource Groups
* Virtual Networks (VNet)
* Subnets
* Network Security Groups (NSG)
* Public IP Addresses
* NAT Gateway
* Linux Virtual Machines
* Azure Application Gateway
* Azure Monitor
* Azure Database for MySQL
* Remote Terraform State Support
* Reusable Modules

## Project Structure

```text
terraform-azure-enterprise-infra/
│
├── modules/
│   ├── resource_group/
│   ├── virtual_network/
│   ├── subnet/
│   ├── network_security_group/
│   ├── public_ip/
│   ├── nat_gateway/
│   ├── linux_virtual_machine/
│   ├── application_gateway/
│   ├── monitor/
│   └── mysql/
│
├── environments/
│   ├── dev/
│   ├── preprod/
│   └── prod/
│
├── README.md
└── .gitignore
```

## Prerequisites

* Terraform v1.5+
* Azure CLI
* Azure Subscription
* Git

## Deployment

Initialize Terraform:

```bash
terraform init
```

Validate configuration:

```bash
terraform validate
```

Preview infrastructure changes:

```bash
terraform plan
```

Deploy infrastructure:

```bash
terraform apply
```

Destroy infrastructure:

```bash
terraform destroy
```

## Security

* Sensitive files are excluded using `.gitignore`
* Terraform state should be stored remotely
* Secrets should never be committed to Git

## Technologies

* Terraform
* Microsoft Azure
* Azure CLI
* Git
* Infrastructure as Code (IaC)

## Author

**Asmit Maurya**

- LinkedIn: https://linkedin.com/in/asmit-maurya
- GitHub: https://github.com/asmitmaurya585

---

⭐ If you found this project useful, consider giving it a star.
