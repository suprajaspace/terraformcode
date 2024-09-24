variable "instances" {
  type = map(any)
  default = {
    mysql    = "t3.small"
    backend  = "t3.micro"
    frontend = "t3.micro"
  }
}

variable "zone_id" {
  default = "Z0037057DV8PD1YP3QYK"
}

variable "domain_name" {
  default = "vardhanglobal.online"
}