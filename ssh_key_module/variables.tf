
variable "resource_group_name" {
  type        = string
  description = "(optional) Resource group from AKS module"
  default     = null
}
variable "location" {
  type        = string
  description = "(optional) The location where AKS cluster would be deployed"
  default     = "westeurope"
}
variable "public_ssh_key" {
  description = "An ssh key set in the main variables of the terraform-azurerm-aks module"
  default     = ""
}
variable "tags" {
  type        = map(string)
  description = "(optional) Tags from aks module"
  default     = {}
}
variable "ssh_key_vault_name" {
  type        = string
  description = "(optional) Key Vault name where private key would be stored as password"
  default     = "kv-ssh-key-aks-module"
}
variable "enabled_for_disk_encryption" {
  type        = bool
  description = "(optional)Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys."
  default     = false
}
variable "soft_delete_retention_days" {
  type        = number
  description = "(optional) he number of days that items should be retained for once soft-deleted."
  default     = 7
}
variable "purge_protection_enabled" {
  type        = bool
  description = "(optional) Is Purge Protection enabled for this Key Vault?"
  default     = false
}
variable "expiration_date" {
  type        = string
  description = "(optional) Expiration UTC datetime (2024-01-31T00:00:00Z)"
  default     = "2024-01-31T00:00:00Z"
}
variable "ssh_kv_secret" {
  type        = string
  description = "(optional) KV secret which contains the ssh ppk generated for aks module"
  default     = "secret-ppk-aks-module"
}
