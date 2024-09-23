variable "instance_names" {
  type    = list(string)
  default = ["mysql", "backend", "frontend"]

}
variable "common_tags" {
  type = map(any)
  default = {
    Project     = "expense"
    Environment = "prod"
    Terraform   = "true"
  }
}