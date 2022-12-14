resource "azurerm_resource_group" "aks_rg" {
  name     = "rg-aks-module-test-euw"
  location = "West Europe"
  tags     = local.tags
}

## Minimal Example with Autoscaling
module "aks" {
  source = "../"

  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name

  name                                  = "example-aks1"
  kubernetes_version                    = "1.24.3"
  node_resource_group                   = "rg-node-aks-module-test-euw"
  dns_prefix                            = "exampleaks1"
  aad_rbac_enabled                      = true
  default_node_pool_name                = "default"
  default_node_pool_vm_size             = "standard_d2s_v5"
  default_node_pool_enable_auto_scaling = true
  default_node_pool_node_count          = 1
  default_node_pool_max_count           = 2
  default_node_pool_min_count           = 1
  tags                                  = local.tags
}
