terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # THE ENTERPRISE UPGRADE
  backend "s3" {
    bucket         = "dbss-tf-state-ganesh-998877" # <-- REPLACE with your exact bucket name from Step 1
    key            = "global/s3/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "dbss-tf-locks"
    encrypt        = true
  }
}
provider "aws" {
  region = "ap-south-1"
}
resource "aws_security_group" "web_sg" {
  name        = "dbss_web_firewall"
  description = "Allow HTTP traffic for DBSS web server"

  # Inbound Rules (Ingress)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow from anywhere
  }

  # Outbound Rules (Egress)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "telecom_server" {
  ami           = "ami-013e83f579886baeb"
  instance_type = var.instance_size

  tags = {
    Name        = "Telecom-Backend-Node-${var.env_tag}"
    Environment = var.env_tag
    ManagedBy   = "Terraform"
  }

  # Attach the firewall we just created
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  # The Bootstrap Script
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>DBSS Infrastructure Sandbox - Provisioned by Terraform</h1>" > /var/www/html/index.html
              EOF
}
