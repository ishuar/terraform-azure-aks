resource "azurerm_resource_group" "aks_rg" {
  name     = "rg-aks-module-test-euw"
  location = "West Europe"
  tags = {
    type       = "aks-module"
    managed_by = "terraform"
  }
}

## Minimal Example
module "aks" {
  source = "../"

  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  kubernetes_version  = "1.23.5"
  node_resource_group = "rg-node-aks-module-test-euw"
  dns_prefix          = "exampleaks1"

  tags = {
    type = "aks-module"
  }
}

## Outputs 
output "pub_key" {
  value = module.aks.ssh_pub_key
}
output "aks_id" {
  value = module.aks.aks_id
}
