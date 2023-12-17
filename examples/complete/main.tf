resource "azurerm_resource_group" "aks" {
  name     = "rg-${local.tags["example"]}-cluster-example"
  location = "West Europe"
  tags     = local.tags
}

module "ssh_key_generator" {
  source               = "github.com/ishuar/terraform-sshkey-generator?ref=v1.1.0"
  algorithm            = "RSA"
  private_key_filename = "${path.module}/aks-private-key"
  file_permission      = "600"
}

##TODO: Update complete example with new features
module "complete" {
  source = "../../"

  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  name                = "aks-${local.tags["example"]}-example"
  dns_prefix          = local.tags["example"]
  key_data            = trimspace(module.ssh_key_generator.public_ssh_key)
  include_preview     = true
  tags                = local.tags

  ##? Identity
  identity_type                              = "UserAssigned"
  identity_ids                               = [azurerm_user_assigned_identity.aks.id]
  kubelet_identity_enabled                   = true
  kubelet_identity_user_assigned_identity_id = azurerm_user_assigned_identity.kubelet.id
  kubelet_identity_client_id                 = azurerm_user_assigned_identity.kubelet.client_id
  kubelet_identity_object_id                 = azurerm_user_assigned_identity.kubelet.principal_id

  ##? Default node pool
  node_pool_type                        = "VirtualMachineScaleSets"
  default_node_pool_name                = "system"
  default_node_pool_enable_auto_scaling = true
  default_node_pool_vm_size             = "standard_d2ds_v5"
  default_node_pool_min_count           = 1
  default_node_pool_max_count           = 2
  default_node_pool_max_pods            = 110
  temporary_name_for_rotation           = "tmpcomp"
  ##? additional_node_pools
  additional_node_pools = {
    "nodepool01" = {
      vm_size             = "standard_d2ds_v5"
      enable_auto_scaling = true
      max_count           = 2
      min_count           = 1
      max_pods            = 110
    }
  }

  ##? Api service access profile
  enable_api_server_access_profile    = true
  vnet_integration_enabled            = true
  api_server_access_profile_subnet_id = azurerm_subnet.aks_api.id

  ##? Networking
  vnet_subnet_id      = azurerm_subnet.aks_node.id
  network_plugin      = "azure"
  network_plugin_mode = "overlay"
  service_cidrs       = ["100.1.0.0/16"]
  pod_cidrs           = ["100.2.0.0/16"]
  dns_service_ip      = "100.1.0.100"
  network_policy      = "calico"
  # ebpf_data_plane     = "cilium"

  ##? Monitor Diagnostics Settings
  enable_cluster_log_monitor_diagnostic = true
  monitor_diagnostic_storage_account_id = azurerm_storage_account.aks.id
  enable_cluster_all_category_group_log = true
  enable_cluster_all_metrics            = true

  ##? Azure Active Directory
  local_account_disabled           = true
  aad_rbac_enabled                 = true ## Enable the feature for Azure RBAC with AKS
  aad_rbac_managed                 = true ## Manged RBAC
  aad_azure_rbac_enabled           = true ## Azure AAD and Azure RBAC ( No K8s RBAC )
  aad_rbac_managed_admin_group_ids = []   ## require permissions to create groups , empty good for testing

  ##? Workload Identity
  workload_identity_enabled = true
  oidc_issuer_enabled       = true

  ##? Flux
  enable_fluxcd_az_providers                     = true ## Enable the providers configurations required for flux extension.
  enable_fluxcd                                  = true
  fluxcd_extension_name                          = "infrastructure"
  fluxcd_configuration_name                      = "infrastructure-components"
  fluxcd_extension_release_namespace             = "flux-system"
  fluxcd_namespace                               = "flux" ##?This Namespace should be used in k8s manifests sync with AKS fluxCD when multi tenancy is enabled.
  fluxcd_scope                                   = "cluster"
  fluxcd_git_repository_url                      = "https://github.com/ishuar/kubernetes-projects"
  fluxcd_git_repository_sync_interval_in_seconds = 60

  ## Opt Out of Multitenancy https://learn.microsoft.com/en-us/azure/azure-arc/kubernetes/conceptual-gitops-flux2#opt-out-of-multi-tenancy
  fluxcd_extension_configuration_settings = {
    "multiTenancy.enforce" = false
  }

  kustomizations = [
    {
      name                     = "infrastructure"
      path                     = "./azure-kubernetes-service/flux-extension-and-flux-dashboard/fluxcd/infrastructure"
      sync_interval_in_seconds = 60
    }
  ]

  ##? Extras
  image_cleaner_enabled                               = true
  run_command_enabled                                 = true
  key_vault_secrets_provider_secret_rotation_enabled  = true
  key_vault_secrets_provider_secret_rotation_interval = true

  ##? Explicit Dependency
  depends_on = [
    azurerm_role_assignment.kubelet_operator,
    azurerm_role_assignment.aks_mi_network_contributor
  ]
}
