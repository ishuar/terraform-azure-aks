data "azurerm_client_config" "current" {
}
#tfsec:ignore:azure-keyvault-specify-network-acl
resource "azurerm_key_vault" "password_key_vault" {
  name                        = var.ssh_key_vault_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = var.enabled_for_disk_encryption
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = var.soft_delete_retention_days
  purge_protection_enabled    = var.purge_protection_enabled #tfsec:ignore:azure-keyvault-no-purge
  sku_name                    = "standard"

  tags = merge(var.tags,
    {
      usage = "ssh key aks module"
  })
}
resource "azurerm_key_vault_access_policy" "user_access_policy" {
  key_vault_id = azurerm_key_vault.password_key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

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
  name            = var.ssh_kv_secret
  value           = var.public_ssh_key == "" ? tls_private_key.ssh.private_key_pem : var.public_ssh_key
  key_vault_id    = azurerm_key_vault.password_key_vault.id
  content_type    = "ssh-key"
  expiration_date = var.expiration_date

  tags = merge(var.tags,
    {
      usage = "ssh key aks module"
  })
  depends_on = [
    azurerm_key_vault_access_policy.user_access_policy
  ]
}
