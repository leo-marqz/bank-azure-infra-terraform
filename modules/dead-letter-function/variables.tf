
variable "name" {
  description = "The name of the dead-letter function."
  type        = string
}

variable "location" {
  description = "The Azure region where the function should be deployed."
  type        = string
}

variable "location_slug" {
  description = "A shortened identifier for the location."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group to create the function in."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
}
