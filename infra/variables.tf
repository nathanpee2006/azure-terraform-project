variable "admin_ip" {
  description = "The public IP address allowed to SSH into the VM"
  type        = string
}

variable "admin_username" {
  description = "The admin username for the VM"
  type        = string
}