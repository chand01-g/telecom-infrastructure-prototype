# Telecom Infrastructure Prototype: Zero-Touch Provisioning

This repository contains a V1 architectural prototype designed to migrate legacy telecom operations to a modern, automated cloud-native stack. 

### 🏗️ Architecture Highlights
* **Zero-Touch Provisioning:** Utilizes an AWS EC2 Bootstrap script (`user_data`) to automatically configure web nodes upon boot, eliminating manual SSH configurations.
* **Enterprise State Management:** The Terraform backend is fully decoupled from local hardware, utilizing an **Amazon S3 Vault** for state storage and a **DynamoDB Table** for state-locking, preventing team deployment collisions.
* **Security-First:** Implements strict Security Group firewalls to allow only targeted HTTP/TCP ingress.

### ⚙️ The Goal
To replace manual, ticket-based legacy system management with a highly reliable, Infrastructure-as-Code pipeline capable of supporting high-concurrency environments with zero downtime.
