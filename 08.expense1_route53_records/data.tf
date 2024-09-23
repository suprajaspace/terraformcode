data "aws_ami" "ami_info" {
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


# ref : terraform data resources,
# owners : AWS > EC2 > AMI > search devops-practive>select RHEL-9-DevOps-practice AMI> use owner Account ID 
# name,root-device-type,virtualization-type from AMI ID details