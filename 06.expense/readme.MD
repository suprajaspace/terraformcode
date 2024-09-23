#### aws-route53 creation

for reference:
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record

r53.tf

```
resource "aws_route53_record" "expense" {
  count = length(var.instance_names)
  zone_id = var.zone_id
  #backend.vardhanglobal.online
  name    = "${var.instance_names[count.index]}.${var.domain_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.expense[count.index].private_ip]
  allow_overwrite = true
}

```
*count:  as per number of instances required
*zone id: zone id of route 53hosted zone 
>>AWS>Route 53>hosted zone>hosted zone name>hosted zone details>hosted zone id
*name : name of Record Name
 name    = "${var.instance_names[count.index]}.${var.domain_name}"
 
 here it is constructing a name by concatenating two variables: instance_names and domain_name. 
1. ${} Syntax (Interpolation):
The ${} syntax in Terraform is called interpolation. It allows you to insert or reference variables, expressions, and functions dynamically within strings.
2. var.instance_names:
This refers to a variable named instance_names. This is a list (or array) of names that are defined elsewhere in the Terraform configuration (likely in a variables.tf or passed during runtime)
 
*type : Type of record
*TTL : time to limit 
*records : Value of the record (ip address)
 records = [aws_instance.expense[count.index].private_ip]
Retrieve the private IP address of the count.index-th instance of the aws_instance.expense resource.

allow_overwrite : permission to overwrite

outputs.tf

```
output "instances_info" {
    value = aws_instance.expense
}
```
variables.tf
```
variable "instance_names" {
    type = list(string)
    default = ["mysql", "backend", "frontend"]
}

variable  "zone_id" {
    default = "Z0037057DV8PD1YP3QYK"
}

variable "domain_name" {
    default = "vardhanglobal.online"
}
```














