resource "azurerm_resource_group" "aks_rg" {
  name     = "rg-aks-module-test-euw"
  location = "West Europe"
  tags     = local.tags
}

## Minimal Example with disabled Autoscaling and disabled monitor diagnostic setting
module "aks" {
  source = "../../"

  location                     = azurerm_resource_group.aks_rg.location
  resource_group_name          = azurerm_resource_group.aks_rg.name
  name                         = "minimal-example"
  dns_prefix                   = "exampleaks1"
  default_node_pool_name       = "default"
  default_node_pool_node_count = 1
}

/*
* Use command "az aks get-credentials --resource-group ${RESOURE_GROUP_NAME}--name ${CLUSTER_NAME} --admin" for admin access.
*/
