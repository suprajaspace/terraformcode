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

variables proirity:

1. command line
2. terraform.tfvars
3. environment variables, TF_VAR_your_variable_name
4. default
5. prompt



### conditions 

conditions concept

use case 1: based on environment instance type will be created

 Ex:
  
 ec2.tf:
 
 instance_type = var.environment =="prod" ? "t3.small" : "t3.micro"

### outputs

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
 
### loops

1. count based loop
2. for-each loop

count based loop is used to create many instances

count = 3

count.index is special variable used to pass instance names.
```
variable "instance_names"{
    type  =list(string)
    default = ["mysql", "backend", "frontend"]
}
```

### Functions
 Terraform has no custom functions, we must use inbuilt function

 for reference : https://developer.hashicorp.com/terraform/language/functions
 
 `terraform console`

 it is used to move terraform console

functions ex:
```
 > max(5, 12, 9)
 12
 
 > join("-", ["day","week","year"])
"day-week-year"

> split ("-", "summer-winter-spring")
tolist([
  "summer",
  "winter",
  "spring",
])
```

length function used to find of list

count = 3 

for many instances can use lenght function.

use case:

count = length(var.instance_names)

### Count
count = length(var.instance_names)

count = 3

merge function is to merge to lists

merge (list-1,list-2)

use case:

ec2.tf
```
tags = merge(
        var.common_tags,
        {
            Name = var.instance_names[count.index]
        }
    )

 tags = merge(
        var.common_tags,
        {
            Name = "allow-sshh"
        }
    )   
 ```
variables.tf
```
 variable "instance_names"{
    type  =list(string)
    default = ["mysql", "backend", "frontend"]

}
variable "common_tags" {
    type = map
    default = {
        Project = "expense"
        Environment = "prod"
        Terraform = "true"
    }
}
```

### expense project

3ec2 instances, 3 route53 records

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
### data-sources

data sources  --> instead of getting args manually, can query existing information

for reference: https://developer.hashicorp.com/terraform/language/data-sources

here ami id will change whenever the update new version of AMI.

so using this datasource code to fetch AMI ID from specific aws AMI.

```
data "aws_ami" "devops" {

	most_recent      = true
	owners = ["973714476881"]
	
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


### expense1_route53records

3 ec2, 3 r53 records

  implementing records names using outputs of 3 ec2 instance ip address and using conditions.

  conditions syntax: expression ? "true" : "false"

  **backend.vardhanglobal.online -->privateIP ---> t3.micro 

	**mysql.vardhanglobal.online --> privateIP ---> t3.small

	**vardhanglobal.online --> publicIP ---> t3.micro

  r53.tf:

  Route53 records name: backend.vardhanglobal.online ,mysql.vardhanglobal.online ,vardhanglobal.online
  ```
  name = var.instance_names[count.index] == "frontend" ? var.domain_name : "${var.instance_names[count.index]}.${var.domain_name}"
  ```
  Route53 records value i.e IP address
  ```
  records = var.instance_names[count.index] == "frontend" ? [aws_instance.terraform[count.index].public_ip] : [aws_instance.terraform[count.index].private_ip]
  ```
  ec2.tf:
  
  Instance types for 3 ec2 instances.t3.micro,t3.small
  ```
  instance_type          = var.instance_names[count.index] == "mysql" ? "t3.small" : "t3.micro"
  ```

### locals

locals are like variables but it have some extra capabilities. You can store expressions and intermediate values in locals

1. variables and locals both can store values, but locals have some extra capabilities
2. locals can store expressions, terraform can run them and get the value
3. locals can use variables inside. variables can't refer locals
4. can override variables, can't override locals

```
locals {
    domain_name  = "vardhanglobal.online"
    zone_id = "Z0037057DV8PD1YP3QYK"
    instance_type = var.environment == "prod" ? "t3.medium" : "t3.micro"
    # count.index will not work in locals
}
```
here zone id, domain name, instance type can add in locals due to those can't override.

instance names,environment will be add in variables due to can override.

** this locals concept can useful where cannot give option to users to override any values. if any changes needed variables can use, or else locals usage is best option 

### remote-state

in contribution environment we dont maintain the state remotely there will be chances of duplicates and errors. so we keep the state in remote location so that terraform can effectively compare 

to store state remotely using aws S3, for locking dynamoDB

remote storage --> s3 bucket

locking --> dynamo DB --> LockID

*s3 : AWS > S3> create bucket > unique name > supra-remote-state >create 

*dynamoDB :  AWS > DynamoDB > Tables > create table > unique (table name) > supra-locking > partition key > LockID > create table

to create remote state "backend S3" code will be added in provider.tf

for ref :

https://developer.hashicorp.com/terraform/language/backend/s3

```
backend "s3" {
    bucket = "supra-remote-state"
    key    = "remote-state-demo"
    region = "us-east-1"
    dynamodb_table = "supra-locking"
  }
```
key name will be unique for every repo.

bucket and dynamoDB values are name of S3 bucket name and dynamoDB name

after ec2 instance created, lock file will be created under dynamodb,explore table items.
state file will be created under buckets

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


# dynamic loops

this is also one loops concept

use case: where port values not stable, changes



  










