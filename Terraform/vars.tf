variable "location" {
  type        = string
  default     = "westeurope"
  description = "The location/region where the resources in this example should be created."
}

variable "tags" {
  type        = map(string)
  default     = { student = "mattice" }
  description = "A mapping of tags to assign to the resources."
}

variable "ubuntu_user" {
  type      = string
  sensitive = true
}

variable "ubuntu_pass" {
  type      = string
  sensitive = true
}