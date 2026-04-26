output "server_public_ip" {
  description = "The public IP address of our new server"
  value       = aws_instance.telecom_server.public_ip
}
