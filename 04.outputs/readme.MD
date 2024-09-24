### outputs

for reference: https://developer.hashicorp.com/terraform/language/values/outputs

every resource exports some values, we can take them and create other resources.

```
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
```

Outputs:

private_ip = <sensitive>

public_ip = "54.167.4.127"
 
here "aws_instance.terraform " is the (resource of instance .name of instance)

sensitive true means not to display in commandline.
