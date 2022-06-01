resource "azurerm_kubernetes_cluster" "aks" {
  name                                = var.cluster_name == null ? "aks-cluster-${var.location}-${var.env}" : var.cluster_name
  location                            = var.location
  resource_group_name                 = var.resource_group_name
  kubernetes_version                  = var.kubernetes_version
  node_resource_group                 = var.node_resource_group
  dns_prefix                          = try(var.dns_prefix, null)
  dns_prefix_private_cluster          = var.dns_prefix == null ? var.dns_prefix_private_cluster : null
  automatic_channel_upgrade           = var.automatic_channel_upgrade
  sku_tier                            = var.sku_tier
  private_cluster_enabled             = var.private_cluster_enabled
  private_dns_zone_id                 = var.private_dns_zone_id
  private_cluster_public_fqdn_enabled = var.private_cluster_public_fqdn_enabled
  api_server_authorized_ip_ranges     = toset(var.api_server_authorized_ip_ranges)
  azure_policy_enabled                = var.azure_policy_enabled
  http_application_routing_enabled    = var.http_application_routing_enabled
  local_account_disabled              = var.local_account_disabled
  disk_encryption_set_id              = var.disk_encryption_set_id
  open_service_mesh_enabled           = var.open_service_mesh_enabled
  role_based_access_control_enabled   = var.role_based_access_control_enabled
  run_command_enabled                 = var.run_command_enabled

  tags = merge(var.tags,
    {
      env        = var.env
      managed_by = "terraform"
    },
  )

  network_profile {
    network_mode       = var.net_profile_network_mode
    network_plugin     = var.net_profile_network_policy == "azure" ? "azure" : var.net_profile_network_plugin
    network_policy     = var.net_profile_network_policy
    dns_service_ip     = var.net_profile_docker_bridge_cidr != null && var.net_profile_service_cidr != null ? var.net_profile_dns_service_ip : null
    docker_bridge_cidr = var.net_profile_dns_service_ip != null && var.net_profile_service_cidr != null ? var.net_profile_docker_bridge_cidr : null
    outbound_type      = var.net_profile_outbound_type
    pod_cidr           = var.net_profile_network_plugin == "kubenet" ? var.net_profile_pod_cidr : null
    service_cidr       = var.net_profile_dns_service_ip != null && var.net_profile_docker_bridge_cidr != null && var.net_profile_network_plugin == "kubenet" ? var.net_profile_service_cidr : null
  }

  linux_profile {
    admin_username = var.admin_username
    ssh_key {
      # remove any new lines using the replace interpolation function
      key_data = replace(var.public_ssh_key, "\n", "")
    }
  }

  dynamic "auto_scaler_profile" {
    for_each = var.custom_auto_scaler_profile ? [1] : []
    content {
      balance_similar_node_groups      = var.balance_similar_node_groups
      expander                         = var.expander
      max_graceful_termination_sec     = var.max_graceful_termination_sec
      max_node_provisioning_time       = var.max_node_provisioning_time
      max_unready_nodes                = var.max_unready_nodes
      max_unready_percentage           = var.max_unready_percentage
      new_pod_scale_up_delay           = var.new_pod_scale_up_delay
      scale_down_delay_after_add       = var.scale_down_delay_after_add
      scale_down_delay_after_delete    = try(var.scale_down_delay_after_delete, var.scan_interval)
      scale_down_delay_after_failure   = var.scale_down_delay_after_failure
      scan_interval                    = var.scan_interval
      scale_down_unneeded              = var.scale_down_unneeded
      scale_down_unready               = var.scale_down_unready
      scale_down_utilization_threshold = var.scale_down_utilization_threshold
      empty_bulk_delete_max            = var.empty_bulk_delete_max
      skip_nodes_with_local_storage    = var.skip_nodes_with_local_storage
      skip_nodes_with_system_pods      = var.skip_nodes_with_system_pods
    }
  }

  dynamic "azure_active_directory_role_based_access_control" {
    for_each = var.managed_ad_rbac == true ? [1] : []
    content {
      managed                = var.managed_ad_rbac
      tenant_id              = var.tenant_id
      admin_group_object_ids = var.managed_ad_rbac == true ? var.admin_group_object_ids : null
      azure_rbac_enabled     = var.managed_ad_rbac == true ? var.azure_rbac_enabled : null
      client_app_id          = var.managed_ad_rbac == false ? var.client_app_id : null
      server_app_id          = var.managed_ad_rbac == false ? var.server_app_id : null
      server_app_secret      = var.managed_ad_rbac == false ? var.server_app_secret : null
    }
  }

  dynamic "default_node_pool" {
    for_each = var.enable_auto_scaling == true ? [] : ["default_node_pool_manually_scaled"]
    content {
      orchestrator_version         = var.kubernetes_version == "" ? var.orchestrator_version : var.kubernetes_version
      name                         = var.node_pool_name
      node_count                   = var.node_count
      vm_size                      = var.vm_size
      os_disk_size_gb              = var.os_disk_size_gb
      vnet_subnet_id               = var.vnet_subnet_id
      enable_auto_scaling          = var.enable_auto_scaling
      node_public_ip_prefix_id     = var.enable_node_public_ip ? var.node_public_ip_prefix_id : null
      enable_node_public_ip        = var.enable_node_public_ip
      node_labels                  = var.node_labels
      type                         = var.agents_type
      only_critical_addons_enabled = var.only_critical_addons_enabled
      kubelet_disk_type            = var.kubelet_disk_type
      tags = merge(var.tags,
        {
          env = var.env
        },
      var.agents_tags)
      max_pods               = var.max_pods
      enable_host_encryption = var.enable_host_encryption
      dynamic "kubelet_config" {
        for_each = var.custom_kubelet_config ? [1] : []
        content {
          container_log_max_line    = var.container_log_max_line
          container_log_max_size_mb = var.container_log_max_size_mb
        }
      }
      dynamic "linux_os_config" {
        for_each = var.swap_file_size_mb != null ? [1] : []
        content {
          swap_file_size_mb = var.swap_file_size_mb
        }
      }
    }
  }

  dynamic "default_node_pool" {
    for_each = var.enable_auto_scaling == true ? ["default_node_pool_auto_scaled"] : []
    content {
      max_count                    = var.max_count
      min_count                    = var.min_count
      orchestrator_version         = var.kubernetes_version == "" ? var.orchestrator_version : var.kubernetes_version
      name                         = var.node_pool_name
      node_count                   = null
      vm_size                      = var.vm_size
      os_disk_size_gb              = var.os_disk_size_gb
      vnet_subnet_id               = var.vnet_subnet_id
      enable_auto_scaling          = var.enable_auto_scaling
      node_public_ip_prefix_id     = var.enable_node_public_ip ? var.node_public_ip_prefix_id : null
      enable_node_public_ip        = var.enable_node_public_ip
      node_labels                  = var.node_labels
      type                         = var.agents_type
      only_critical_addons_enabled = var.only_critical_addons_enabled
      kubelet_disk_type            = var.kubelet_disk_type
      tags = merge(var.tags,
        {
          env = var.env
        },
      var.agents_tags)
      max_pods               = var.max_pods
      enable_host_encryption = var.enable_host_encryption
      dynamic "kubelet_config" {
        for_each = var.custom_kubelet_config ? [1] : []
        content {
          container_log_max_line    = var.container_log_max_line
          container_log_max_size_mb = var.container_log_max_size_mb
        }
      }
      dynamic "linux_os_config" {
        for_each = var.swap_file_size_mb != null ? [1] : []
        content {
          swap_file_size_mb = var.swap_file_size_mb
        }
      }
    }
  }

  dynamic "service_principal" {
    for_each = var.client_id != "" && var.client_secret != "" ? ["service_principal"] : []
    content {
      client_id     = var.client_id
      client_secret = var.client_secret
    }
  }

  dynamic "identity" {
    for_each = var.client_id == "" || var.client_secret == "" ? ["identity"] : []
    content {
      type         = var.identity_type
      identity_ids = var.identity_ids
    }
  }

  dynamic "key_vault_secrets_provider" {
    for_each = var.secret_rotation_enabled != null ? ["KeyVaultSecretProvider"] : []
    content {
      secret_rotation_enabled  = var.secret_rotation_enabled
      secret_rotation_interval = var.secret_rotation_interval
    }
  }

  dynamic "kubelet_identity" {
    for_each = var.enable_kublet_identity ? ["kubelet_identiry"] : []
    content {
      client_id                 = var.kublet_client_id
      object_id                 = var.kubelet_object_id
      user_assigned_identity_id = var.kubelet_user_assigned_identity_id
    }
  }

  dynamic "oms_agent" {
    for_each = var.log_analytics_workspace_id != null ? ["oms_agent"] : []
    content {
      log_analytics_workspace_id = var.log_analytics_workspace_id
    }
  }
}
