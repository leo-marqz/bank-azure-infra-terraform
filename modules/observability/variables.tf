variable "name" {
  description = "The name for the Application Insights resource."
  type        = string
}

variable "location" {
  description = "The Azure region where the resource should be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group to create the resource in."
  type        = string
}

variable "application_type" {
  description = "The application type of the Application Insights resource."
  type        = string
  default     = "web"
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
}
