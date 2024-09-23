## EC2 Instance creation

### provider.tf 

here provider.tf added here to connection between AWS and terraform  

for reference: 

https://registry.terraform.io/providers/hashicorp/aws/latest/docs

```

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.66.0"
    }
  }
}

provider "aws" {
  #Configuration options
  region = "us-east-1"
}
```

configuration options :

AWS access key id, secret access key id configured in AWS CLI

### ec2.tf

here ec2.tf added to create ec2 instance and security group

for reference :

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance

```
resource "aws_instance" "terraform" {
  ami = "ami-09c813fb71547fc4f"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_ssh_terraform.id]
  tags ={
    Name = "terraform"
  }
  }
```
resource "resource name" "name of resource "

ami is the AMI ID of RHEL-9 DevOps-Practice.
* EC2 > AMIs > search with devops-practice 

instance-type: required Instance type

vpc_security_group_ids : using Key pair name, here using allow_ssh_terraform id of aws_security_group

tags block is used to give name os the resources.

#### security group :

here security group provide for to create ec2 instance

for reference:

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
```
resource "aws_security_group" "allow_ssh_terraform" {
    name        = "allow_sshh" 
    description = "Allow port number 22 for SSH access"

    #usually we allow everything in egress

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    ingress {
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"] #allow from everyone
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
    Name = "allow_sshh"
  }
}
 ```
 resource "resourse name" "name of resource"

 name is for security group name

 description is information about this security group

egress block:
Egress rules are applied to control the outbound traffic from an instance or service. By default, AWS allows all outbound traffic unless you specify otherwise.

Ingress block:
Ingress rules to specify what traffic is allowed to access your instance.

tags block is used to name of the security group 

### variables.tf

here variables.tf is introduced to declare variables.

varaiable type either string,list,map etc..
default is value of variable

varaibles.tf (declare variables)

```
variable "ami_id" {
    type          =  string 
    default       ="ami-09c813fb71547fc4f"
    description   =" This is the AMI ID of devops-practice which is RHEL-9"
}  

variable "tags" {
  type        = map #optional
  default     = {
    Name    = "backend"
    Project = "expense"
    Component   = "backend"
    Environment = "DEV"
    Terraform   = "true"
  }
}

variable "from_port"{
    default     = 22
    type        = number
}

variable "ingress_cidr" {
    type    = list(string)
    default    = ["0.0.0.0/0"]
}
variable "sg_name"{
    default   =  "allow_sshh1"
}
```
ec2.tf (calling variables)

```
ami = var.ami_id  
# left side and right side names need not to be same

tags = var.tags 

name        = var.sg_name

from_port        = var.from_port

cidr_blocks      = var.ingress_cidr #allow from everyone

```
** under tags Name = "backend"will be used for Name of instance and Name of security group
** security group name is allow_sshh1
** under tags, all arguments and values will be added in instance tags tab. those tags used to categorised environments. 










