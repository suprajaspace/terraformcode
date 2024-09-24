### conditions 

conditions concept

expression ? "run this if true" : "run this if false"

use case 1: based on environment instance type will be created

 Ex:
  
 ec2.tf:
 
 `instance_type` = var.environment =="prod" ? "t3.small" : "t3.micro" `