#####
##Global Cluster Vars###
#####
variable "cluster_name" {
  type        = string
  description = "(Required) The name of the Managed Kubernetes Cluster to create."
}
variable "location" {
  type        = string
  description = " (Required) The location where the Managed Kubernetes Cluster should be created"
}
variable "kubernetes_version" {
  type        = string
  description = "(optional) describe your variable"
}
variable "resource_group_name" {
  type        = string
  description = "(Required) Specifies the Resource Group where the Managed Kubernetes Cluster should exist"
}
variable "dns_prefix" {
  type        = string
  description = "(Optional) DNS prefix specified when creating the managed cluster."
  default     = null
}
variable "dns_prefix_private_cluster" {
  type        = string
  description = "(Optional) Specifies the DNS prefix to use with private clusters"
  default     = null
}
variable "automatic_channel_upgrade" {
  type        = string
  description = "(Optional) The upgrade channel for this Kubernetes Cluster."
  default     = "stable"
}
variable "api_server_authorized_ip_ranges" {
  type        = string
  description = "Optional) The IP ranges to allow for incoming traffic to the server nodes."
  default     = null
}
variable "kubernetes_version" {
  type        = string
  description = "(optional) Version of Kubernetes specified when creating the AKS managed cluster."
  default     = "1.24"
}
variable "node_resource_group" {
  type        = string
  description = "(Optional) The name of the Resource Group where the Kubernetes Nodes should exist. Azure requires that a new, non-existent Resource Group is used, as otherwise the provisioning of the Kubernetes Service will fail"
  default     = "rg-aks-nodes-euw"
}
variable "sku_tier" {
  type        = string
  description = "(Optional) The SKU Tier that should be used for this Kubernetes Cluster"
  default     = "Free"
}
variable "private_cluster_enabled" {
  type        = bool
  description = "(Optional) Should this Kubernetes Cluster have its API server only exposed on internal IP addresses?"
  default     = false
}
variable "private_dns_zone_id" {
  type        = string
  description = "(Optional) Either the ID of Private DNS Zone which should be delegated to this Cluster, System to have AKS manage this or None"
  default     = "System"
}
variable "private_cluster_public_fqdn_enabled" {
  type        = bool
  description = "(Optional) Specifies whether a Public FQDN for this Private Cluster should be added."
  default     = false
}
variable "azure_policy_enabled" {
  type        = bool
  description = "(Optional) Should the Azure Policy Add-On be enabled?"
  default     = false
}
variable "http_application_routing_enabled" {
  type        = bool
  description = "(Optional) Should HTTP Application Routing be enabled?"
  default     = false
}

variable "local_account_disabled" {
  type        = bool
  description = " (Optional) - If true local accounts will be disabled."
  default     = false
}
variable "disk_encryption_set_id" {
  type        = string
  description = "Optional) The ID of the Disk Encryption Set which should be used for the Nodes and Volumes."
  default     = null
}
variable "open_service_mesh_enabled" {
  type        = bool
  description = "(Optional) Is Open Service Mesh enabled?"
  default     = null
}
variable "role_based_access_control_enabled" {
  type        = bool
  description = "(Optional) - Whether Role Based Access Control for the Kubernetes Cluster should be enabled."
  default     = true
}
variable "run_command_enabled" {
  type        = bool
  description = "(Optional) Whether to enable run command for the cluster or not."
  default     = true
}
variable "tags" {
  type        = map(string)
  description = "(Optional) Tags needs to be attached to the cluster"
  default = {
    managed_by = "terraform"
  }
}
variable "env" {
  type        = string
  description = "(Optional) Env in which AKS is deployed"
  default     = "dev"
}

########
##Network Profile Vars ###
########

variable "net_profile_network_plugin" {
  type        = string
  description = "(Required) Network plugin to use for networking."
  default     = "kubenet"
}
variable "net_profile_network_mode" {
  type        = string
  description = "(Optional) Network mode to be used with Azure CNI."
  default     = null
}
variable "net_profile_network_policy" {
  type        = string
  description = " (Optional) Sets up network policy to be used with Azure CNI."
  default     = "calico"
}
variable "net_profile_dns_service_ip" {
  type        = string
  description = "(Optional) IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns)"
  default     = null
}
variable "net_profile_docker_bridge_cidr" {
  type        = string
  description = "(Optional) IP address (in CIDR notation) used as the Docker bridge IP address on nodes."
  default     = null
}
variable "net_profile_outbound_type" {
  type        = string
  description = "(Optional) The outbound (egress) routing method which should be used for this Kubernetes Cluster."
  default     = "loadBalancer"
}
variable "net_profile_pod_cidr" {
  type        = string
  description = "(Optional) The CIDR to use for pod IP addresses."
  default     = null
}

################
##Linux Profile##
################

variable "admin_username" {
  type        = string
  description = "(Required) The Admin Username for the Cluster."
  default     = "aksadmin"
}
variable "public_ssh_key" {
  type        = string
  description = "(Required) The Public SSH Key used to access the cluster."
  default     = ""
}
################
##Auto Scaler Profile##
################


variable "custom_auto_scaler_profile" {
  type        = bool
  description = "(Required) Whether to enable custom autoscaler profile or not?"
  default     = false
}

