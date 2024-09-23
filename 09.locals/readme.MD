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

