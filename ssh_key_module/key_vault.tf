data "azurerm_client_config" "current" {
}
resource "azurerm_resource_group" "kv_rg" {
  name     = "ssh-key-rg"
  location = "West Europe"
  tags = {
    type       = "aks-module"
    managed_by = "terraform"
    usage      = "key_vault"
  }
}
#tfsec:ignore:azure-keyvault-specify-network-acl
resource "azurerm_key_vault" "password_key_vault" {
  name                        = "kv-vm-sshkey-euw-01"
  location                    = azurerm_resource_group.kv_rg.location
  resource_group_name         = azurerm_resource_group.kv_rg.name
  enabled_for_disk_encryption = false
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false #tfsec:ignore:azure-keyvault-no-purge
  sku_name                    = "standard"
  tags                        = var.tags
}
resource "azurerm_key_vault_access_policy" "user_access_policy" {
  key_vault_id = azurerm_key_vault.password_key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Create",
    "Get",
  ]

  secret_permissions = [
    "Set",
    "Get",
    "Delete",
    "Purge",
    "Recover",
    "List",
  ]
}

resource "azurerm_key_vault_secret" "kv_secret" {
  name            = "random-gen-prv-key"
  value           = tls_private_key.ssh.private_key_pem
  key_vault_id    = azurerm_key_vault.password_key_vault.id
  content_type    = "ssh-key"
  expiration_date = var.expiration_date
  tags            = var.tags
}