variable "balance_similar_node_groups" {
  type        = bool
  description = "(optional) Detect similar node groups and balance the number of nodes between them."
  default     = false
}
variable "expander" {
  type        = string
  description = "(optional)Expander to use"
  default     = "random"
}
variable "max_graceful_termination_sec" {
  type        = string
  description = "(optional) Maximum number of seconds the cluster autoscaler waits for pod termination when trying to scale down a node."
  default     = "600"
}
variable "max_node_provisioning_time" {
  type        = string
  description = "(optional) Maximum time the autoscaler waits for a node to be provisioned."
  default     = "15m"
}
variable "max_unready_nodes" {
  type        = string
  description = "(optional) Maximum Number of allowed unready nodes"
  default     = "3"
}
variable "max_unready_percentage" {
  type        = string
  description = "(optional)  Maximum percentage of unready nodes the cluster autoscaler will stop if the percentage is exceeded."
  default     = "45"
}
variable "name" {
  type        = string
  description = "(optional) describe your variable"
}
variable "new_pod_scale_up_delay" {
  type        = string
  description = "(optional) For scenarios like burst/batch scale where you don't want CA to act before the kubernetes scheduler could schedule all the pods, you can tell CA to ignore unscheduled pods before they're a certain age."
  default     = "10s"
}
variable "scale_down_delay_after_add" {
  type        = string
  description = "(optional) How long after the scale up of AKS nodes the scale down evaluation resumes."
  default     = "10m"
}
variable "scale_down_delay_after_delete" {
  type        = string
  description = "(optional) How long after node deletion that scale down evaluation resumes."
  default     = null
}
variable "scale_down_delay_after_failure" {
  type        = string
  description = "(optional)  How long after scale down failure that scale down evaluation resumes"
  default     = "3m"
}
variable "scan_interval" {
  type        = string
  description = "(optional)  How often the AKS Cluster should be re-evaluated for scale up/down."
  default     = "10s"
}
variable "scale_down_unneeded" {
  type        = string
  description = "(optional) How long a node should be unneeded before it is eligible for scale down"
  default     = "10m"
}
variable "scale_down_unready" {
  type        = string
  description = "(optional) How long an unready node should be unneeded before it is eligible for scale down"
  default     = "20m"
}
variable "scale_down_utilization_threshold" {
  type        = number
  description = "(optional)  Node utilization level, defined as sum of requested resources divided by capacity, below which a node can be considered for scale down."
  default     = 0.5
}
variable "empty_bulk_delete_max" {
  type        = string
  description = "(optional) Maximum number of empty nodes that can be deleted at the same time."
  default     = "10"
}
variable "skip_nodes_with_local_storage" {
  type        = bool
  description = "(optional)  If true cluster autoscaler will never delete nodes with pods with local storage, for example, EmptyDir or HostPath"
  default     = true
}
variable "skip_nodes_with_system_pods" {
  type        = bool
  description = "(optional)  If true cluster autoscaler will never delete nodes with pods from kube-system (except for DaemonSet or mirror pods)"
  default     = true
}

################
## Azure AD RBAC##
################

variable "managed_ad_rbac" {
  type        = bool
  description = "(optional) Is the Azure Active Directory integration Managed, meaning that Azure will create/manage the Service Principal used for integration"
  default     = true
}
variable "tenant_id" {
  type        = string
  description = "(optional) The Tenant ID used for Azure Active Directory Application"
  default     = null
}
variable "admin_group_object_ids" {
  type        = list(string)
  description = "(optional) A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster."
  default     = [""]
}
variable "azure_rbac_enabled" {
  type        = bool
  description = "(optional)  Is Role Based Access Control based on Azure AD enabled?"
  default     = null
}
variable "client_app_id" {
  type        = string
  description = "(optional) The Client ID of an Azure Active Directory Application."
  default     = null
}

variable "server_app_id" {
  type        = string
  description = "(optional) The Server ID of an Azure Active Directory Application."
  default     = null
}
variable "server_app_secretme" {
  type        = string
  description = "(optional) The Server Secret of an Azure Active Directory Application."
  default     = null

}

################
##Default Node Pool##
################

variable "enable_auto_scaling" {
  description = "Enable node pool autoscaling"
  type        = bool
  default     = true
}
variable "orchestrator_version" {
  type        = string
  description = "(optional)  (Optional) Version of Kubernetes used for the Agents. If not specified, the default node pool will be created with the version specified by kubernetes_version"
  default     = null
}

variable "node_count" {
  type        = number
  description = "(optional) The initial number of nodes which should exist in this Node Pool.(when auto scaling is disabled)"
  default     = 2
}
variable "vm_size" {
  type        = string
  description = "(optional)  The size of the Virtual Machine for agents in nodepool"
  default     = "Standard_D2s_v3"
}
variable "os_disk_size_gb" {
  type        = number
  description = "(optional)The size of the OS Disk in GB which should be used for each agent in the Node Pool"
  default     = 30
}
variable "vnet_subnet_id" {
  type        = string
  description = "(optional) ) The ID of a Subnet where the Kubernetes Node Pool should exist."
  default     = null
}
variable "" {
  type        = string
  description = "(optional) describe your variable"
}
variable "name" {
  type        = string
  description = "(optional) describe your variable"
}
variable "name" {
  type        = string
  description = "(optional) describe your variable"
}
variable "name" {
  type        = string
  description = "(optional) describe your variable"
}
variable "" {
  type        = string
  description = "(optional) describe your variable"
}
variable "name" {
  type        = string
  description = "(optional) describe your variable"
}
variable "name" {
  type        = string
  description = "(optional) describe your variable"
}
variable "name" {
  type        = string
  description = "(optional) describe your variable"
}
variable "" {
  type        = string
  description = "(optional) describe your variable"
}
variable "name" {
  type        = string
  description = "(optional) describe your variable"
}
variable "name" {
  type        = string
  description = "(optional) describe your variable"
}
variable "name" {
  type        = string
  description = "(optional) describe your variable"
}
