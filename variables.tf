###################
## Global ########
variable "existing_aks_cluster" {
  type        = bool
  description = "(optional) Is there any existing AKS cluster?"
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
  description = "(Required) The name of the Managed Kubernetes Cluster to create."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Specifies the Resource Group where the Managed Kubernetes Cluster should exist."
}

variable "location" {
  type        = string
  default     = "westeurope"
  description = "(optional) The location where the Managed Kubernetes Cluster should be created."
}

variable "dns_prefix" {
  type        = string
  description = "(optional) DNS prefix specified when creating the managed cluster.(Required) When dns_prefix_private_cluster is not specif"
  default     = null
}
variable "dns_prefix_private_cluster" {
  type        = string
  description = "(optional) Specifies the DNS prefix to use with private clusters.(Required) When dns_prefix is not specified."
  default     = null
}

variable "kubernetes_version" {
  type        = string
  description = "(Optional) Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade)."
  default     = null
}
variable "automatic_channel_upgrade" {
  type        = string
  description = "(Optional) The upgrade channel for this Kubernetes Cluster, see https://docs.microsoft.com/en-us/azure/aks/upgrade-cluster#set-auto-upgrade-channel"
  default     = "node-image"
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

variable "api_server_authorized_ip_ranges" {
  type        = set(string)
  description = "(Optional) The IP ranges to allow for incoming traffic to the server nodes."
  default     = null
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
variable "public_network_access_enabled" {
  type        = bool
  description = "(Optional) Whether public network access is allowed for this Kubernetes Cluster."
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
  description = "(Optional) IP address (in CIDR notation) used as the Docker bridge IP address on nodes"
  default     = null
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
  description = "(Optional) The Client ID of an Azure Active Directory Application. required if aad_rbac_managed = false"
  default     = null
}

variable "aad_rbac_unmanaged_server_app_id" {
  type        = string
  description = "(Optional) The Server ID of an Azure Active Directory Application, required if aad_rbac_managed = false"
  default     = null
}

variable "aad_rbac_unmanaged_server_app_secret" {
  type        = string
  description = "(Optional) The Server Secret of an Azure Active Directory Application., required if aad_rbac_managed = false"
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
  description = "(Required) The name which should be used for the default Kubernetes Node Pool."
}

variable "default_node_pool_vm_size" {
  type        = string
  description = "(optional) The size of the Virtual Machine, such as Standard_DS2_v2."
  default     = "Standard_B1ls"
}

variable "default_node_pool_node_count" {
  type        = number
  description = "(Required) The number of nodes which should exist in default Node Pool"
}

variable "default_node_pool_max_count" {
  type        = number
  description = "(Optional) The maximum number of nodes which should exist in this Node Pool. (Required) If autoscaling is enabled, the maximum number of nodes"
  default     = null
}

variable "default_node_pool_min_count" {
  type        = number
  description = "(Optional) The minimum number of nodes which should exist in this Node Pool. (Required) If autoscaling is enabled, the maximum number of nodes"
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

#######################
# auto scaler profile #
#######################

##  Need to add once this is really required
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

