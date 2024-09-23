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