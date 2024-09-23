locals {
  domain_name   = "vardhanglobal.online"
  zone_id       = "Z0037057DV8PD1YP3QYK"
  instance_type = var.environment == "prod" ? "t3.medium" : "t3.micro"
  # count.index will not work in locals
}