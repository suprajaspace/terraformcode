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






