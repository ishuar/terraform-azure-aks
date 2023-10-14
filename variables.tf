###################
## Global ########
variable "existing_aks_cluster" {
  type        = bool
  description = "(optional) Is there any existing AKS cluster? fake"
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Tags for the cluster"
  default     = null
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool#vnet_subnet_id
variable "vnet_subnet_id" {
  type        = string
  description = "(optional) The ID of the Subnet where this Node Pool should exist.At this time the vnet_subnet_id must be the same for all node pools in the cluster"
  default     = null
}
###############
## AKS ######
################
variable "name" {
  type        = string
  description = "(Required) The name of the Managed Kubernetes Cluster to create or the existing kubernetes cluster to use with the module"
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Specifies the Resource Group where the new or existing Managed Kubernetes Cluster exists."
}

variable "location" {
  type        = string
  default     = "westeurope"
  description = "(optional) The location where the Managed Kubernetes Cluster should be created."
}

variable "dns_prefix" {
  type        = string
  description = "(optional) Required when dns_prefix_private_cluster is not specified. DNS prefix specified when creating the managed cluster."
  default     = null
}

variable "dns_prefix_private_cluster" {
  type        = string
  description = "(optional) Required when dns_prefix is not specified. Specifies the DNS prefix to use with private clusters."
  default     = null
}

variable "kubernetes_version" {
  type        = string
  description = "(Optional) Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time and will change as per the stable availability of the AKS version. It is also set as orchestrator version of nodepools if not specified."
  default     = ""
}

variable "include_preview" {
  type        = bool
  description = "(Optional) Should Preview versions of Kubernetes in AKS be included? Defaults to false"
  default     = false
}

variable "automatic_channel_upgrade" {
  type        = string
  description = "(Optional) The upgrade channel for this Kubernetes Cluster, see https://docs.microsoft.com/en-us/azure/aks/upgrade-cluster#set-auto-upgrade-channel"
  default     = "node-image"
}

variable "enable_maintenance_window" {
  type        = bool
  description = "(optional) Whether to enable the maintenance window or not?"
  default     = true
}

variable "enable_allowed_maintenance_window" {
  type        = bool
  description = "(optional) Whether to enable the [allowed maintenance window](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#allowed) block or not?"
  default     = true
}

variable "enable_not_allowed_maintenance_window" {
  type        = bool
  description = "(optional) Whether to enable the [not_allowed maintenance window](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#not_allowed) block or not?"
  default     = false
}

variable "allowed_maintenance_window_day" {
  type        = string
  description = "(optional) Required if `enable_allowed_maintenance_window` is set to true. A day in a week. Possible values are `Sunday`, `Monday`, `Tuesday`, `Wednesday`, `Thursday`, `Friday` and `Saturday`"
  default     = "Saturday"
}

variable "allowed_maintenance_window_hours" {
  type        = list(any)
  description = "(optional) Required if `enable_allowed_maintenance_window` is set to true. An array of hour slots in a day. For example, specifying 1 will allow maintenance from 1:00am to 2:00am. Specifying 1, 2 will allow maintenance from 1:00am to 3:00m. Possible values are between 0 and 23"
  default     = [6, 2]
}

variable "not_allowed_maintenance_window_end" {
  type        = string
  description = "(optional) Required if `enable_not_allowed_maintenance_window` is set to true The end of a time span, formatted as an RFC3339 string."
  default     = null
}

variable "not_allowed_maintenance_window_start" {
  type        = string
  description = "(optional) Required if `enable_not_allowed_maintenance_window` is set to true The start of a time span, formatted as an RFC3339 string."
  default     = null
}

variable "network_plugin" {
  type        = string
  description = "(Optional) Network plugin to use for networking."
  default     = "kubenet"
}

variable "network_policy" {
  type        = string
  description = "(Optional) Sets up network policy to be used with Azure CNI."
  default     = "calico"
}

variable "load_balancer_sku" {
  type        = string
  description = " (Optional) Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are basic and standard. Defaults to standard. Changing this forces a new resource to be created."
  default     = "standard"
}

variable "default_node_pool_zones" {
  type        = list(string)
  description = "(Optional) Specifies a list of Availability Zones in which this Kubernetes Cluster should be located. Changing this forces a new Kubernetes Cluster to be created."
  default     = []
}
variable "azure_policy_enabled" {
  type        = bool
  description = "Optional) Should the Azure Policy Add-On be enabled? more info: https://docs.microsoft.com/en-ie/azure/governance/policy/concepts/rego-for-aks"
  default     = false
}

variable "role_based_access_control_enabled" {
  type        = bool
  description = "(Optional) - Whether Role Based Access Control for the Kubernetes Cluster should be enabled."
  default     = true
}
variable "disk_encryption_set_id" {
  type        = string
  description = "(Optional) The ID of the Disk Encryption Set which should be used for the Nodes and Volumes."
  default     = null
}

variable "http_application_routing_enabled" {
  type        = bool
  description = "(Optional) Should HTTP Application Routing be enabled?"
  default     = null
}

# preview feature, see additionally https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#http_proxy_config
# and https://docs.microsoft.com/en-us/azure/aks/http-proxy
variable "http_proxy_config" {
  type        = any
  description = "Proxy config: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#http_proxy"
  default     = null
}

variable "local_account_disabled" {
  type        = bool
  description = "(Optional) - If true local accounts will be disabled. Defaults to false. see https://docs.microsoft.com/en-us/azure/aks/managed-aad#azure-ad-authentication-overview"
  default     = null
}

# preview feature
variable "enable_microsoft_defender" {
  type        = bool
  description = "(Optional) whether to enable the microsoft defender or not ,ref: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#microsoft_defender"
  default     = false
}

variable "node_resource_group" {
  type        = string
  description = "(Optional) The name of the Resource Group where the Kubernetes Nodes should exist."
  default     = null
}

#preview feature
variable "oidc_issuer_enabled" {
  type        = bool
  description = "(Optional) Enable or Disable the OIDC issuer URL"
  default     = null
}

variable "workload_identity_enabled" {
  type        = bool
  description = "(Optional) Specifies whether Azure AD Workload Identity should be enabled for the Cluster. Defaults to false"
  default     = null
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "(Optional) Specifies the ID of the Log Analytics Workspace where the audit logs collected by Microsoft Defender & OMS agent should be sent to"
  default     = null
}

variable "outbound_type" {
  type        = string
  description = "(Optional) The outbound (egress) routing method which should be used for this Kubernetes Cluster."
  default     = null
}
variable "open_service_mesh_enabled" {
  type        = bool
  description = "(Optional) Is Open Service Mesh enabled? more info: https://docs.microsoft.com/azure/aks/open-service-mesh-about"
  default     = null
}

variable "private_cluster_enabled" {
  type        = bool
  description = "(Optional) Should this Kubernetes Cluster have its API server only exposed on internal IP addresses?"
  default     = null
}

variable "private_dns_zone_id" {
  type        = string
  description = "(Optional) Either the ID of Private DNS Zone which should be delegated to this Cluster, System to have AKS manage this or None, see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#private_dns_zone_id"
  default     = null
}
variable "private_cluster_public_fqdn_enabled" {
  type        = bool
  description = "(optional)  Specifies whether a Public FQDN for this Private Cluster should be added."
  default     = null
}

variable "run_command_enabled" {
  type        = bool
  description = "(Optional) Whether to enable run command for the cluster or not?"
  default     = true
}

variable "sku_tier" {
  type        = string
  description = "(Optional) The SKU Tier that should be used for this Kubernetes Cluster"
  default     = null
}

variable "pod_cidr" {
  type        = string
  description = "(Optional) The CIDR to use for pod IP addresses."
  default     = null
}

variable "service_cidr" {
  type        = string
  description = " (Optional) The Network Range used by the Kubernetes service."
  default     = null
}

variable "dns_service_ip" {
  type        = string
  description = "(Optional) IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns)."
  default     = null
}

variable "docker_bridge_cidr" {
  type        = string
  description = "(Optional) IP address (in CIDR notation) used as the Docker bridge IP address on nodes. **NOTE**: docker_bridge_cidr has been deprecated as the API no longer supports it and will be removed in version 4.0 of the provider."
  default     = null
}

variable "enable_api_server_access_profile" {
  type        = bool
  description = "(Optional) Whether to enable API server access profile or not?"
  default     = false
}

variable "api_server_authorized_ip_ranges" {
  type        = set(string)
  description = "(Optional) Set of authorized IP ranges to allow access to API server."
  default     = null
}

variable "api_server_access_profile_subnet_id" {
  type        = string
  description = "(Optional) The ID of the Subnet where the API server endpoint is delegated to."
  default     = null
}

variable "vnet_integration_enabled" {
  type        = bool
  description = "Should API Server VNet Integration be enabled? For more details please visit [Use API Server VNet Integration.](https://learn.microsoft.com/en-us/azure/aks/api-server-vnet-integration)"
  default     = false
}

variable "image_cleaner_enabled" {
  type        = bool
  description = "(Optional) Specifies whether Image Cleaner is enabled."
  default     = false
}

variable "image_cleaner_interval_hours" {
  type        = number
  description = " (Optional) Specifies the interval in hours when images should be cleaned up."
  default     = null
}

variable "pod_cidrs" {
  type        = list(string)
  description = "(Optional) A list of CIDRs to use for pod IP addresses. For single-stack networking a single IPv4 CIDR is expected. For dual-stack networking an IPv4 and IPv6 CIDR are expected. Changing this forces a new resource to be created."
  default     = null
}

variable "service_cidrs" {
  type        = list(string)
  description = "(Optional) A list of CIDRs to use for Kubernetes services. For single-stack networking a single IPv4 CIDR is expected. For dual-stack networking an IPv4 and IPv6 CIDR are expected. Changing this forces a new resource to be created."
  default     = null
}

variable "ebpf_data_plane" {
  type        = string
  description = "(Optional) Specifies the eBPF data plane used for building the Kubernetes network. Possible value is cilium. Changing this forces a new resource to be created."
  default     = null
}

variable "network_plugin_mode" {
  type        = string
  description = "(Optional) Specifies the network plugin mode used for building the Kubernetes network. Possible value is overlay. Changing this forces a new resource to be created."
  default     = null
}

variable "blob_driver_enabled" {
  type        = bool
  description = "(Optional) Is the Blob CSI driver enabled? Defaults to false"
  default     = false
}
variable "disk_driver_enabled" {
  description = "(Optional) Is the Disk CSI driver enabled? Defaults to true."
  type        = bool
  default     = true
}
variable "disk_driver_version" {
  description = "(Optional) Disk CSI Driver version to be used. Possible values are v1 and v2. Defaults to v1."
  type        = string
  default     = "v1"
}
variable "file_driver_enabled" {
  description = "(Optional) Is the File CSI driver enabled? Defaults to true."
  type        = bool
  default     = true
}
variable "snapshot_controller_enabled" {
  description = "(Optional) Is the Snapshot Controller enabled? Defaults to true."
  type        = bool
  default     = true
}
############
# AAD RBAC #
############
variable "aad_rbac_enabled" {
  type        = bool
  description = "(Optional)If AAD RBAC should be enabled"
  default     = false
}

variable "aad_rbac_managed" {
  type        = bool
  description = "(Optional) Is the Azure Active Directory integration Managed, meaning that Azure will create/manage the Service Principal used for integration"
  default     = true
}

variable "aad_azure_rbac_enabled" {
  type        = bool
  description = "(Optional) Is Role Based Access Control based on Azure AD enabled?"
  default     = null
}

variable "aad_rbac_managed_admin_group_ids" {
  type        = list(string)
  description = "(Optional) A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster."
  default     = null
}

variable "aad_rbac_unmanaged_client_app_id" {
  type        = string
  description = "(Optional) Required if aad_rbac_managed = false. The Client ID of an Azure Active Directory Application. "
  default     = null
}

variable "aad_rbac_unmanaged_server_app_id" {
  type        = string
  description = "(Optional) Required if aad_rbac_managed = false. The Server ID of an Azure Active Directory Application."
  default     = null
}

variable "aad_rbac_unmanaged_server_app_secret" {
  type        = string
  description = "(Optional) Required if aad_rbac_managed = false. The Server Secret of an Azure Active Directory Application."
  default     = null
}
##############
## Identity #
##############
variable "identity_type" {
  type        = string
  description = "(optional) Specifies the type of Managed Service Identity that should be configured on this Kubernetes Cluster."
  default     = "SystemAssigned"
}
variable "identity_ids" {
  type        = set(string)
  description = "(optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Kubernetes Cluster"
  default     = null
}
#####################
# default node pool #
#####################
variable "default_node_pool_name" {
  type        = string
  description = "(Optional) Required when `existing_aks_cluster` is set to false. The name which should be used for the default Kubernetes Node Pool."
  default     = ""
}

variable "default_node_pool_vm_size" {
  type        = string
  description = "(optional) The size of the Virtual Machine, such as Standard_DS2_v2."
  default     = "Standard_DS2_v2"
}

variable "default_node_pool_node_count" {
  type        = number
  description = "(Optional) Required when `default_node_pool_enable_auto_scaling` is set to false. The number of nodes which should exist in default Node Pool."
  default     = null
}

variable "default_node_pool_max_count" {
  type        = number
  description = "(Optional) Required when `default_node_pool_enable_auto_scaling` is set to true. The maximum number of nodes which should exist in this Node Pool."
  default     = null
}

variable "default_node_pool_min_count" {
  type        = number
  description = "(Optional) Required when `default_node_pool_enable_auto_scaling` is set to true. The minimum number of nodes which should exist in this Node Pool."
  default     = null
}

variable "default_node_pool_tags" {
  type        = map(string)
  description = "(Optional) Tags for the node pool"
  default     = null
}

variable "default_node_pool_enable_auto_scaling" {
  type        = bool
  description = "(Optional) Should the Kubernetes Auto Scaler be enabled for this Node Pool?"
  default     = null
}

variable "default_node_pool_enable_host_encryption" {
  type        = bool
  description = "(Optional) Should the nodes in the Default Node Pool have host encryption enabled?"
  default     = null
}

variable "default_node_pool_enable_node_public_ip" {
  type        = bool
  description = "(Optional) Should nodes in this Node Pool have a Public IP Address?"
  default     = null
}

variable "default_node_pool_fips_enabled" {
  type        = bool
  description = "(Optional) Should the nodes in this Node Pool have Federal Information Processing Standard enabled?"
  default     = null
}

variable "default_node_pool_kubelet_disk_type" {
  type        = string
  description = "(Optional) The type of disk used by kubelet. Possible values are OS and Temporary.'"
  default     = "OS"
  validation {
    condition     = var.default_node_pool_kubelet_disk_type == "OS" || var.default_node_pool_kubelet_disk_type == "Temporary"
    error_message = "Allowed values are : 'OS'(default), 'Temporary'."
  }
}

variable "default_node_pool_public_ip_prefix_id" {
  type        = string
  description = "(Optional) Resource ID for the Public IP Addresses Prefix for the nodes in this Node Pool."
  default     = null
}

variable "default_node_pool_node_labels" {
  type        = map(string)
  description = "(Optional) A map of Kubernetes labels which should be applied to nodes in the Default Node Pool."
  default     = null
}

variable "default_node_pool_only_critical_addons_enabled" {
  type        = bool
  description = "(Optional) Enabling this option will taint default node pool with CriticalAddonsOnly=true:NoSchedule taint"
  default     = false
}

variable "default_node_pool_os_disk_size_gb" {
  type        = number
  description = "(Optional) The size of the OS Disk which should be used for each agent in the default Node Pool."
  default     = 64
}

variable "default_node_pool_os_disk_type" {
  type        = string
  description = "(Optional) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed"
  default     = null
  validation {
    condition     = var.default_node_pool_os_disk_type == "Managed" || var.default_node_pool_os_disk_type == "Ephemeral" || var.default_node_pool_os_disk_type == null
    error_message = "Allowed values are: 'Managed'(default), 'Ephemeral'."
  }
}
variable "default_node_pool_os_sku" {
  type        = string
  description = " (Optional) OsSKU to be used to specify Linux OSType. Not applicable to Windows OSType."
  default     = null
}

variable "default_node_pool_ultra_ssd_enabled" {
  type        = bool
  description = "(Optional) Used to specify whether the UltraSSD is enabled in the Default Node Pool."
  default     = null
}

variable "default_node_pool_upgrade_max_surge" {
  type        = string
  description = "(Optional) The maximum number or percentage of nodes which will be added to the Node Pool size during an upgrade. ref : https://registry.terraform.io/providers/hashicorp/azurerm/3.9.0/docs/resources/kubernetes_cluster#max_surge"
  default     = "2"
}

variable "default_node_pool_max_pods" {
  type        = string
  description = "(Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created."
  default     = null
}

variable "default_node_pool_proximity_placement_group_id" {
  type        = string
  description = "(Optional) The ID of the Proximity Placement Group. Changing this forces a new resource to be created."
  default     = null
}
variable "default_node_pool_workload_runtime" {
  type        = string
  description = "(Optional) Specifies the workload runtime used by the node pool. Possible values are OCIContainer and KataMshvVmIsolation"
  default     = null
}
variable "default_node_pool_message_of_the_day" {
  type        = string
  description = "(Optional) A base64-encoded string which will be written to /etc/motd after decoding. This allows customization of the message of the day for Linux nodes. It cannot be specified for Windows nodes and must be a static string (i.e. will be printed raw and not executed as a script). Changing this forces a new resource to be created"
  default     = null
}
#######################
# auto scaler profile #
#######################

##TODO: Add this later.
# variable "auto_scaler_profile" {
#   type        = any
#   description = "Settings for auto scaling, see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#balance_similar_node_groups"
#   default     = null
# }

###############################
# ingress application gateway #
###############################

variable "ingress_app_gw_enabled" {
  type        = bool
  description = "If the Ingress Application Gateway is should be enabled or not?"
  default     = false
}

variable "ingress_app_gw_id" {
  type        = string
  description = "(Optional) The ID of the Application Gateway to integrate with the ingress controller of this Kubernetes Cluster, ref:  https://docs.microsoft.com/en-us/azure/application-gateway/tutorial-ingress-controller-add-on-existing"
  default     = null
}

variable "ingress_app_gw_name" {
  type        = string
  description = "(Optional) The name of the Application Gateway to be used or created in the Nodepool Resource Group, which in turn will be integrated with the ingress controller of this Kubernetes Cluster, ref: https://docs.microsoft.com/azure/application-gateway/tutorial-ingress-controller-add-on-new"
  default     = null
}

variable "ingress_app_gw_subnet_cidr" {
  type        = string
  description = "(Optional) The subnet CIDR to be used to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster, ref: https://docs.microsoft.com/azure/application-gateway/tutorial-ingress-controller-add-on-new"
  default     = null
}

variable "ingress_app_gw_subnet_id" {
  type        = string
  description = "(Optional) The ID of the subnet on which to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster, ref: https://docs.microsoft.com/azure/application-gateway/tutorial-ingress-controller-add-on-new"
  default     = null
}

##############################
# key vault secrets provider #
##############################

variable "key_vault_secrets_provider_enabled" {
  type        = bool
  description = "(Optional) If the secrets provider should be enabled"
  default     = false
}

variable "key_vault_secrets_provider_secret_rotation_enabled" {
  type        = bool
  description = "(Optional) Is secret rotation enabled?"
  default     = false
}

variable "key_vault_secrets_provider_secret_rotation_interval" {
  type        = string
  description = "(Optional) The interval to poll for secret rotation. This attribute is only set when secret_rotation is true and defaults to 2m."
  default     = null
}

#######################
# Kubelet Identity
#######################
variable "kubelet_identity_enabled" {
  type        = bool
  description = "(optional) If kubelet identity should be enabled"
  default     = false
}
variable "kubelet_identity_client_id" {
  type        = string
  description = "(Optional) The Client ID of the user-defined Managed Identity to be assigned to the Kubelets. If not specified a Managed Identity is created automatically.Can be also specified when kubelet_identity is true"
  default     = null
}
variable "kubelet_identity_object_id" {
  type        = string
  description = "(optional) The Object ID of the user-defined Managed Identity assigned to the Kubelets.If not specified a Managed Identity is created automatically.Can be also specified when kubelet_identity is true"
  default     = null
}
variable "kubelet_identity_user_assigned_identity_id" {
  type        = string
  description = "(optional) The ID of the User Assigned Identity assigned to the Kubelets. If not specified a Managed Identity is created automatically.Can be also specified when kubelet_identity is true"
  default     = null
}

#####################
# Windows Profilel #
#####################

variable "windows_profile_enabled" {
  type        = bool
  description = "(optional) Is windows profile enabled?"
  default     = false
}

variable "windows_profile_admin_username" {
  type        = string
  description = "(optional) The Admin Username for Windows VMs. (Required) if windows_profile_enabled is true."
  default     = "azureadmin"
}
variable "windows_profile_admin_password" {
  type        = string
  description = "(optional) The Admin Password for Windows VMs.(Required) if windows_profile_enabled is true."
  default     = "Super$ecUreP@$$w04d"
  sensitive   = true
  validation {
    condition     = length(var.windows_profile_admin_password) >= 14 && length(var.windows_profile_admin_password) <= 123
    error_message = "The Length of windows_profile_admin_password must be between 14 and 123 characters."
  }
}
variable "windows_profile_license" {
  type        = string
  description = "(optional)Specifies the type of on-premise license which should be used for Node Pool Windows Virtual Machine"
  default     = "Windows_Server"
}
##############################
# Additional Node Pool #
##############################

variable "additional_node_pools" {
  type        = any
  description = "(optional) Additional node pool configuration for the aks cluster, ref to module for all inputs possible."
  default     = {}
}

variable "kubernetes_cluster_id" {
  type        = string
  description = "(optional) Kubernetes Cluster ID of the existing aks cluster"
  default     = ""
}

###################
# Linux Profile #
###################
variable "admin_username" {
  type        = string
  description = "(optional) The Admin Username for the Cluster. Changing this forces a new resource to be created."
  default     = "aks-admin"
}
variable "key_data" {
  type        = string
  description = "(optional) The Admin Username for the Cluster. Changing this forces a new resource to be created.) An ssh_key block.Only one is currently allowed. Changing this will update the key on all node pools. More information can be found in the [documentation](https://learn.microsoft.com/en-us/azure/aks/node-access#update-ssh-key-on-an-existing-aks-cluster-preview)."
  default     = ""
}

################################
# Monitor Diagnostic Variables #
#################################

variable "enable_cluster_log_monitor_diagnostic" {
  type        = bool
  description = "(optional) Whether to enable the log monitor diagnostic for Azure Kubernetes cluster or not?"
  default     = false
}

variable "enable_cluster_all_category_group_log" {
  type        = bool
  description = "(optional) Whether to enable all category group log for Azure Kubernetes cluster or not?"
  default     = false
}

variable "enable_cluster_audit_category_group_log" {
  type        = string
  description = "(optional) Whether to enable only audit category group log for Azure Kubernetes cluster or not?"
  default     = true
}

variable "enable_cluster_custom_categories_log" {
  type        = string
  description = "(optional) Whether to enable custom categories log for Azure Kubernetes cluster or not?"
  default     = false
}

variable "enable_cluster_all_metrics" {
  type        = bool
  description = "(optional) Whether to enable all metrics for diagnostics for Azure Kubernetes cluster or not?"
  default     = false
}

variable "cluster_custom_log_categories" {
  type        = list(string)
  description = "(optional) A list of strings with supported category groups for Azure Kubernetes cluster log monitoring diagnostics"
  default     = []
}
variable "monitor_diagnostic_storage_account_id" {
  type        = string
  description = "(optional) The ID of the Storage Account where logs should be sent."
  default     = null
}

variable "eventhub_name" {
  type        = string
  description = "(optional) Specifies the name of the Event Hub where Diagnostics Data should be sent."
  default     = null
}

variable "eventhub_authorization_rule_id" {
  type        = string
  description = "(optional) Specifies the ID of an Event Hub Namespace Authorization Rule used to send Diagnostics Data."
  default     = null
}

variable "monitor_diagnostic_log_analytics_workspace_id" {
  type        = string
  description = "(optional) Specifies the ID of a Log Analytics Workspace where Diagnostics Data should be sent."
  default     = null
}

variable "monitor_diagnostic_log_analytics_destination_type" {
  type        = string
  description = "(optional)  Possible values are AzureDiagnostics and Dedicated. When set to Dedicated, logs sent to a Log Analytics workspace will go into resource specific tables, instead of the legacy AzureDiagnostics table"
  default     = null
}

variable "partner_solution_id" {
  type        = string
  description = "(optional) The ID of the market partner solution where Diagnostics Data should be sent. For potential partner integrations, click to learn more about partner integration."
  default     = null
}

# ####################################
# # FluxCD AKS Extension #
# ####################################

variable "enable_fluxcd" {
  type        = bool
  description = "(optional) Whether to enable fluxcd extension(GitOps) or not ?"
  default     = false
}

variable "fluxcd_extension_name" {
  type        = string
  description = "(optional)Specifies the name which should be used for this Kubernetes Cluster Extension. Changing this forces a new Kubernetes Cluster Extension to be created."
  default     = "fluxcd"
}

variable "fluxcd_extension_release_train" {
  type        = string
  description = "(Optional) The release train used by this extension. Possible values include but are not limited to Stable, Preview. Changing this forces a new Kubernetes Cluster Extension to be created."
  default     = null
}

variable "fluxcd_extension_release_namespace" {
  type        = string
  description = "(Optional) Namespace where the extension release must be placed for a cluster scoped extension. If this namespace does not exist, it will be created. Changing this forces a new Kubernetes Cluster Extension to be created."
  default     = null
}

variable "fluxcd_extension_target_namespace" {
  type        = string
  description = "(Optional) Namespace where the extension will be created for a namespace scoped extension. If this namespace does not exist, it will be created. Changing this forces a new Kubernetes Cluster Extension to be created."
  default     = null
}

variable "fluxcd_extension_version" {
  type        = string
  description = "(Optional) User-specified version that the extension should pin to. If it is not set, Azure will use the latest version and auto upgrade it. Changing this forces a new Kubernetes Cluster Extension to be created."
  default     = null
}

variable "fluxcd_extension_configuration_protected_settings" {
  type        = map(string)
  description = "(optional) Configuration settings that are sensitive, as name-value pairs for configuring this extension"
  default     = {}
}

variable "fluxcd_extension_configuration_settings" {
  type        = map(string)
  description = "(Optional) Configuration settings, as name-value pairs for configuring this extension."
  default     = {}
}


variable "fluxcd_configuration_name" {
  type        = string
  description = "(Optional) Specifies the name which should be used for this Kubernetes Flux Configuration. Required if `enable_fluxcd` is true. Changing this forces a new Kubernetes Flux Configuration to be created."
  default     = null
}

variable "fluxcd_namespace" {
  type        = string
  description = "(Optional) Specifies the namespace to which this configuration is installed to. Required if `enable_fluxcd` is true. Changing this forces a new Kubernetes Flux Configuration to be created."
  default     = null
}
variable "fluxcd_scope" {
  type        = string
  description = "(Optional) Specifies the scope at which the operator will be installed. Possible values are cluster and namespace. Defaults to namespace. Changing this forces a new Kubernetes Flux Configuration to be created."
  default     = null
}
variable "fluxcd_continuous_reconciliation_enabled" {
  type        = bool
  description = "(Optional) Whether the configuration will keep its reconciliation of its kustomizations and sources with the repository. Defaults to true."
  default     = null
}

#######################
# FluxCD Git Repository
#######################
#? ref: https://fluxcd.io/flux/components/source/gitrepositories/
variable "fluxcd_git_repository_url" {
  type        = string
  description = "(Optional) Specifies the URL to sync for the flux configuration git repository. It must start with http://, https://, git@ or ssh://. Required if `enable_fluxcd` is true"
  default     = ""
}

variable "fluxcd_git_repository_reference_type" {
  type        = string
  description = "(Optional) Specifies the source reference type for the GitRepository object. Possible values are branch, commit, semver and tag."
  default     = "branch"
}

variable "fluxcd_git_repository_reference_value" {
  type        = string
  description = "(Optional) Specifies the source reference value for the GitRepository object."
  default     = "main"
}

variable "fluxcd_git_repository_https_ca_cert_base64" {
  type        = string
  description = "(Optional) Specifies the Base64-encoded HTTPS certificate authority contents used to access git private git repositories over HTTPS."
  default     = null
}

variable "fluxcd_git_repository_https_user" {
  type        = string
  description = "(Optional) Specifies the plaintext HTTPS username used to access private git repositories over HTTPS."
  default     = null
}

variable "fluxcd_git_repository_https_key_base64" {
  type        = string
  description = "(Optional) Specifies the Base64-encoded HTTPS personal access token or password that will be used to access the repository."
  default     = null
}

variable "fluxcd_git_repository_local_auth_reference" {
  type        = string
  description = "(Optional) Specifies the name of a local secret on the Kubernetes cluster to use as the authentication secret rather than the managed or user-provided configuration secrets. It must be between 1 and 63 characters. It can contain only lowercase letters, numbers, and hyphens (-). It must start and end with a lowercase letter or number."
  default     = null
}

variable "fluxcd_blob_storage_sas_token" {
  type        = string
  description = "(Optional) Specifies the shared access token to access the storage container."
  default     = null
}

variable "fluxcd_git_repository_ssh_private_key_base64" {
  type        = string
  description = "(Optional) Specifies the Base64-encoded SSH private key in PEM format."
  default     = null
}

variable "fluxcd_git_repository_ssh_known_hosts_base64" {
  type        = string
  description = "(Optional) Specifies the Base64-encoded known_hosts value containing public SSH keys required to access private git repositories over SSH."
  default     = null
}

variable "fluxcd_git_repository_sync_interval_in_seconds" {
  type        = number
  description = "(Optional) Specifies the interval at which to re-reconcile the cluster git repository source with the remote. Defaults to 600."
  default     = null
}

variable "fluxcd_git_repository_timeout_in_seconds" {
  type        = number
  description = "(Optional) Specifies the maximum time to attempt to reconcile the cluster git repository source with the remote. Defaults to 600."
  default     = null
}

#######################
# FluxCD Kustomizations
#######################

variable "kustomizations" {
  type = list(object({
    path                       = optional(string)
    name                       = optional(string)
    timeout_in_seconds         = optional(number)
    sync_interval_in_seconds   = optional(number)
    recreating_enabled         = optional(bool)
    garbage_collection_enabled = optional(bool)
    retry_interval_in_seconds  = optional(number)
    depends_on                 = optional(list(string))
  }))

  description = "(optional) FluxCD Kustomization Configurations. `name` is Required if `enable_fluxcd` is true"
  default     = []
}

#######################
# FluxCD blob Storage
#######################

variable "fluxcd_blob_storage_container_id" {
  type        = string
  description = "(Required) Specifies the Azure Blob container ID."
  default     = ""
}

variable "fluxcd_blob_storage_account_key" {
  type        = string
  description = "(Optional) Specifies the account key (shared key) to access the storage account."
  default     = null
}

variable "fluxcd_blob_storage_local_auth_reference" {
  type        = string
  description = "(Optional) Specifies the name of a local secret on the Kubernetes cluster to use as the authentication secret rather than the managed or user-provided configuration secrets."
  default     = null
}

variable "fluxcd_blob_storage_sync_interval_in_seconds" {
  type        = number
  description = "(Optional) Specifies the interval at which to re-reconcile the cluster Azure Blob source with the remote."
  default     = null
}

variable "fluxcd_blob_storage_timeout_in_seconds" {
  type        = number
  description = "(Optional) Specifies the maximum time to attempt to reconcile the cluster Azure Blob source with the remote."
  default     = null
}

variable "fluxcd_blob_storage_ssas_token" {
  type        = string
  description = "(Optional) Specifies the shared access token to access the storage container."
  default     = null
}

###########################
## blob Storage Identities
###########################
variable "fluxcd_blob_storage_managed_identity_client_id" {
  type        = string
  description = "(Required) Specifies the client ID for authenticating a Managed Identity."
  default     = ""
}

variable "fluxcd_blob_storage_service_principal_client_id" {
  type        = string
  description = "(Required) Specifies the client ID for authenticating a Service Principal."
  default     = ""
}

variable "fluxcd_blob_storage_service_principal_tenant_id" {
  type        = string
  description = "(Required) Specifies the tenant ID for authenticating a Service Principal."
  default     = ""
}
variable "fluxcd_blob_storage_service_principal_client_certificate_base64" {
  type        = string
  description = "(Optional) Base64-encoded certificate used to authenticate a Service Principal ."
  default     = null
}

variable "fluxcd_blob_storage_service_principal_client_certificate_password" {
  type        = string
  description = "(Optional) Specifies the password for the certificate used to authenticate a Service Principal ."
  default     = null
  sensitive   = true
}

variable "fluxcd_blob_storage_service_principal_client_certificate_send_chain" {
  type        = string
  description = "(Optional) Specifies whether to include x5c header in client claims when acquiring a token to enable subject name / issuer based authentication for the client certificate."
  default     = null
}

variable "fluxcd_blob_storage_service_principal_client_secret" {
  type        = string
  description = "(Optional) Specifies the client secret for authenticating a Service Principal."
  default     = null
  sensitive   = true
}

#######################
# FluxCD S3 Bucket
#######################

variable "enable_fluxcd_bucket" {
  type        = bool
  description = "(optional) Whether to enable fluxcd S3 bucket or not?"
  default     = false
}

variable "fluxcd_bucket_name" {
  type        = string
  description = "(Optional) Specifies the bucket name to sync from the url endpoint for the flux configuration. Required if `enable_fluxcd_bucket` is true."
  default     = ""
}

variable "fluxcd_bucket_url" {
  type        = string
  description = "(Optional) Specifies the URL to sync for the flux configuration S3 bucket. It must start with http:// or https://. Required if `enable_fluxcd_bucket` is true."
  default     = ""
}
variable "fluxcd_bucket_access_key" {
  type        = string
  description = "(Optional) Specifies the plaintext access key used to securely access the S3 bucket."
  default     = null
}

variable "fluxcd_bucket_secret_key_base64" {
  type        = string
  description = "(Optional) Specifies the Base64-encoded secret key used to authenticate with the bucket source."
  default     = null
  sensitive   = true
}
variable "fluxcd_bucket_tls_enabled" {
  type        = bool
  description = "(Optional) Specify whether to communicate with a bucket using TLS is enabled. Defaults to true."
  default     = null
}
variable "fluxcd_bucket_local_auth_reference" {
  type        = string
  description = "(Optional) Specifies the name of a local secret on the Kubernetes cluster to use as the authentication secret rather than the managed or user-provided configuration secrets. It must be between 1 and 63 characters. It can contain only lowercase letters, numbers, and hyphens (-). It must start and end with a lowercase letter or number."
  default     = null
}

variable "fluxcd_bucket_sync_interval_in_seconds" {
  type        = number
  description = "(Optional) Specifies the interval at which to re-reconcile the cluster git repository source with the remote. Defaults to 600."
  default     = null
}

variable "fluxcd_bucket_timeout_in_seconds" {
  type        = number
  description = "(Optional) Specifies the maximum time to attempt to reconcile the cluster git repository source with the remote. Defaults to 600."
  default     = null
}

variable "enable_fluxcd_az_providers" {
  type        = bool
  description = "(optional) Whether to register the azure provider to kubernetes and container namespaces. **Warning** This is an experimental feature only."
  default     = false
}
