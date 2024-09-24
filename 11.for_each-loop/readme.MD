### for-each loop

for reference: 

https://developer.hashicorp.com/terraform/language/meta-arguments/for_each

for each is used to iterate map...

[] --> list

{} --> map

here instance types will be implemented as per below using for-each loop

frontend -> t3.micro

backend --> t3.micro

mysql --> t3.small

ec2.tf
```
resource "aws_instance" "expense" {
    for_each = var.instances # this variable is map
    # for_each will give us a special variable with name each
    ami = "ami-09c813fb71547fc4f" 
    instance_type = each.value
    vpc_security_group_ids = [aws_security_group.allow_ssh_terraform.id]
    tags = {
        Name = each.key
    }
}
```
variables.tf
```
variable  "instances" {
  type        = map
  default     = {
    mysql = "t3.small"  # here mysql is each.key and t3.small is each.value
    backend = "t3.micro"
    frontend = "t3.micro"
  }
}
```
if frontend instance record name should be vardhanglobal.online otherwise backend/mysql instances record name backend/mysql vardhanglobal.online
```
 name = each.key == "frontend" ? var.domain_name : "${each.key}.${var.domain_name}"
 ```
if frontend record should be public IP or else record should be private IP
```
 records         = each.key == "frontend" ? [each.value.public_ip] : [each.value.private_ip]
 ```



