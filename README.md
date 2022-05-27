## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.99 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.7.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ssh-key"></a> [ssh-key](#module\_ssh-key) | ./ssh_key_module | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | (Required) The location where the Managed Kubernetes Cluster should be created | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Specifies the Resource Group where the Managed Kubernetes Cluster should exist | `string` | n/a | yes |
| <a name="input_admin_group_object_ids"></a> [admin\_group\_object\_ids](#input\_admin\_group\_object\_ids) | (optional) A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | (Required) The Admin Username for the Cluster. | `string` | `"aksadmin"` | no |
| <a name="input_agents_tags"></a> [agents\_tags](#input\_agents\_tags) | (optional) Tags attached to default node pool | `map(string)` | <pre>{<br>  "env": "kubernetes",<br>  "managed_by": "terraform",<br>  "type": "agent node pool"<br>}</pre> | no |
| <a name="input_agents_type"></a> [agents\_type](#input\_agents\_type) | (Optional) The type of Node Pool which should be created. Possible values are AvailabilitySet and VirtualMachineScaleSets | `string` | `"VirtualMachineScaleSets"` | no |
| <a name="input_api_server_authorized_ip_ranges"></a> [api\_server\_authorized\_ip\_ranges](#input\_api\_server\_authorized\_ip\_ranges) | Optional) The IP ranges to allow for incoming traffic to the server nodes. | `list(string)` | `null` | no |
| <a name="input_automatic_channel_upgrade"></a> [automatic\_channel\_upgrade](#input\_automatic\_channel\_upgrade) | (Optional) The upgrade channel for this Kubernetes Cluster. | `string` | `"stable"` | no |
| <a name="input_azure_policy_enabled"></a> [azure\_policy\_enabled](#input\_azure\_policy\_enabled) | (Optional) Should the Azure Policy Add-On be enabled? | `bool` | `false` | no |
| <a name="input_azure_rbac_enabled"></a> [azure\_rbac\_enabled](#input\_azure\_rbac\_enabled) | (optional)  Is Role Based Access Control based on Azure AD enabled? | `bool` | `null` | no |
| <a name="input_balance_similar_node_groups"></a> [balance\_similar\_node\_groups](#input\_balance\_similar\_node\_groups) | (optional) Detect similar node groups and balance the number of nodes between them. | `bool` | `false` | no |
| <a name="input_client_app_id"></a> [client\_app\_id](#input\_client\_app\_id) | (optional) The Client ID of an Azure Active Directory Application. | `string` | `null` | no |
| <a name="input_client_id"></a> [client\_id](#input\_client\_id) | (optional) The Client ID for the Service Principal. | `string` | `""` | no |
| <a name="input_client_secret"></a> [client\_secret](#input\_client\_secret) | (optional) The Client Secret for the Service Principal. | `string` | `""` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | (Required) The name of the Managed Kubernetes Cluster to create. | `string` | `null` | no |
| <a name="input_container_log_max_line"></a> [container\_log\_max\_line](#input\_container\_log\_max\_line) | (Optional) Specifies the maximum number of container log files that can be present for a container | `number` | `null` | no |
| <a name="input_container_log_max_size_mb"></a> [container\_log\_max\_size\_mb](#input\_container\_log\_max\_size\_mb) | (Optional) Specifies the maximum size (e.g. 10MB) of container log file before it is rotated. | `string` | `null` | no |
| <a name="input_custom_auto_scaler_profile"></a> [custom\_auto\_scaler\_profile](#input\_custom\_auto\_scaler\_profile) | (Required) Whether to enable custom autoscaler profile or not? | `bool` | `false` | no |
| <a name="input_custom_kubelet_config"></a> [custom\_kubelet\_config](#input\_custom\_kubelet\_config) | (optional) Whether to enable kubelet config or not? | `bool` | `false` | no |
| <a name="input_disk_encryption_set_id"></a> [disk\_encryption\_set\_id](#input\_disk\_encryption\_set\_id) | Optional) The ID of the Disk Encryption Set which should be used for the Nodes and Volumes. | `string` | `null` | no |
| <a name="input_dns_prefix"></a> [dns\_prefix](#input\_dns\_prefix) | (Optional) DNS prefix specified when creating the managed cluster. | `string` | `null` | no |
| <a name="input_dns_prefix_private_cluster"></a> [dns\_prefix\_private\_cluster](#input\_dns\_prefix\_private\_cluster) | (Optional) Specifies the DNS prefix to use with private clusters | `string` | `null` | no |
| <a name="input_empty_bulk_delete_max"></a> [empty\_bulk\_delete\_max](#input\_empty\_bulk\_delete\_max) | (optional) Maximum number of empty nodes that can be deleted at the same time. | `string` | `"10"` | no |
| <a name="input_enable_auto_scaling"></a> [enable\_auto\_scaling](#input\_enable\_auto\_scaling) | Enable node pool autoscaling | `bool` | `true` | no |
| <a name="input_enable_host_encryption"></a> [enable\_host\_encryption](#input\_enable\_host\_encryption) | (Optional) Should the nodes in the Default Node Pool have host encryption enabled? | `bool` | `null` | no |
| <a name="input_enable_kublet_identity"></a> [enable\_kublet\_identity](#input\_enable\_kublet\_identity) | (optional) Whether to enable kublet identity or not? | `bool` | `false` | no |
| <a name="input_enable_node_public_ip"></a> [enable\_node\_public\_ip](#input\_enable\_node\_public\_ip) | (Optional) Should nodes in this Node Pool have a Public IP Address? | `bool` | `false` | no |
| <a name="input_enabled_for_disk_encryption"></a> [enabled\_for\_disk\_encryption](#input\_enabled\_for\_disk\_encryption) | (optional)Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | (Optional) Env in which AKS is deployed | `string` | `"dev"` | no |
| <a name="input_expander"></a> [expander](#input\_expander) | (optional)Expander to use | `string` | `"random"` | no |
| <a name="input_expiration_date"></a> [expiration\_date](#input\_expiration\_date) | (optional) Expiration UTC datetime (2024-01-31T00:00:00Z) | `string` | `"2024-01-31T00:00:00Z"` | no |
| <a name="input_http_application_routing_enabled"></a> [http\_application\_routing\_enabled](#input\_http\_application\_routing\_enabled) | (Optional) Should HTTP Application Routing be enabled? | `bool` | `false` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | (Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Kubernetes Cluster | `list(string)` | `null` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | (Required) Specifies the type of Managed Service Identity that should be configured on this Kubernetes Cluster. | `string` | `"SystemAssigned"` | no |
| <a name="input_kubelet_disk_type"></a> [kubelet\_disk\_type](#input\_kubelet\_disk\_type) | (Optional) The type of disk used by kubelet | `string` | `null` | no |
| <a name="input_kubelet_object_id"></a> [kubelet\_object\_id](#input\_kubelet\_object\_id) | (Required) The Object ID of the user-defined Managed Identity assigned to the Kubelets. | `string` | `null` | no |
| <a name="input_kubelet_user_assigned_identity_id"></a> [kubelet\_user\_assigned\_identity\_id](#input\_kubelet\_user\_assigned\_identity\_id) | (Required) The ID of the User Assigned Identity assigned to the Kubelets | `string` | `null` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | (optional) Version of Kubernetes specified when creating the AKS managed cluster. | `string` | `"1.23"` | no |
| <a name="input_kublet_client_id"></a> [kublet\_client\_id](#input\_kublet\_client\_id) | (Required) The Client ID of the user-defined Managed Identity to be assigned to the Kubelets. | `string` | `null` | no |
| <a name="input_local_account_disabled"></a> [local\_account\_disabled](#input\_local\_account\_disabled) | (Optional) - If true local accounts will be disabled. | `bool` | `false` | no |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | (optional) Log analytics where oms agent will push logs | `string` | `null` | no |
| <a name="input_managed_ad_rbac"></a> [managed\_ad\_rbac](#input\_managed\_ad\_rbac) | (optional) Is the Azure Active Directory integration Managed, meaning that Azure will create/manage the Service Principal used for integration | `bool` | `false` | no |
| <a name="input_max_count"></a> [max\_count](#input\_max\_count) | (Required for Auo Scale Enabled) The maximum number of nodes which should exist in this Node Pool. | `number` | `5` | no |
| <a name="input_max_graceful_termination_sec"></a> [max\_graceful\_termination\_sec](#input\_max\_graceful\_termination\_sec) | (optional) Maximum number of seconds the cluster autoscaler waits for pod termination when trying to scale down a node. | `string` | `"600"` | no |
| <a name="input_max_node_provisioning_time"></a> [max\_node\_provisioning\_time](#input\_max\_node\_provisioning\_time) | (optional) Maximum time the autoscaler waits for a node to be provisioned. | `string` | `"15m"` | no |
| <a name="input_max_pods"></a> [max\_pods](#input\_max\_pods) | (Optional) The maximum number of pods that can run on each agent. | `number` | `null` | no |
| <a name="input_max_unready_nodes"></a> [max\_unready\_nodes](#input\_max\_unready\_nodes) | (optional) Maximum Number of allowed unready nodes | `string` | `"3"` | no |
| <a name="input_max_unready_percentage"></a> [max\_unready\_percentage](#input\_max\_unready\_percentage) | (optional)  Maximum percentage of unready nodes the cluster autoscaler will stop if the percentage is exceeded. | `string` | `"45"` | no |
| <a name="input_min_count"></a> [min\_count](#input\_min\_count) | (Required for Auo Scale Enabled) The minimum number of nodes which should exist in this Node Pool. | `number` | `2` | no |
| <a name="input_net_profile_dns_service_ip"></a> [net\_profile\_dns\_service\_ip](#input\_net\_profile\_dns\_service\_ip) | (Optional) IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns) | `string` | `null` | no |
| <a name="input_net_profile_docker_bridge_cidr"></a> [net\_profile\_docker\_bridge\_cidr](#input\_net\_profile\_docker\_bridge\_cidr) | (Optional) IP address (in CIDR notation) used as the Docker bridge IP address on nodes. | `string` | `null` | no |
| <a name="input_net_profile_network_mode"></a> [net\_profile\_network\_mode](#input\_net\_profile\_network\_mode) | (Optional) Network mode to be used with Azure CNI. | `string` | `null` | no |
| <a name="input_net_profile_network_plugin"></a> [net\_profile\_network\_plugin](#input\_net\_profile\_network\_plugin) | (Required) Network plugin to use for networking. | `string` | `"kubenet"` | no |
| <a name="input_net_profile_network_policy"></a> [net\_profile\_network\_policy](#input\_net\_profile\_network\_policy) | (Optional) Sets up network policy to be used with Azure CNI. | `string` | `"calico"` | no |
| <a name="input_net_profile_outbound_type"></a> [net\_profile\_outbound\_type](#input\_net\_profile\_outbound\_type) | (Optional) The outbound (egress) routing method which should be used for this Kubernetes Cluster. | `string` | `"loadBalancer"` | no |
| <a name="input_net_profile_pod_cidr"></a> [net\_profile\_pod\_cidr](#input\_net\_profile\_pod\_cidr) | (Optional) The CIDR to use for pod IP addresses. | `string` | `null` | no |
| <a name="input_net_profile_service_cidr"></a> [net\_profile\_service\_cidr](#input\_net\_profile\_service\_cidr) | (optional) The Network Range used by the Kubernetes service. | `string` | `null` | no |
| <a name="input_new_pod_scale_up_delay"></a> [new\_pod\_scale\_up\_delay](#input\_new\_pod\_scale\_up\_delay) | (optional) For scenarios like burst/batch scale where you don't want CA to act before the kubernetes scheduler could schedule all the pods, you can tell CA to ignore unscheduled pods before they're a certain age. | `string` | `"10s"` | no |
| <a name="input_node_count"></a> [node\_count](#input\_node\_count) | (optional) The initial number of nodes which should exist in this Node Pool.(when auto scaling is disabled) | `number` | `2` | no |
| <a name="input_node_labels"></a> [node\_labels](#input\_node\_labels) | (Optional) A map of Kubernetes labels which should be applied to nodes in the Default Node Pool. | `map(string)` | `{}` | no |
| <a name="input_node_pool_name"></a> [node\_pool\_name](#input\_node\_pool\_name) | (Required) Name of node pool within AKS cluster | `string` | `"nodepool"` | no |
| <a name="input_node_public_ip_prefix_id"></a> [node\_public\_ip\_prefix\_id](#input\_node\_public\_ip\_prefix\_id) | (Optional) Resource ID for the Public IP Addresses Prefix for the nodes in this Node Pool | `string` | `null` | no |
| <a name="input_node_resource_group"></a> [node\_resource\_group](#input\_node\_resource\_group) | (Optional) The name of the Resource Group where the Kubernetes Nodes should exist. Azure requires that a new, non-existent Resource Group is used, as otherwise the provisioning of the Kubernetes Service will fail | `string` | `"rg-aks-nodes-euw"` | no |
| <a name="input_only_critical_addons_enabled"></a> [only\_critical\_addons\_enabled](#input\_only\_critical\_addons\_enabled) | ((Optional) Enabling this option will taint default node pool with CriticalAddonsOnly=true:NoSchedule taint. | `bool` | `null` | no |
| <a name="input_open_service_mesh_enabled"></a> [open\_service\_mesh\_enabled](#input\_open\_service\_mesh\_enabled) | (Optional) Is Open Service Mesh enabled? | `bool` | `null` | no |
| <a name="input_orchestrator_version"></a> [orchestrator\_version](#input\_orchestrator\_version) | (optional)  (Optional) Version of Kubernetes used for the Agents. If not specified, the default node pool will be created with the version specified by kubernetes\_version | `string` | `null` | no |
| <a name="input_os_disk_size_gb"></a> [os\_disk\_size\_gb](#input\_os\_disk\_size\_gb) | (optional)The size of the OS Disk in GB which should be used for each agent in the Node Pool | `number` | `30` | no |
| <a name="input_private_cluster_enabled"></a> [private\_cluster\_enabled](#input\_private\_cluster\_enabled) | (Optional) Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? | `bool` | `false` | no |
| <a name="input_private_cluster_public_fqdn_enabled"></a> [private\_cluster\_public\_fqdn\_enabled](#input\_private\_cluster\_public\_fqdn\_enabled) | (Optional) Specifies whether a Public FQDN for this Private Cluster should be added. | `bool` | `false` | no |
| <a name="input_private_dns_zone_id"></a> [private\_dns\_zone\_id](#input\_private\_dns\_zone\_id) | (Optional) Either the ID of Private DNS Zone which should be delegated to this Cluster, System to have AKS manage this or None | `string` | `null` | no |
| <a name="input_public_ssh_key"></a> [public\_ssh\_key](#input\_public\_ssh\_key) | (Required) The Public SSH Key used to access the cluster. | `string` | `""` | no |
| <a name="input_purge_protection_enabled"></a> [purge\_protection\_enabled](#input\_purge\_protection\_enabled) | (optional) Is Purge Protection enabled for this Key Vault? | `bool` | `false` | no |
| <a name="input_role_based_access_control_enabled"></a> [role\_based\_access\_control\_enabled](#input\_role\_based\_access\_control\_enabled) | (Optional) - Whether Role Based Access Control for the Kubernetes Cluster should be enabled. | `bool` | `true` | no |
| <a name="input_run_command_enabled"></a> [run\_command\_enabled](#input\_run\_command\_enabled) | (Optional) Whether to enable run command for the cluster or not. | `bool` | `true` | no |
| <a name="input_scale_down_delay_after_add"></a> [scale\_down\_delay\_after\_add](#input\_scale\_down\_delay\_after\_add) | (optional) How long after the scale up of AKS nodes the scale down evaluation resumes. | `string` | `"10m"` | no |
| <a name="input_scale_down_delay_after_delete"></a> [scale\_down\_delay\_after\_delete](#input\_scale\_down\_delay\_after\_delete) | (optional) How long after node deletion that scale down evaluation resumes. | `string` | `null` | no |
| <a name="input_scale_down_delay_after_failure"></a> [scale\_down\_delay\_after\_failure](#input\_scale\_down\_delay\_after\_failure) | (optional)  How long after scale down failure that scale down evaluation resumes | `string` | `"3m"` | no |
| <a name="input_scale_down_unneeded"></a> [scale\_down\_unneeded](#input\_scale\_down\_unneeded) | (optional) How long a node should be unneeded before it is eligible for scale down | `string` | `"10m"` | no |
| <a name="input_scale_down_unready"></a> [scale\_down\_unready](#input\_scale\_down\_unready) | (optional) How long an unready node should be unneeded before it is eligible for scale down | `string` | `"20m"` | no |
| <a name="input_scale_down_utilization_threshold"></a> [scale\_down\_utilization\_threshold](#input\_scale\_down\_utilization\_threshold) | (optional)  Node utilization level, defined as sum of requested resources divided by capacity, below which a node can be considered for scale down. | `number` | `0.5` | no |
| <a name="input_scan_interval"></a> [scan\_interval](#input\_scan\_interval) | (optional)  How often the AKS Cluster should be re-evaluated for scale up/down. | `string` | `"10s"` | no |
| <a name="input_secret_rotation_enabled"></a> [secret\_rotation\_enabled](#input\_secret\_rotation\_enabled) | (Required) Is secret rotation enabled? | `bool` | `false` | no |
| <a name="input_secret_rotation_interval"></a> [secret\_rotation\_interval](#input\_secret\_rotation\_interval) | (Required) The interval to poll for secret rotation. | `number` | `null` | no |
| <a name="input_server_app_id"></a> [server\_app\_id](#input\_server\_app\_id) | (optional) The Server ID of an Azure Active Directory Application. | `string` | `null` | no |
| <a name="input_server_app_secret"></a> [server\_app\_secret](#input\_server\_app\_secret) | (optional) The Server Secret of an Azure Active Directory Application. | `string` | `null` | no |
| <a name="input_skip_nodes_with_local_storage"></a> [skip\_nodes\_with\_local\_storage](#input\_skip\_nodes\_with\_local\_storage) | (optional)  If true cluster autoscaler will never delete nodes with pods with local storage, for example, EmptyDir or HostPath | `bool` | `true` | no |
| <a name="input_skip_nodes_with_system_pods"></a> [skip\_nodes\_with\_system\_pods](#input\_skip\_nodes\_with\_system\_pods) | (optional)  If true cluster autoscaler will never delete nodes with pods from kube-system (except for DaemonSet or mirror pods) | `bool` | `true` | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | (Optional) The SKU Tier that should be used for this Kubernetes Cluster | `string` | `"Free"` | no |
| <a name="input_soft_delete_retention_days"></a> [soft\_delete\_retention\_days](#input\_soft\_delete\_retention\_days) | (optional) he number of days that items should be retained for once soft-deleted. | `number` | `7` | no |
| <a name="input_ssh_key_vault_name"></a> [ssh\_key\_vault\_name](#input\_ssh\_key\_vault\_name) | (optional) Key Vault name where private key would be stored as password | `string` | `"kv-ssh-key-aks-module"` | no |
| <a name="input_ssh_kv_secret"></a> [ssh\_kv\_secret](#input\_ssh\_kv\_secret) | (optional) KV secret which contains the ssh ppk generated for aks module | `string` | `"secret-ppk-aks-module"` | no |
| <a name="input_swap_file_size_mb"></a> [swap\_file\_size\_mb](#input\_swap\_file\_size\_mb) | (Optional) Specifies the size of swap file on each node in MB | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Tags needs to be attached to the cluster | `map(string)` | `{}` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | (optional) The Tenant ID used for Azure Active Directory Application | `string` | `null` | no |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | (optional)  The size of the Virtual Machine for agents in nodepool | `string` | `"Standard_D2s_v3"` | no |
| <a name="input_vnet_subnet_id"></a> [vnet\_subnet\_id](#input\_vnet\_subnet\_id) | (optional) ) The ID of a Subnet where the Kubernetes Node Pool should exist. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aks_id"></a> [aks\_id](#output\_aks\_id) | n/a |
| <a name="output_ssh_pub_key"></a> [ssh\_pub\_key](#output\_ssh\_pub\_key) | n/a |
