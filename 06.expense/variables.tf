variable "instance_names" {
    type = list(string)
    default = ["mysql", "backend", "frontend"]
}

variable "common_tags" {
    type = map
    default = {
        Project = "expense"
        Environment = "dev"
        Terraform = "true"
    }
}

variable  "zone_id" {
    default = "Z0037057DV8PD1YP3QYK"
}

variable "domain_name" {
    default = "vardhanglobal.online"
}

