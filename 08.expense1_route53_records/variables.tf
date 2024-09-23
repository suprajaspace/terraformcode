variable "instance_names" {
  type        = list(string)
  default     = ["mysql", "backend", "frontend"]
  description = "description"
}

variable "zone_id" {
  default = "Z0037057DV8PD1YP3QYK"
}

variable "domain_name" {
  default = "vardhanglobal.online"
}