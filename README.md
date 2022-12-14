## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.99 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 2.99 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |
| [azurerm_kubernetes_cluster_node_pool.node_pool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool) | resource |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_node_pool_name"></a> [default\_node\_pool\_name](#input\_default\_node\_pool\_name) | (Required) The name which should be used for the default Kubernetes Node Pool. | `string` | n/a | yes |
| <a name="input_default_node_pool_node_count"></a> [default\_node\_pool\_node\_count](#input\_default\_node\_pool\_node\_count) | (Required) The number of nodes which should exist in default Node Pool | `number` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the Managed Kubernetes Cluster to create. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Specifies the Resource Group where the Managed Kubernetes Cluster should exist. | `string` | n/a | yes |
| <a name="input_aad_azure_rbac_enabled"></a> [aad\_azure\_rbac\_enabled](#input\_aad\_azure\_rbac\_enabled) | (Optional) Is Role Based Access Control based on Azure AD enabled? | `bool` | `null` | no |
| <a name="input_aad_rbac_enabled"></a> [aad\_rbac\_enabled](#input\_aad\_rbac\_enabled) | (Optional)If AAD RBAC should be enabled | `bool` | `false` | no |
| <a name="input_aad_rbac_managed"></a> [aad\_rbac\_managed](#input\_aad\_rbac\_managed) | (Optional) Is the Azure Active Directory integration Managed, meaning that Azure will create/manage the Service Principal used for integration | `bool` | `true` | no |
| <a name="input_aad_rbac_managed_admin_group_ids"></a> [aad\_rbac\_managed\_admin\_group\_ids](#input\_aad\_rbac\_managed\_admin\_group\_ids) | (Optional) A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster. | `list(string)` | `null` | no |
| <a name="input_aad_rbac_unmanaged_client_app_id"></a> [aad\_rbac\_unmanaged\_client\_app\_id](#input\_aad\_rbac\_unmanaged\_client\_app\_id) | (Optional) The Client ID of an Azure Active Directory Application. required if aad\_rbac\_managed = false | `string` | `null` | no |
| <a name="input_aad_rbac_unmanaged_server_app_id"></a> [aad\_rbac\_unmanaged\_server\_app\_id](#input\_aad\_rbac\_unmanaged\_server\_app\_id) | (Optional) The Server ID of an Azure Active Directory Application, required if aad\_rbac\_managed = false | `string` | `null` | no |
| <a name="input_aad_rbac_unmanaged_server_app_secret"></a> [aad\_rbac\_unmanaged\_server\_app\_secret](#input\_aad\_rbac\_unmanaged\_server\_app\_secret) | (Optional) The Server Secret of an Azure Active Directory Application., required if aad\_rbac\_managed = false | `string` | `null` | no |
| <a name="input_additional_node_pools"></a> [additional\_node\_pools](#input\_additional\_node\_pools) | (optional) Additional node pool configuration for the aks cluster, ref to module for all inputs possible. | `any` | `{}` | no |
| <a name="input_api_server_authorized_ip_ranges"></a> [api\_server\_authorized\_ip\_ranges](#input\_api\_server\_authorized\_ip\_ranges) | (Optional) The IP ranges to allow for incoming traffic to the server nodes. | `set(string)` | `null` | no |
| <a name="input_automatic_channel_upgrade"></a> [automatic\_channel\_upgrade](#input\_automatic\_channel\_upgrade) | (Optional) The upgrade channel for this Kubernetes Cluster, see https://docs.microsoft.com/en-us/azure/aks/upgrade-cluster#set-auto-upgrade-channel | `string` | `"node-image"` | no |
| <a name="input_azure_policy_enabled"></a> [azure\_policy\_enabled](#input\_azure\_policy\_enabled) | Optional) Should the Azure Policy Add-On be enabled? more info: https://docs.microsoft.com/en-ie/azure/governance/policy/concepts/rego-for-aks | `bool` | `false` | no |
| <a name="input_default_node_pool_enable_auto_scaling"></a> [default\_node\_pool\_enable\_auto\_scaling](#input\_default\_node\_pool\_enable\_auto\_scaling) | (Optional) Should the Kubernetes Auto Scaler be enabled for this Node Pool? | `bool` | `null` | no |
| <a name="input_default_node_pool_enable_host_encryption"></a> [default\_node\_pool\_enable\_host\_encryption](#input\_default\_node\_pool\_enable\_host\_encryption) | (Optional) Should the nodes in the Default Node Pool have host encryption enabled? | `bool` | `null` | no |
| <a name="input_default_node_pool_enable_node_public_ip"></a> [default\_node\_pool\_enable\_node\_public\_ip](#input\_default\_node\_pool\_enable\_node\_public\_ip) | (Optional) Should nodes in this Node Pool have a Public IP Address? | `bool` | `null` | no |
| <a name="input_default_node_pool_fips_enabled"></a> [default\_node\_pool\_fips\_enabled](#input\_default\_node\_pool\_fips\_enabled) | (Optional) Should the nodes in this Node Pool have Federal Information Processing Standard enabled? | `bool` | `null` | no |
| <a name="input_default_node_pool_kubelet_disk_type"></a> [default\_node\_pool\_kubelet\_disk\_type](#input\_default\_node\_pool\_kubelet\_disk\_type) | (Optional) The type of disk used by kubelet. Possible values are OS and Temporary.' | `string` | `"OS"` | no |
| <a name="input_default_node_pool_max_count"></a> [default\_node\_pool\_max\_count](#input\_default\_node\_pool\_max\_count) | (Optional) The maximum number of nodes which should exist in this Node Pool. (Required) If autoscaling is enabled, the maximum number of nodes | `number` | `null` | no |
| <a name="input_default_node_pool_min_count"></a> [default\_node\_pool\_min\_count](#input\_default\_node\_pool\_min\_count) | (Optional) The minimum number of nodes which should exist in this Node Pool. (Required) If autoscaling is enabled, the maximum number of nodes | `number` | `null` | no |
| <a name="input_default_node_pool_node_labels"></a> [default\_node\_pool\_node\_labels](#input\_default\_node\_pool\_node\_labels) | (Optional) A map of Kubernetes labels which should be applied to nodes in the Default Node Pool. | `map(string)` | `null` | no |
| <a name="input_default_node_pool_only_critical_addons_enabled"></a> [default\_node\_pool\_only\_critical\_addons\_enabled](#input\_default\_node\_pool\_only\_critical\_addons\_enabled) | (Optional) Enabling this option will taint default node pool with CriticalAddonsOnly=true:NoSchedule taint | `bool` | `false` | no |
| <a name="input_default_node_pool_os_disk_size_gb"></a> [default\_node\_pool\_os\_disk\_size\_gb](#input\_default\_node\_pool\_os\_disk\_size\_gb) | (Optional) The size of the OS Disk which should be used for each agent in the default Node Pool. | `number` | `64` | no |
| <a name="input_default_node_pool_os_disk_type"></a> [default\_node\_pool\_os\_disk\_type](#input\_default\_node\_pool\_os\_disk\_type) | (Optional) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed | `string` | `null` | no |
| <a name="input_default_node_pool_os_sku"></a> [default\_node\_pool\_os\_sku](#input\_default\_node\_pool\_os\_sku) | (Optional) OsSKU to be used to specify Linux OSType. Not applicable to Windows OSType. | `string` | `null` | no |
| <a name="input_default_node_pool_public_ip_prefix_id"></a> [default\_node\_pool\_public\_ip\_prefix\_id](#input\_default\_node\_pool\_public\_ip\_prefix\_id) | (Optional) Resource ID for the Public IP Addresses Prefix for the nodes in this Node Pool. | `string` | `null` | no |
| <a name="input_default_node_pool_tags"></a> [default\_node\_pool\_tags](#input\_default\_node\_pool\_tags) | (Optional) Tags for the node pool | `map(string)` | `null` | no |
| <a name="input_default_node_pool_ultra_ssd_enabled"></a> [default\_node\_pool\_ultra\_ssd\_enabled](#input\_default\_node\_pool\_ultra\_ssd\_enabled) | (Optional) Used to specify whether the UltraSSD is enabled in the Default Node Pool. | `bool` | `null` | no |
| <a name="input_default_node_pool_upgrade_max_surge"></a> [default\_node\_pool\_upgrade\_max\_surge](#input\_default\_node\_pool\_upgrade\_max\_surge) | (Optional) The maximum number or percentage of nodes which will be added to the Node Pool size during an upgrade. ref : https://registry.terraform.io/providers/hashicorp/azurerm/3.9.0/docs/resources/kubernetes_cluster#max_surge | `string` | `"2"` | no |
| <a name="input_default_node_pool_vm_size"></a> [default\_node\_pool\_vm\_size](#input\_default\_node\_pool\_vm\_size) | (optional) The size of the Virtual Machine, such as Standard\_DS2\_v2. | `string` | `"Standard_B1ls"` | no |
| <a name="input_disk_encryption_set_id"></a> [disk\_encryption\_set\_id](#input\_disk\_encryption\_set\_id) | (Optional) The ID of the Disk Encryption Set which should be used for the Nodes and Volumes. | `string` | `null` | no |
| <a name="input_dns_prefix"></a> [dns\_prefix](#input\_dns\_prefix) | (optional) DNS prefix specified when creating the managed cluster.(Required) When dns\_prefix\_private\_cluster is not specif | `string` | `null` | no |
| <a name="input_dns_prefix_private_cluster"></a> [dns\_prefix\_private\_cluster](#input\_dns\_prefix\_private\_cluster) | (optional) Specifies the DNS prefix to use with private clusters.(Required) When dns\_prefix is not specified. | `string` | `null` | no |
| <a name="input_dns_service_ip"></a> [dns\_service\_ip](#input\_dns\_service\_ip) | (Optional) IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). | `string` | `null` | no |
| <a name="input_docker_bridge_cidr"></a> [docker\_bridge\_cidr](#input\_docker\_bridge\_cidr) | (Optional) IP address (in CIDR notation) used as the Docker bridge IP address on nodes | `string` | `null` | no |
| <a name="input_enable_microsoft_defender"></a> [enable\_microsoft\_defender](#input\_enable\_microsoft\_defender) | (Optional) whether to enable the microsoft defender or not ,ref: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#microsoft_defender | `bool` | `false` | no |
| <a name="input_existing_aks_cluster"></a> [existing\_aks\_cluster](#input\_existing\_aks\_cluster) | (optional) Is there any existing AKS cluster? | `bool` | `false` | no |
| <a name="input_http_application_routing_enabled"></a> [http\_application\_routing\_enabled](#input\_http\_application\_routing\_enabled) | (Optional) Should HTTP Application Routing be enabled? | `bool` | `null` | no |
| <a name="input_http_proxy_config"></a> [http\_proxy\_config](#input\_http\_proxy\_config) | Proxy config: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#http_proxy | `any` | `null` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | (optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Kubernetes Cluster | `set(string)` | `null` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | (optional) Specifies the type of Managed Service Identity that should be configured on this Kubernetes Cluster. | `string` | `"SystemAssigned"` | no |
| <a name="input_ingress_app_gw_enabled"></a> [ingress\_app\_gw\_enabled](#input\_ingress\_app\_gw\_enabled) | If the Ingress Application Gateway is should be enabled or not? | `bool` | `false` | no |
| <a name="input_ingress_app_gw_id"></a> [ingress\_app\_gw\_id](#input\_ingress\_app\_gw\_id) | (Optional) The ID of the Application Gateway to integrate with the ingress controller of this Kubernetes Cluster, ref:  https://docs.microsoft.com/en-us/azure/application-gateway/tutorial-ingress-controller-add-on-existing | `string` | `null` | no |
| <a name="input_ingress_app_gw_name"></a> [ingress\_app\_gw\_name](#input\_ingress\_app\_gw\_name) | (Optional) The name of the Application Gateway to be used or created in the Nodepool Resource Group, which in turn will be integrated with the ingress controller of this Kubernetes Cluster, ref: https://docs.microsoft.com/azure/application-gateway/tutorial-ingress-controller-add-on-new | `string` | `null` | no |
| <a name="input_ingress_app_gw_subnet_cidr"></a> [ingress\_app\_gw\_subnet\_cidr](#input\_ingress\_app\_gw\_subnet\_cidr) | (Optional) The subnet CIDR to be used to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster, ref: https://docs.microsoft.com/azure/application-gateway/tutorial-ingress-controller-add-on-new | `string` | `null` | no |
| <a name="input_ingress_app_gw_subnet_id"></a> [ingress\_app\_gw\_subnet\_id](#input\_ingress\_app\_gw\_subnet\_id) | (Optional) The ID of the subnet on which to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster, ref: https://docs.microsoft.com/azure/application-gateway/tutorial-ingress-controller-add-on-new | `string` | `null` | no |
| <a name="input_key_vault_secrets_provider_enabled"></a> [key\_vault\_secrets\_provider\_enabled](#input\_key\_vault\_secrets\_provider\_enabled) | (Optional) If the secrets provider should be enabled | `bool` | `false` | no |
| <a name="input_key_vault_secrets_provider_secret_rotation_enabled"></a> [key\_vault\_secrets\_provider\_secret\_rotation\_enabled](#input\_key\_vault\_secrets\_provider\_secret\_rotation\_enabled) | (Optional) Is secret rotation enabled? | `bool` | `false` | no |
| <a name="input_key_vault_secrets_provider_secret_rotation_interval"></a> [key\_vault\_secrets\_provider\_secret\_rotation\_interval](#input\_key\_vault\_secrets\_provider\_secret\_rotation\_interval) | (Optional) The interval to poll for secret rotation. This attribute is only set when secret\_rotation is true and defaults to 2m. | `string` | `null` | no |
| <a name="input_kubelet_identity_client_id"></a> [kubelet\_identity\_client\_id](#input\_kubelet\_identity\_client\_id) | (Optional) The Client ID of the user-defined Managed Identity to be assigned to the Kubelets. If not specified a Managed Identity is created automatically.Can be also specified when kubelet\_identity is true | `string` | `null` | no |
| <a name="input_kubelet_identity_enabled"></a> [kubelet\_identity\_enabled](#input\_kubelet\_identity\_enabled) | (optional) If kubelet identity should be enabled | `bool` | `false` | no |
| <a name="input_kubelet_identity_object_id"></a> [kubelet\_identity\_object\_id](#input\_kubelet\_identity\_object\_id) | (optional) The Object ID of the user-defined Managed Identity assigned to the Kubelets.If not specified a Managed Identity is created automatically.Can be also specified when kubelet\_identity is true | `string` | `null` | no |
| <a name="input_kubelet_identity_user_assigned_identity_id"></a> [kubelet\_identity\_user\_assigned\_identity\_id](#input\_kubelet\_identity\_user\_assigned\_identity\_id) | (optional) The ID of the User Assigned Identity assigned to the Kubelets. If not specified a Managed Identity is created automatically.Can be also specified when kubelet\_identity is true | `string` | `null` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | (Optional) Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade). | `string` | `null` | no |
| <a name="input_local_account_disabled"></a> [local\_account\_disabled](#input\_local\_account\_disabled) | (Optional) - If true local accounts will be disabled. Defaults to false. see https://docs.microsoft.com/en-us/azure/aks/managed-aad#azure-ad-authentication-overview | `bool` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | (optional) The location where the Managed Kubernetes Cluster should be created. | `string` | `"westeurope"` | no |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | (Optional) Specifies the ID of the Log Analytics Workspace where the audit logs collected by Microsoft Defender & OMS agent should be sent to | `string` | `null` | no |
| <a name="input_network_plugin"></a> [network\_plugin](#input\_network\_plugin) | (Optional) Network plugin to use for networking. | `string` | `"kubenet"` | no |
| <a name="input_network_policy"></a> [network\_policy](#input\_network\_policy) | (Optional) Sets up network policy to be used with Azure CNI. | `string` | `"calico"` | no |
| <a name="input_node_resource_group"></a> [node\_resource\_group](#input\_node\_resource\_group) | (Optional) The name of the Resource Group where the Kubernetes Nodes should exist. | `string` | `null` | no |
| <a name="input_oidc_issuer_enabled"></a> [oidc\_issuer\_enabled](#input\_oidc\_issuer\_enabled) | (Optional) Enable or Disable the OIDC issuer URL | `bool` | `null` | no |
| <a name="input_open_service_mesh_enabled"></a> [open\_service\_mesh\_enabled](#input\_open\_service\_mesh\_enabled) | (Optional) Is Open Service Mesh enabled? more info: https://docs.microsoft.com/azure/aks/open-service-mesh-about | `bool` | `null` | no |
| <a name="input_outbound_type"></a> [outbound\_type](#input\_outbound\_type) | (Optional) The outbound (egress) routing method which should be used for this Kubernetes Cluster. | `string` | `null` | no |
| <a name="input_pod_cidr"></a> [pod\_cidr](#input\_pod\_cidr) | (Optional) The CIDR to use for pod IP addresses. | `string` | `null` | no |
| <a name="input_private_cluster_enabled"></a> [private\_cluster\_enabled](#input\_private\_cluster\_enabled) | (Optional) Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? | `bool` | `null` | no |
| <a name="input_private_cluster_public_fqdn_enabled"></a> [private\_cluster\_public\_fqdn\_enabled](#input\_private\_cluster\_public\_fqdn\_enabled) | (optional)  Specifies whether a Public FQDN for this Private Cluster should be added. | `bool` | `null` | no |
| <a name="input_private_dns_zone_id"></a> [private\_dns\_zone\_id](#input\_private\_dns\_zone\_id) | (Optional) Either the ID of Private DNS Zone which should be delegated to this Cluster, System to have AKS manage this or None, see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#private_dns_zone_id | `string` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Whether public network access is allowed for this Kubernetes Cluster. | `bool` | `null` | no |
| <a name="input_role_based_access_control_enabled"></a> [role\_based\_access\_control\_enabled](#input\_role\_based\_access\_control\_enabled) | (Optional) - Whether Role Based Access Control for the Kubernetes Cluster should be enabled. | `bool` | `true` | no |
| <a name="input_run_command_enabled"></a> [run\_command\_enabled](#input\_run\_command\_enabled) | (Optional) Whether to enable run command for the cluster or not? | `bool` | `true` | no |
| <a name="input_service_cidr"></a> [service\_cidr](#input\_service\_cidr) | (Optional) The Network Range used by the Kubernetes service. | `string` | `null` | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | (Optional) The SKU Tier that should be used for this Kubernetes Cluster | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for the cluster | `map(string)` | `null` | no |
| <a name="input_vnet_subnet_id"></a> [vnet\_subnet\_id](#input\_vnet\_subnet\_id) | (optional) The ID of the Subnet where this Node Pool should exist.At this time the vnet\_subnet\_id must be the same for all node pools in the cluster | `string` | `null` | no |
| <a name="input_windows_profile_admin_password"></a> [windows\_profile\_admin\_password](#input\_windows\_profile\_admin\_password) | (optional) The Admin Password for Windows VMs.(Required) if windows\_profile\_enabled is true. | `string` | `"Super$ecUreP@$$w04d"` | no |
| <a name="input_windows_profile_admin_username"></a> [windows\_profile\_admin\_username](#input\_windows\_profile\_admin\_username) | (optional) The Admin Username for Windows VMs. (Required) if windows\_profile\_enabled is true. | `string` | `"azureadmin"` | no |
| <a name="input_windows_profile_enabled"></a> [windows\_profile\_enabled](#input\_windows\_profile\_enabled) | (optional) Is windows profile enabled? | `bool` | `false` | no |
| <a name="input_windows_profile_license"></a> [windows\_profile\_license](#input\_windows\_profile\_license) | (optional)Specifies the type of on-premise license which should be used for Node Pool Windows Virtual Machine | `string` | `"Windows_Server"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_additional_node_pool_ids"></a> [additional\_node\_pool\_ids](#output\_additional\_node\_pool\_ids) | The IDs of the additional Kubernetes Cluster Node Pools. |
| <a name="output_aks_id"></a> [aks\_id](#output\_aks\_id) | AKS cluster ID |
| <a name="output_azurerm_kubernetes_cluster"></a> [azurerm\_kubernetes\_cluster](#output\_azurerm\_kubernetes\_cluster) | Entire AKS cluster object as an output |
