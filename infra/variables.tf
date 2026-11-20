variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "environment" {
  description = "The environment for the deployment (e.g., dev, staging, prod)"
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Valid values for var: environment are (dev, staging, prod)."
  }
}

variable "vnet_address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
}

variable "subnet_address_prefixes" {
  description = "The address prefixes for the subnet"
  type        = list(string)
}

variable "admin_ip" {
  description = "The public IP address allowed to SSH into the VM"
  type        = string
}

variable "admin_username" {
  description = "The admin username for the VM"
  type        = string
}

variable "vm_size" {
  description = "The size of the virtual machine"
  type        = string
  default     = "Standard_D2als_v6"
}