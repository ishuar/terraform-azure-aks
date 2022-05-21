variable "public_ssh_key" {
  description = "An ssh key set in the main variables of the terraform-azurerm-aks module"
  default     = ""
}
variable "expiration_date" {
  type        = string
  description = "(optional) Expiration UTC datetime (2024-01-31T00:00:00Z)"
  default     = "2024-01-31T00:00:00Z"
}
variable "tags" {
  type        = map(string)
  description = "(optional) Tags attached to ssh key resources"
  default = {
    env        = "dev"
    managed_by = "terraform"
    type       = "ssh-keys"
  }
}
