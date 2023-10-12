###########
## Network
###########

resource "azurerm_virtual_network" "aks" {
  name                = "vnet-${local.tags["example"]}-aks-cluster"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  tags                = local.tags
}

resource "azurerm_subnet" "aks_node" {
  name                 = "snet-${local.tags["example"]}-aks-cluster-node"
  resource_group_name  = azurerm_resource_group.aks.name
  virtual_network_name = azurerm_virtual_network.aks.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "aks_api" {
  name                 = "snet-${local.tags["example"]}-aks-cluster-api"
  resource_group_name  = azurerm_resource_group.aks.name
  virtual_network_name = azurerm_virtual_network.aks.name
  address_prefixes     = ["10.0.2.0/24"]
  delegation {

    name = "aks-api-access-profile"
    service_delegation {
      name = "Microsoft.ContainerService/managedClusters"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action"
      ]
    }
  }
}

## Use a domain what you own.
## Public DNS Zone, configure forwarders for this sub-domain or root domain to the nameservers from this DNS zone on your domain registrar
resource "azurerm_dns_zone" "k8s_learndevops_in" {
  name                = "k8s.learndevops.in" ## replace this with a domain what you own.
  resource_group_name = azurerm_resource_group.aks.name
  tags                = local.tags
}

###########
## Identity
###########

data "azurerm_client_config" "current" {}

resource "azurerm_user_assigned_identity" "aks" {
  name                = "id-aks-${local.tags["example"]}-example-cluster"
  resource_group_name = azurerm_resource_group.aks.name
  location            = azurerm_resource_group.aks.location
}

resource "azurerm_user_assigned_identity" "kubelet" {
  name                = "id-kubelet-${local.tags["example"]}-example-cluster"
  resource_group_name = azurerm_resource_group.aks.name
  location            = azurerm_resource_group.aks.location
}

## Assign on the resource group level for Nginx ingress controller ( vnet integration requires on subnet level )
resource "azurerm_role_assignment" "aks_mi_network_contributor" {
  scope                = azurerm_resource_group.aks.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.aks.principal_id
}

###########
## Storage
###########

resource "random_string" "random" {
  length  = 8
  special = false
  upper   = false
  lower   = true
}

resource "azurerm_storage_account" "aks" {
  name                     = "strakscomp${random_string.random.result}"
  location                 = azurerm_resource_group.aks.location
  resource_group_name      = azurerm_resource_group.aks.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.tags
}
