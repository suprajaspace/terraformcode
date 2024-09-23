output "public_ip" {
  value       = aws_instance.terraform.public_ip
  sensitive   = false
  description = "This is the public IP of Instance created"
}
output "private_ip" {
  value       = aws_instance.terraform.private_ip
  sensitive   = true
  description = "This is the private IP of Instance created"
}
# use output.instances_info

output "instances_info" {
    value = aws_instance.terraform
}



