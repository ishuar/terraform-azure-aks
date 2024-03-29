data "azurerm_kubernetes_cluster" "this" {
  count               = var.existing_aks_cluster ? 1 : 0
  name                = var.name
  resource_group_name = var.resource_group_name
}

# ref: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_service_versions
data "azurerm_kubernetes_service_versions" "current" {
  count           = var.kubernetes_version != "" ? 0 : 1
  location        = var.location
  include_preview = var.include_preview
}

locals {
  aks_cluster                      = var.existing_aks_cluster ? data.azurerm_kubernetes_cluster.this[0] : azurerm_kubernetes_cluster.this[0]
  enable_api_server_access_profile = var.api_server_authorized_ip_ranges != null || var.api_server_access_profile_subnet_id != null || var.vnet_integration_enabled
  kubernetes_version               = var.kubernetes_version != "" ? var.kubernetes_version : data.azurerm_kubernetes_service_versions.current[0].latest_version
}

resource "azurerm_kubernetes_cluster" "this" {
  count                               = var.existing_aks_cluster ? 0 : 1
  name                                = var.name
  location                            = var.location
  resource_group_name                 = var.resource_group_name
  kubernetes_version                  = local.kubernetes_version
  dns_prefix                          = var.dns_prefix
  dns_prefix_private_cluster          = var.dns_prefix_private_cluster
  automatic_channel_upgrade           = var.automatic_channel_upgrade
  azure_policy_enabled                = var.azure_policy_enabled
  disk_encryption_set_id              = var.disk_encryption_set_id
  local_account_disabled              = var.local_account_disabled
  node_resource_group                 = var.node_resource_group
  private_cluster_enabled             = var.private_cluster_enabled
  private_dns_zone_id                 = var.private_dns_zone_id
  private_cluster_public_fqdn_enabled = var.private_cluster_public_fqdn_enabled
  role_based_access_control_enabled   = var.role_based_access_control_enabled
  sku_tier                            = var.sku_tier
  run_command_enabled                 = var.run_command_enabled
  oidc_issuer_enabled                 = var.oidc_issuer_enabled
  workload_identity_enabled           = var.workload_identity_enabled
  http_application_routing_enabled    = var.http_application_routing_enabled
  open_service_mesh_enabled           = var.open_service_mesh_enabled
  image_cleaner_enabled               = var.image_cleaner_enabled
  image_cleaner_interval_hours        = var.image_cleaner_interval_hours
  tags                                = var.tags
  network_profile {
    network_plugin      = var.network_plugin
    network_policy      = var.network_policy
    pod_cidr            = var.pod_cidr
    pod_cidrs           = var.pod_cidrs
    service_cidr        = var.service_cidr
    service_cidrs       = var.service_cidrs
    dns_service_ip      = var.dns_service_ip
    outbound_type       = var.outbound_type
    ebpf_data_plane     = var.ebpf_data_plane
    network_plugin_mode = var.network_plugin_mode
    load_balancer_sku   = var.load_balancer_sku
  }

  dynamic "maintenance_window" {
    for_each = var.enable_maintenance_window ? ["maintenance_window"] : []

    content {
      dynamic "allowed" {
        for_each = var.enable_allowed_maintenance_window ? ["allowed_maintenance_window"] : []
        content {
          day   = var.allowed_maintenance_window_day
          hours = var.allowed_maintenance_window_hours
        }
      }
      dynamic "not_allowed" {
        for_each = var.enable_not_allowed_maintenance_window ? ["not_allowed_maintenance_window"] : []
        content {
          end   = var.not_allowed_maintenance_window_end
          start = var.not_allowed_maintenance_window_start
        }
      }
    }
  }

  default_node_pool {
    name                         = var.default_node_pool_name
    vm_size                      = var.default_node_pool_vm_size
    node_count                   = var.default_node_pool_node_count
    enable_auto_scaling          = var.default_node_pool_enable_auto_scaling
    enable_host_encryption       = var.default_node_pool_enable_host_encryption
    enable_node_public_ip        = var.default_node_pool_enable_node_public_ip
    kubelet_disk_type            = var.default_node_pool_kubelet_disk_type
    node_public_ip_prefix_id     = var.default_node_pool_public_ip_prefix_id
    orchestrator_version         = local.kubernetes_version
    node_labels                  = merge({ "aks_cluster_name" = var.name }, var.default_node_pool_node_labels)
    only_critical_addons_enabled = var.default_node_pool_only_critical_addons_enabled
    os_disk_size_gb              = var.default_node_pool_os_disk_size_gb
    os_disk_type                 = var.default_node_pool_os_disk_type
    os_sku                       = var.default_node_pool_os_sku
    tags                         = merge({ "aks_cluster_name" = var.name }, var.default_node_pool_tags, var.tags)
    ultra_ssd_enabled            = var.default_node_pool_ultra_ssd_enabled
    vnet_subnet_id               = var.vnet_subnet_id
    min_count                    = var.default_node_pool_min_count
    max_count                    = var.default_node_pool_max_count
    fips_enabled                 = var.default_node_pool_fips_enabled
    max_pods                     = var.default_node_pool_max_pods
    zones                        = var.default_node_pool_zones
    proximity_placement_group_id = var.default_node_pool_proximity_placement_group_id
    message_of_the_day           = var.default_node_pool_message_of_the_day
    workload_runtime             = var.default_node_pool_workload_runtime
    temporary_name_for_rotation  = var.temporary_name_for_rotation
    type                         = var.node_pool_type
    upgrade_settings {
      max_surge = var.default_node_pool_upgrade_max_surge
    }
  }
  dynamic "azure_active_directory_role_based_access_control" {
    for_each = var.aad_rbac_enabled ? [1] : []
    content {
      managed = var.aad_rbac_managed

      # if managed
      admin_group_object_ids = var.aad_rbac_managed ? var.aad_rbac_managed_admin_group_ids : null
      azure_rbac_enabled     = var.aad_rbac_managed ? var.aad_azure_rbac_enabled : null

      # if not managed
      client_app_id     = var.aad_rbac_managed ? null : var.aad_rbac_unmanaged_client_app_id
      server_app_id     = var.aad_rbac_managed ? null : var.aad_rbac_unmanaged_server_app_id
      server_app_secret = var.aad_rbac_managed ? null : var.aad_rbac_unmanaged_server_app_secret
    }
  }
  dynamic "http_proxy_config" {
    for_each = var.http_proxy_config != null ? [1] : []
    content {
      https_proxy = var.http_proxy_config.https_proxy
      http_proxy  = var.http_proxy_config.http_proxy
      no_proxy    = var.http_proxy_config.no_proxy
    }
  }
  dynamic "api_server_access_profile" {
    for_each = local.enable_api_server_access_profile ? [1] : []
    content {
      authorized_ip_ranges     = var.api_server_authorized_ip_ranges
      subnet_id                = var.api_server_access_profile_subnet_id
      vnet_integration_enabled = var.vnet_integration_enabled
    }
  }
  storage_profile {
    blob_driver_enabled         = var.blob_driver_enabled
    disk_driver_enabled         = var.disk_driver_enabled
    disk_driver_version         = var.disk_driver_version
    file_driver_enabled         = var.file_driver_enabled
    snapshot_controller_enabled = var.snapshot_controller_enabled
  }
  dynamic "ingress_application_gateway" {
    for_each = var.ingress_app_gw_enabled ? [1] : []
    content {
      gateway_id   = var.ingress_app_gw_id != null ? var.ingress_app_gw_id : null
      gateway_name = var.ingress_app_gw_name
      # If a new gw should be created
      subnet_cidr = var.ingress_app_gw_id == null ? var.ingress_app_gw_subnet_cidr : null
      subnet_id   = var.ingress_app_gw_id == null ? var.ingress_app_gw_subnet_id : null
    }
  }
  dynamic "key_vault_secrets_provider" {
    for_each = var.key_vault_secrets_provider_enabled ? [1] : []
    content {
      secret_rotation_enabled  = var.key_vault_secrets_provider_secret_rotation_enabled
      secret_rotation_interval = var.key_vault_secrets_provider_secret_rotation_interval
    }
  }
  dynamic "kubelet_identity" {
    for_each = var.kubelet_identity_enabled ? [1] : []
    content {
      client_id                 = var.kubelet_identity_client_id
      object_id                 = var.kubelet_identity_object_id
      user_assigned_identity_id = var.kubelet_identity_user_assigned_identity_id
    }
  }
  dynamic "windows_profile" {
    for_each = var.windows_profile_enabled ? [1] : []
    content {
      admin_username = var.windows_profile_admin_username
      admin_password = var.windows_profile_admin_password
      license        = var.windows_profile_license
    }
  }
  dynamic "microsoft_defender" {
    for_each = var.enable_microsoft_defender ? [1] : []
    content {
      log_analytics_workspace_id = var.log_analytics_workspace_id
    }
  }
  identity {
    type         = var.identity_type
    identity_ids = var.identity_ids
  }

  dynamic "linux_profile" {
    for_each = var.key_data != "" ? [1] : []
    content {
      admin_username = var.admin_username
      ssh_key {
        key_data = var.key_data
      }
    }
  }
  lifecycle {
    ignore_changes = [

    ] ##TODO: To avoid conflicts between auto upgrade and terraform

    precondition {
      condition     = var.workload_identity_enabled && var.oidc_issuer_enabled
      error_message = "`oidc_issuer_enabled` must be set to `true` to enable Azure AD Workload Identity"
    }
    precondition {
      condition     = var.network_plugin_mode != "overlay" || var.network_plugin == "azure"
      error_message = "When network_plugin_mode is set to `overlay`, the network_plugin field can only be set to azure."
    }
    precondition {
      condition     = var.ebpf_data_plane != "cilium" || var.network_plugin == "azure"
      error_message = "When ebpf_data_plane is set to cilium, the network_plugin field can only be set to azure."
    }
    precondition {
      condition     = var.ebpf_data_plane != "cilium" || var.network_plugin_mode == "overlay" || var.vnet_subnet_id != null
      error_message = "When ebpf_data_plane is set to cilium, one of either network_plugin_mode = `overlay` or pod_subnet_id must be specified."
    }
    ## when defender is enabled, a log analytics workspace id must be provided
    precondition {
      condition     = !var.enable_microsoft_defender || var.log_analytics_workspace_id != null
      error_message = "Enabling Microsoft Defender requires a valid log analytics workspace id."
    }
    precondition {
      condition     = var.default_node_pool_enable_auto_scaling != true || var.node_pool_type == "VirtualMachineScaleSets"
      error_message = "When Auto Scaling is enabled, the default node pool type must be VirtualMachineScaleSets."
    }
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "this" {
  for_each                     = var.additional_node_pools
  name                         = try(each.value["os_type"], null) == "Windows" ? format("%s%s", substr(each.key, 0, 3), substr(each.key, -3, -1)) : each.key
  kubernetes_cluster_id        = local.aks_cluster.id
  vm_size                      = each.value["vm_size"]
  enable_auto_scaling          = try(each.value["enable_auto_scaling"], null)
  enable_host_encryption       = try(each.value["enable_host_encryption"], null)
  enable_node_public_ip        = try(each.value["enable_node_public_ip"], null)
  eviction_policy              = try(each.value["priority"], null) == "Spot" ? try(each.value["eviction_policy"], null) : null
  mode                         = try(each.value["mode"], null)
  node_labels                  = merge({ "aks_cluster_name" = var.name }, (try(each.value["node_labels"], null)))
  node_public_ip_prefix_id     = try(each.value["enable_node_public_ip"], false) ? try(each.value["node_public_ip_prefix_id"], null) : null
  node_taints                  = try(each.value["node_taints"], null)
  orchestrator_version         = try(each.value["orchestrator_version"], local.kubernetes_version)
  os_disk_size_gb              = try(each.value["os_disk_size_gb"], null)
  os_disk_type                 = try(each.value["os_disk_type"], null)
  pod_subnet_id                = try(each.value["pod_subnet_id"], null)
  os_type                      = try(each.value["os_type"], null)
  scale_down_mode              = try(each.value["scale_down_mode"], null)
  ultra_ssd_enabled            = try(each.value["ultra_ssd_enabled"], null)
  vnet_subnet_id               = try(each.value["vnet_subnet_id"], var.vnet_subnet_id)
  zones                        = try(each.value["zones"], null)
  node_count                   = try(each.value["node_count"], null) ## Required when `each.value["enable_auto_scaling"]` is set to false
  max_count                    = try(each.value["enable_auto_scaling"], false) ? each.value["max_count"] : null
  min_count                    = try(each.value["enable_auto_scaling"], false) ? each.value["min_count"] : null
  max_pods                     = try(each.value["max_pods"], null)
  workload_runtime             = try(each.value["workload_runtime"], null)
  kubelet_disk_type            = try(each.value["kubelet_disk_type"], null)
  message_of_the_day           = try(each.value["message_of_the_day"], null)
  os_sku                       = try(each.value["os_sku"], null)
  proximity_placement_group_id = try(each.value["proximity_placement_group_id"], null)
  snapshot_id                  = try(each.value["snapshot_id"], null)
  dynamic "upgrade_settings" {
    for_each = try(each.value.upgrade_settings, {})
    content {
      max_surge = upgrade_settings.value["max_surge"]
    }
  }

  tags = merge(
    {
      "aks_cluster_name" = var.name
    },
    var.tags,
    try(each.value["node_pool_tags"], null)
  )
  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      name
    ]
    precondition {
      condition     = var.node_pool_type == "VirtualMachineScaleSets"
      error_message = "To create multiple node pools, the default node pool type must be VirtualMachineScaleSets."
    }
  }
}
