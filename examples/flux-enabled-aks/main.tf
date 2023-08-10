resource "azurerm_resource_group" "aks_rg" {
  name     = "rg-flux-aks-module-test-euw"
  location = "West Europe"
  tags     = local.tags
}
module "ssh_key_generator" {
  source               = "github.com/ishuar/terraform-sshkey-generator?ref=v1.1.0"
  algorithm            = "RSA"
  private_key_filename = "${path.module}/aks-private-key"
  file_permission      = "600"
}

## FluxCD enabled Azure Kubernetes Cluster
## ? ref : https://learn.microsoft.com/en-us/azure/azure-arc/kubernetes/tutorial-use-gitops-flux2?tabs=azure-cli#for-azure-kubernetes-service-clusters
module "aks" {
  source = "../../"

  location                     = azurerm_resource_group.aks_rg.location
  resource_group_name          = azurerm_resource_group.aks_rg.name
  name                         = "flux-enabled-cluster"
  dns_prefix                   = "fluxaks"
  default_node_pool_name       = "default"
  default_node_pool_node_count = 1
  key_data                     = trimspace(module.ssh_key_generator.public_ssh_key)

  ## Flux
  enable_fluxcd                      = true
  fluxcd_extension_name              = "fluxcd-002"
  fluxcd_configuration_name          = "module-testing"
  fluxcd_extension_release_namespace = "flux-system"
  fluxcd_namespace                   = "flux"
  fluxcd_scope                       = "cluster"
  fluxcd_git_repository_url          = "https://github.com/Azure/gitops-flux2-kustomize-helm-mt"
  kustomizations = [
    {
      name = "infrastructure"
      path = "./infrastructure"
    },
    {
      name       = "apps"
      path       = "./apps/staging"
      depends_on = ["infrastructure"]
    }
  ]
  ### This is experimental only Feature
  enable_fluxcd_az_providers = true
}

## In case not able to delete aks extension.
### az k8s-extension delete  --resource-group rg-aks-module-test-euw --cluster-name minimal-example --cluster-type managedClusters --name flux-cd --force
