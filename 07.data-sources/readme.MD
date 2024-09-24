### data-sources

data sources  --> instead of getting args manually, can query existing information

for reference: https://developer.hashicorp.com/terraform/language/data-sources

here ami id will change whenever the update new version of AMI.

so using this datasource code to fetch AMI ID from specific aws AMI.

```
data "aws_ami" "devops" {

  most_recent = true
  owners      = ["973714476881"]

  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
```
aws > EC2> AMIS> search> devops-practice> RHEL-9-DevOps-Practice > AMI deails:

here owners value is "Owner account ID" of AMI

for filters can take any details of AMI

name is value of the "AMI name"

outputs.tf

```
output "ami_id" {
  value = data.aws_ami.devops.id
}
```
here for outputs value can use data."resource name"."name of resource"






