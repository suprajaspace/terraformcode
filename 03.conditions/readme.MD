## conditions 

conditions concept used here 

use case 1: based on environment instance type will be created

 Ex:
  
 ec2.tf:
 
 instance_type = var.environment =="prod" ? "t3.small" : "t3.micro"