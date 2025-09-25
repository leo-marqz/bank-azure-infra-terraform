# Asegúrate que esta variable exista
variable "resource_group_name" { 
  description = "The name of the Resource Group where resources should be deployed."
  type        = string
}

# Asegúrate que esta variable exista
variable "location" { 
  description = "The Azure region where resources should be deployed."
  type        = string
}

# Asegúrate que esta variable exista
variable "location_slug" { 
  description = "A shortened, unique identifier for the location."
  type        = string
}

# Asegúrate que esta variable exista
variable "tags" { 
  description = "A map of tags to assign to the resources."
  type        = map(string)
}

# Asegúrate que esta variable exista
variable "sku" { 
  description = "The SKU of the Service Bus Namespace (e.g., Standard, Premium)."
  type        = string
  default     = "Standard" # Puede tener un default, pero debe estar declarada
}