####################################
# AZURE RBAC for Flux Extensions #
####################################
#? ref: https://learn.microsoft.com/en-us/azure/azure-arc/kubernetes/tutorial-use-gitops-flux2?tabs=azure-cli#for-azure-kubernetes-service-clusters

data "azurerm_client_config" "current" {
  count = var.enable_fluxcd ? 1 : 0
}

## Each Role Name should be different in a Directory
resource "random_string" "fluxcd" {
  count  = var.enable_fluxcd ? 1 : 0
  length = 4
}

resource "azurerm_role_definition" "fluxcd" {
  count = var.enable_fluxcd ? 1 : 0

  name  = "flux-cd-${random_string.fluxcd[0].result}-${var.name}"
  scope = local.aks_cluster.id

  permissions {
    actions = [
      "Microsoft.KubernetesConfiguration/fluxConfigurations/read",
      "Microsoft.KubernetesConfiguration/fluxConfigurations/write",
      "Microsoft.KubernetesConfiguration/extensions/read",
      "Microsoft.KubernetesConfiguration/extensions/write",
      "Microsoft.ContainerService/managedClusters/read",
      "Microsoft.ContainerService/managedClusters/write"
    ]
    not_actions = []
  }

  assignable_scopes = [
    local.aks_cluster.id
  ]
}
resource "azurerm_role_assignment" "fluxcd" {
  count = var.enable_fluxcd ? 1 : 0

  scope              = local.aks_cluster.id
  role_definition_id = azurerm_role_definition.fluxcd[0].role_definition_resource_id
  principal_id       = data.azurerm_client_config.current[0].object_id
}

#####################
# Flux Extensions #
#####################

resource "azurerm_kubernetes_cluster_extension" "fluxcd" {
  count = var.enable_fluxcd ? 1 : 0

  name              = var.fluxcd_extension_name
  cluster_id        = local.aks_cluster.id
  extension_type    = "microsoft.flux"
  release_train     = var.fluxcd_extension_release_train
  release_namespace = var.fluxcd_extension_release_namespace
  target_namespace  = var.fluxcd_extension_target_namespace
  version           = var.fluxcd_extension_version

  depends_on = [
    terraform_data.az_providers_register,
    azurerm_role_assignment.fluxcd
  ]
}

resource "azurerm_kubernetes_flux_configuration" "this" {
  for_each = var.enable_fluxcd ? toset(["fluxcd_configuration"]) : toset([])

  name                              = var.fluxcd_configuration_name
  cluster_id                        = local.aks_cluster.id
  namespace                         = var.fluxcd_namespace
  scope                             = var.fluxcd_scope
  continuous_reconciliation_enabled = var.fluxcd_continuous_reconciliation_enabled

  git_repository {
    url                      = var.fluxcd_git_repository_url
    reference_type           = var.fluxcd_git_repository_reference_type
    reference_value          = var.fluxcd_git_repository_reference_value
    https_user               = var.fluxcd_git_repository_https_user
    https_key_base64         = var.fluxcd_git_repository_https_key_base64
    local_auth_reference     = var.fluxcd_git_repository_local_auth_reference
    ssh_private_key_base64   = var.fluxcd_git_repository_ssh_private_key_base64
    ssh_known_hosts_base64   = var.fluxcd_git_repository_ssh_known_hosts_base64
    sync_interval_in_seconds = var.fluxcd_git_repository_sync_interval_in_seconds
    timeout_in_seconds       = var.fluxcd_git_repository_timeout_in_seconds
  }

  dynamic "kustomizations" {
    for_each = { for kustomization in var.kustomizations : kustomization.name => kustomization }

    content {
      path                       = kustomizations.value.path
      name                       = kustomizations.value.name
      timeout_in_seconds         = kustomizations.value.timeout_in_seconds
      sync_interval_in_seconds   = kustomizations.value.sync_interval_in_seconds
      retry_interval_in_seconds  = kustomizations.value.retry_interval_in_seconds
      recreating_enabled         = kustomizations.value.recreating_enabled
      garbage_collection_enabled = kustomizations.value.garbage_collection_enabled
      depends_on                 = toset(kustomizations.value.depends_on)
    }
  }
  dynamic "blob_storage" {
    for_each = var.fluxcd_blob_storage_container_id != "" ? toset(["create_blob_storage"]) : toset([])
    content {
      container_id             = var.fluxcd_blob_storage_container_id
      account_key              = var.fluxcd_blob_storage_account_key
      local_auth_reference     = var.fluxcd_blob_storage_local_auth_reference
      sas_token                = var.fluxcd_blob_storage_sas_token
      sync_interval_in_seconds = var.fluxcd_blob_storage_sync_interval_in_seconds
      timeout_in_seconds       = var.fluxcd_blob_storage_timeout_in_seconds

      dynamic "managed_identity" {
        for_each = var.fluxcd_blob_storage_managed_identity_client_id != "" ? toset(["create_blob_storage_managed_identity"]) : toset([])
        content {
          client_id = var.fluxcd_blob_storage_managed_identity_client_id
        }
      }
      dynamic "service_principal" {
        for_each = var.fluxcd_blob_storage_service_principal_client_id != "" && var.fluxcd_blob_storage_service_principal_tenant_id != "" ? toset(["create_blob_storage_service_principal"]) : toset([])
        content {
          client_id                     = var.fluxcd_blob_storage_service_principal_client_id
          tenant_id                     = var.fluxcd_blob_storage_service_principal_tenant_id
          client_certificate_base64     = fluxcd_blob_storage_service_principal_client_certificate_base64
          client_certificate_password   = fluxcd_blob_storage_service_principal_client_certificate_password
          client_certificate_send_chain = fluxcd_blob_storage_service_principal_client_certificate_send_chain
          client_secret                 = fluxcd_blob_storage_service_principal_client_secret
        }
      }
    }
  }
  dynamic "bucket" {
    for_each = var.enable_fluxcd_bucket && var.fluxcd_bucket_url != "" && var.fluxcd_bucket_name != "" ? toset(["create_bucket_config"]) : toset([])
    content {
      bucket_name              = var.fluxcd_bucket_bucket_name
      url                      = var.fluxcd_bucket_url
      access_key               = var.fluxcd_bucket_access_key
      secret_key_base64        = var.fluxcd_bucket_secret_key_base64
      tls_enabled              = var.fluxcd_bucket_tls_enabled
      local_auth_reference     = var.fluxcd_bucket_local_auth_reference
      sync_interval_in_seconds = var.fluxcd_bucket_sync_interval_in_seconds
      timeout_in_seconds       = var.fluxcd_bucket_timeout_in_seconds
    }
  }

  depends_on = [
    azurerm_kubernetes_cluster_extension.fluxcd,
    terraform_data.az_providers_register
  ]
}


###### Register Azure provider
resource "terraform_data" "az_providers_register" {
  count = var.enable_fluxcd && var.enable_fluxcd_az_providers ? 1 : 0

  triggers_replace = [
    local.aks_cluster.id
  ]
  provisioner "local-exec" {
    #### script to enable/register the required namespaces with  boolean argument to upgrade az cli or not.
    command = "${path.module}/scripts/register-k8s-containers-az-providers.sh false"
    interpreter = [
      "/bin/bash", "-c"
    ]
  }
}
