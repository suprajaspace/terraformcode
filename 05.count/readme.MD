### loops

1. count based loop
2. for-each loop

count based loop is used to create many instances
count = 3

count.index is special variable used to pass instance names.

variable "instance_names"{
    type  =list(string)
    default = ["mysql", "backend", "frontend"]
}

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