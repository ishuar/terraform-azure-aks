## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.password_key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_access_policy.user_access_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_secret.kv_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [local_file.private_key](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [tls_private_key.ssh](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enabled_for_disk_encryption"></a> [enabled\_for\_disk\_encryption](#input\_enabled\_for\_disk\_encryption) | (optional)Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. | `bool` | `false` | no |
| <a name="input_expiration_date"></a> [expiration\_date](#input\_expiration\_date) | (optional) Expiration UTC datetime (2024-01-31T00:00:00Z) | `string` | `"2024-01-31T00:00:00Z"` | no |
| <a name="input_location"></a> [location](#input\_location) | (optional) The location where AKS cluster would be deployed | `string` | `"westeurope"` | no |
| <a name="input_public_ssh_key"></a> [public\_ssh\_key](#input\_public\_ssh\_key) | An ssh key set in the main variables of the terraform-azurerm-aks module | `string` | `""` | no |
| <a name="input_purge_protection_enabled"></a> [purge\_protection\_enabled](#input\_purge\_protection\_enabled) | (optional) Is Purge Protection enabled for this Key Vault? | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (optional) Resource group from AKS module | `string` | `null` | no |
| <a name="input_soft_delete_retention_days"></a> [soft\_delete\_retention\_days](#input\_soft\_delete\_retention\_days) | (optional) he number of days that items should be retained for once soft-deleted. | `number` | `7` | no |
| <a name="input_ssh_key_vault_name"></a> [ssh\_key\_vault\_name](#input\_ssh\_key\_vault\_name) | (optional) Key Vault name where private key would be stored as password | `string` | `"kv-ssh-key-aks-module"` | no |
| <a name="input_ssh_kv_secret"></a> [ssh\_kv\_secret](#input\_ssh\_kv\_secret) | (optional) KV secret which contains the ssh ppk generated for aks module | `string` | `"secret-ppk-aks-module"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (optional) Tags from aks module | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_public_ssh_key"></a> [public\_ssh\_key](#output\_public\_ssh\_key) | n/a |
| <a name="output_public_ssh_key_pem"></a> [public\_ssh\_key\_pem](#output\_public\_ssh\_key\_pem) | n/a |
