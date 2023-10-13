<!-- PROJECT SHIELDS -->
<!--
*** declarations on the bottom of this document
managed within the footer file
-->
[![License][license-shield]][license-url] [![Contributors][contributors-shield]][contributors-url] [![Issues][issues-shield]][issues-url] [![Forks][forks-shield]][forks-url] [![Stargazers][stars-shield]][stars-url]

<div id="top"></div>
<!-- PROJECT LOGO -->
<br />
<div align="center">

  <h1 align="center"><strong>Azure Kubernetes Service</strong></h1>
  <p align="center">
    🌩️ Terraform Module For Provisioning Azure Kubernetes Services 🌩️
    <br/>
    <a href="https://github.com/ishuar/terraform-azure-aks/issues"><strong>Report Bug</a></strong> or <a href="https://github.com/ishuar/terraform-azure-aks/issues"><strong>Request Feature</a></strong>
    <br/>
    <br/>
  </p>
</div>

## Background Knowledge or External Documentation

- [What is Azure Kubernetes Service?](https://learn.microsoft.com/en-us/azure/aks/intro-kubernetes)
- [Get Started with Flux](https://fluxcd.io/flux/get-started/)

### Pre-requisites

| Name          | Version Used | Help                                                                                                 | Required |
|---------------|--------------|------------------------------------------------------------------------------------------------------|----------|
| Terraform     | `>= 1.3.0`   | [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) | Yes      |
| Azure Account | `N/A`        | [Create Azure account](https://azure.microsoft.com/en-us/free)                                       | Yes      |
| azure-cli     | `>=2.50.0`   | [Install azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)                   | Yes      |

**⭐️ Don't forget to give the project a star! Thanks again! ⭐️**

## Introduction

🚀 This module is your ticket to effortlessly create a Azure Kubernetes Service. Whether you're a seasoned cloud architect or just getting started, this module streamlines the process, giving you more time to focus on what truly matters. 🚀

## Available Features

- Azure kubernetes provisioning
- Multi nodePool deployments.
- Azure Monitor Diagnostic Settinga.
- FluxCD azure kubernetes cluster extension.

## Usage

```hcl
## Minimal Example with disabled Autoscaling and disabled monitor diagnostic settings

resource "azurerm_resource_group" "aks_rg" {
  name     = "rg-aks-module-test-euw"
  location = "West Europe"
}

module "aks" {
  source  = "ishuar/aks/azure"
  version = "~> 2.1"

  location                     = azurerm_resource_group.aks_rg.name
  resource_group_name          = azurerm_resource_group.aks_rg.location
  name                         = "minimal-example"
  dns_prefix                   = "exampleaks1"
  default_node_pool_name       = "default"
  default_node_pool_node_count = 1
}

```

## Examples

Examples are availabe in `examples` directory.

- [simple](/examples/simple)
- [flux-enabled-aks](/example/flux-enabled-aks)
- [complete](/example/complete)

## Submodule

**⭐️ Don't forget to give the project a star! Thanks again! ⭐️**

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.55 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.55 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_kubernetes_cluster.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |
| [azurerm_kubernetes_cluster_extension.fluxcd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_extension) | resource |
| [azurerm_kubernetes_cluster_node_pool.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool) | resource |
| [azurerm_kubernetes_flux_configuration.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_flux_configuration) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_role_assignment.fluxcd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_definition.fluxcd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition) | resource |
| [random_string.fluxcd](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [terraform_data.az_providers_register](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_kubernetes_cluster.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |
| [azurerm_kubernetes_service_versions.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_service_versions) | data source |
| [azurerm_monitor_diagnostic_categories.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the Managed Kubernetes Cluster to create or the existing kubernetes cluster to use with the module | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Specifies the Resource Group where the new or existing Managed Kubernetes Cluster exists. | `string` | n/a | yes |
| <a name="input_aad_azure_rbac_enabled"></a> [aad\_azure\_rbac\_enabled](#input\_aad\_azure\_rbac\_enabled) | (Optional) Is Role Based Access Control based on Azure AD enabled? | `bool` | `null` | no |
| <a name="input_aad_rbac_enabled"></a> [aad\_rbac\_enabled](#input\_aad\_rbac\_enabled) | (Optional)If AAD RBAC should be enabled | `bool` | `false` | no |
| <a name="input_aad_rbac_managed"></a> [aad\_rbac\_managed](#input\_aad\_rbac\_managed) | (Optional) Is the Azure Active Directory integration Managed, meaning that Azure will create/manage the Service Principal used for integration | `bool` | `true` | no |
| <a name="input_aad_rbac_managed_admin_group_ids"></a> [aad\_rbac\_managed\_admin\_group\_ids](#input\_aad\_rbac\_managed\_admin\_group\_ids) | (Optional) A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster. | `list(string)` | `null` | no |
| <a name="input_aad_rbac_unmanaged_client_app_id"></a> [aad\_rbac\_unmanaged\_client\_app\_id](#input\_aad\_rbac\_unmanaged\_client\_app\_id) | (Optional) Required if aad\_rbac\_managed = false. The Client ID of an Azure Active Directory Application. | `string` | `null` | no |
| <a name="input_aad_rbac_unmanaged_server_app_id"></a> [aad\_rbac\_unmanaged\_server\_app\_id](#input\_aad\_rbac\_unmanaged\_server\_app\_id) | (Optional) Required if aad\_rbac\_managed = false. The Server ID of an Azure Active Directory Application. | `string` | `null` | no |
| <a name="input_aad_rbac_unmanaged_server_app_secret"></a> [aad\_rbac\_unmanaged\_server\_app\_secret](#input\_aad\_rbac\_unmanaged\_server\_app\_secret) | (Optional) Required if aad\_rbac\_managed = false. The Server Secret of an Azure Active Directory Application. | `string` | `null` | no |
| <a name="input_additional_node_pools"></a> [additional\_node\_pools](#input\_additional\_node\_pools) | (optional) Additional node pool configuration for the aks cluster, ref to module for all inputs possible. | `any` | `{}` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | (optional) The Admin Username for the Cluster. Changing this forces a new resource to be created. | `string` | `"aks-admin"` | no |
| <a name="input_allowed_maintenance_window_day"></a> [allowed\_maintenance\_window\_day](#input\_allowed\_maintenance\_window\_day) | (optional) Required if `enable_allowed_maintenance_window` is set to true. A day in a week. Possible values are `Sunday`, `Monday`, `Tuesday`, `Wednesday`, `Thursday`, `Friday` and `Saturday` | `string` | `"Saturday"` | no |
| <a name="input_allowed_maintenance_window_hours"></a> [allowed\_maintenance\_window\_hours](#input\_allowed\_maintenance\_window\_hours) | (optional) Required if `enable_allowed_maintenance_window` is set to true. An array of hour slots in a day. For example, specifying 1 will allow maintenance from 1:00am to 2:00am. Specifying 1, 2 will allow maintenance from 1:00am to 3:00m. Possible values are between 0 and 23 | `list(any)` | <pre>[<br>  6,<br>  2<br>]</pre> | no |
| <a name="input_api_server_access_profile_subnet_id"></a> [api\_server\_access\_profile\_subnet\_id](#input\_api\_server\_access\_profile\_subnet\_id) | (Optional) The ID of the Subnet where the API server endpoint is delegated to. | `string` | `null` | no |
| <a name="input_api_server_authorized_ip_ranges"></a> [api\_server\_authorized\_ip\_ranges](#input\_api\_server\_authorized\_ip\_ranges) | (Optional) Set of authorized IP ranges to allow access to API server. | `set(string)` | `null` | no |
| <a name="input_automatic_channel_upgrade"></a> [automatic\_channel\_upgrade](#input\_automatic\_channel\_upgrade) | (Optional) The upgrade channel for this Kubernetes Cluster, see https://docs.microsoft.com/en-us/azure/aks/upgrade-cluster#set-auto-upgrade-channel | `string` | `"node-image"` | no |
| <a name="input_azure_policy_enabled"></a> [azure\_policy\_enabled](#input\_azure\_policy\_enabled) | Optional) Should the Azure Policy Add-On be enabled? more info: https://docs.microsoft.com/en-ie/azure/governance/policy/concepts/rego-for-aks | `bool` | `false` | no |
| <a name="input_blob_driver_enabled"></a> [blob\_driver\_enabled](#input\_blob\_driver\_enabled) | (Optional) Is the Blob CSI driver enabled? Defaults to false | `bool` | `false` | no |
| <a name="input_cluster_custom_log_categories"></a> [cluster\_custom\_log\_categories](#input\_cluster\_custom\_log\_categories) | (optional) A list of strings with supported category groups for postgresql cluster log monitoring diagnostics | `list(string)` | `[]` | no |
| <a name="input_default_node_pool_enable_auto_scaling"></a> [default\_node\_pool\_enable\_auto\_scaling](#input\_default\_node\_pool\_enable\_auto\_scaling) | (Optional) Should the Kubernetes Auto Scaler be enabled for this Node Pool? | `bool` | `null` | no |
| <a name="input_default_node_pool_enable_host_encryption"></a> [default\_node\_pool\_enable\_host\_encryption](#input\_default\_node\_pool\_enable\_host\_encryption) | (Optional) Should the nodes in the Default Node Pool have host encryption enabled? | `bool` | `null` | no |
| <a name="input_default_node_pool_enable_node_public_ip"></a> [default\_node\_pool\_enable\_node\_public\_ip](#input\_default\_node\_pool\_enable\_node\_public\_ip) | (Optional) Should nodes in this Node Pool have a Public IP Address? | `bool` | `null` | no |
| <a name="input_default_node_pool_fips_enabled"></a> [default\_node\_pool\_fips\_enabled](#input\_default\_node\_pool\_fips\_enabled) | (Optional) Should the nodes in this Node Pool have Federal Information Processing Standard enabled? | `bool` | `null` | no |
| <a name="input_default_node_pool_kubelet_disk_type"></a> [default\_node\_pool\_kubelet\_disk\_type](#input\_default\_node\_pool\_kubelet\_disk\_type) | (Optional) The type of disk used by kubelet. Possible values are OS and Temporary.' | `string` | `"OS"` | no |
| <a name="input_default_node_pool_max_count"></a> [default\_node\_pool\_max\_count](#input\_default\_node\_pool\_max\_count) | (Optional) Required when `default_node_pool_enable_auto_scaling` is set to true. The maximum number of nodes which should exist in this Node Pool. | `number` | `null` | no |
| <a name="input_default_node_pool_max_pods"></a> [default\_node\_pool\_max\_pods](#input\_default\_node\_pool\_max\_pods) | (Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_default_node_pool_message_of_the_day"></a> [default\_node\_pool\_message\_of\_the\_day](#input\_default\_node\_pool\_message\_of\_the\_day) | (Optional) A base64-encoded string which will be written to /etc/motd after decoding. This allows customization of the message of the day for Linux nodes. It cannot be specified for Windows nodes and must be a static string (i.e. will be printed raw and not executed as a script). Changing this forces a new resource to be created | `string` | `null` | no |
| <a name="input_default_node_pool_min_count"></a> [default\_node\_pool\_min\_count](#input\_default\_node\_pool\_min\_count) | (Optional) Required when `default_node_pool_enable_auto_scaling` is set to true. The minimum number of nodes which should exist in this Node Pool. | `number` | `null` | no |
| <a name="input_default_node_pool_name"></a> [default\_node\_pool\_name](#input\_default\_node\_pool\_name) | (Optional) Required when `existing_aks_cluster` is set to false. The name which should be used for the default Kubernetes Node Pool. | `string` | `""` | no |
| <a name="input_default_node_pool_node_count"></a> [default\_node\_pool\_node\_count](#input\_default\_node\_pool\_node\_count) | (Optional) Required when `default_node_pool_enable_auto_scaling` is set to false. The number of nodes which should exist in default Node Pool. | `number` | `null` | no |
| <a name="input_default_node_pool_node_labels"></a> [default\_node\_pool\_node\_labels](#input\_default\_node\_pool\_node\_labels) | (Optional) A map of Kubernetes labels which should be applied to nodes in the Default Node Pool. | `map(string)` | `null` | no |
| <a name="input_default_node_pool_only_critical_addons_enabled"></a> [default\_node\_pool\_only\_critical\_addons\_enabled](#input\_default\_node\_pool\_only\_critical\_addons\_enabled) | (Optional) Enabling this option will taint default node pool with CriticalAddonsOnly=true:NoSchedule taint | `bool` | `false` | no |
| <a name="input_default_node_pool_os_disk_size_gb"></a> [default\_node\_pool\_os\_disk\_size\_gb](#input\_default\_node\_pool\_os\_disk\_size\_gb) | (Optional) The size of the OS Disk which should be used for each agent in the default Node Pool. | `number` | `64` | no |
| <a name="input_default_node_pool_os_disk_type"></a> [default\_node\_pool\_os\_disk\_type](#input\_default\_node\_pool\_os\_disk\_type) | (Optional) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed | `string` | `null` | no |
| <a name="input_default_node_pool_os_sku"></a> [default\_node\_pool\_os\_sku](#input\_default\_node\_pool\_os\_sku) | (Optional) OsSKU to be used to specify Linux OSType. Not applicable to Windows OSType. | `string` | `null` | no |
| <a name="input_default_node_pool_proximity_placement_group_id"></a> [default\_node\_pool\_proximity\_placement\_group\_id](#input\_default\_node\_pool\_proximity\_placement\_group\_id) | (Optional) The ID of the Proximity Placement Group. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_default_node_pool_public_ip_prefix_id"></a> [default\_node\_pool\_public\_ip\_prefix\_id](#input\_default\_node\_pool\_public\_ip\_prefix\_id) | (Optional) Resource ID for the Public IP Addresses Prefix for the nodes in this Node Pool. | `string` | `null` | no |
| <a name="input_default_node_pool_tags"></a> [default\_node\_pool\_tags](#input\_default\_node\_pool\_tags) | (Optional) Tags for the node pool | `map(string)` | `null` | no |
| <a name="input_default_node_pool_ultra_ssd_enabled"></a> [default\_node\_pool\_ultra\_ssd\_enabled](#input\_default\_node\_pool\_ultra\_ssd\_enabled) | (Optional) Used to specify whether the UltraSSD is enabled in the Default Node Pool. | `bool` | `null` | no |
| <a name="input_default_node_pool_upgrade_max_surge"></a> [default\_node\_pool\_upgrade\_max\_surge](#input\_default\_node\_pool\_upgrade\_max\_surge) | (Optional) The maximum number or percentage of nodes which will be added to the Node Pool size during an upgrade. ref : https://registry.terraform.io/providers/hashicorp/azurerm/3.9.0/docs/resources/kubernetes_cluster#max_surge | `string` | `"2"` | no |
| <a name="input_default_node_pool_vm_size"></a> [default\_node\_pool\_vm\_size](#input\_default\_node\_pool\_vm\_size) | (optional) The size of the Virtual Machine, such as Standard\_DS2\_v2. | `string` | `"Standard_DS2_v2"` | no |
| <a name="input_default_node_pool_workload_runtime"></a> [default\_node\_pool\_workload\_runtime](#input\_default\_node\_pool\_workload\_runtime) | (Optional) Specifies the workload runtime used by the node pool. Possible values are OCIContainer and KataMshvVmIsolation | `string` | `null` | no |
| <a name="input_default_node_pool_zones"></a> [default\_node\_pool\_zones](#input\_default\_node\_pool\_zones) | (Optional) Specifies a list of Availability Zones in which this Kubernetes Cluster should be located. Changing this forces a new Kubernetes Cluster to be created. | `list(string)` | `[]` | no |
| <a name="input_disk_driver_enabled"></a> [disk\_driver\_enabled](#input\_disk\_driver\_enabled) | (Optional) Is the Disk CSI driver enabled? Defaults to true. | `bool` | `true` | no |
| <a name="input_disk_driver_version"></a> [disk\_driver\_version](#input\_disk\_driver\_version) | (Optional) Disk CSI Driver version to be used. Possible values are v1 and v2. Defaults to v1. | `string` | `"v1"` | no |
| <a name="input_disk_encryption_set_id"></a> [disk\_encryption\_set\_id](#input\_disk\_encryption\_set\_id) | (Optional) The ID of the Disk Encryption Set which should be used for the Nodes and Volumes. | `string` | `null` | no |
| <a name="input_dns_prefix"></a> [dns\_prefix](#input\_dns\_prefix) | (optional) Required when dns\_prefix\_private\_cluster is not specified. DNS prefix specified when creating the managed cluster. | `string` | `null` | no |
| <a name="input_dns_prefix_private_cluster"></a> [dns\_prefix\_private\_cluster](#input\_dns\_prefix\_private\_cluster) | (optional) Required when dns\_prefix is not specified. Specifies the DNS prefix to use with private clusters. | `string` | `null` | no |
| <a name="input_dns_service_ip"></a> [dns\_service\_ip](#input\_dns\_service\_ip) | (Optional) IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). | `string` | `null` | no |
| <a name="input_docker_bridge_cidr"></a> [docker\_bridge\_cidr](#input\_docker\_bridge\_cidr) | (Optional) IP address (in CIDR notation) used as the Docker bridge IP address on nodes. **NOTE**: docker\_bridge\_cidr has been deprecated as the API no longer supports it and will be removed in version 4.0 of the provider. | `string` | `null` | no |
| <a name="input_ebpf_data_plane"></a> [ebpf\_data\_plane](#input\_ebpf\_data\_plane) | (Optional) Specifies the eBPF data plane used for building the Kubernetes network. Possible value is cilium. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_enable_allowed_maintenance_window"></a> [enable\_allowed\_maintenance\_window](#input\_enable\_allowed\_maintenance\_window) | (optional) Whether to enable the [allowed maintenance window](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#allowed) block or not? | `bool` | `true` | no |
| <a name="input_enable_api_server_access_profile"></a> [enable\_api\_server\_access\_profile](#input\_enable\_api\_server\_access\_profile) | (Optional) Whether to enable API server access profile or not? | `bool` | `false` | no |
| <a name="input_enable_cluster_all_category_group_log"></a> [enable\_cluster\_all\_category\_group\_log](#input\_enable\_cluster\_all\_category\_group\_log) | (optional) Whether to enable all category group log for Azure Kubernetes cluster or not? | `bool` | `false` | no |
| <a name="input_enable_cluster_all_metrics"></a> [enable\_cluster\_all\_metrics](#input\_enable\_cluster\_all\_metrics) | (optional) Whether to enable all metrics for diagnostics for Azure Kubernetes cluster or not? | `bool` | `false` | no |
| <a name="input_enable_cluster_audit_category_group_log"></a> [enable\_cluster\_audit\_category\_group\_log](#input\_enable\_cluster\_audit\_category\_group\_log) | (optional) Whether to enable only audit category group log for Azure Kubernetes cluster or not? | `string` | `true` | no |
| <a name="input_enable_cluster_custom_categories_log"></a> [enable\_cluster\_custom\_categories\_log](#input\_enable\_cluster\_custom\_categories\_log) | (optional) Whether to enable custom categories log for Azure Kubernetes cluster or not? | `string` | `false` | no |
| <a name="input_enable_cluster_log_monitor_diagnostic"></a> [enable\_cluster\_log\_monitor\_diagnostic](#input\_enable\_cluster\_log\_monitor\_diagnostic) | (optional) Whether to enable the log monitor diagnostic for Azure Kubernetes cluster or not? | `bool` | `false` | no |
| <a name="input_enable_fluxcd"></a> [enable\_fluxcd](#input\_enable\_fluxcd) | (optional) Whether to enable fluxcd extension(GitOps) or not ? | `bool` | `false` | no |
| <a name="input_enable_fluxcd_az_providers"></a> [enable\_fluxcd\_az\_providers](#input\_enable\_fluxcd\_az\_providers) | (optional) Whether to register the azure provider to kubernetes and container namespaces. **Warning** This is an experimental feature only. | `bool` | `false` | no |
| <a name="input_enable_fluxcd_bucket"></a> [enable\_fluxcd\_bucket](#input\_enable\_fluxcd\_bucket) | (optional) Whether to enable fluxcd S3 bucket or not? | `bool` | `false` | no |
| <a name="input_enable_maintenance_window"></a> [enable\_maintenance\_window](#input\_enable\_maintenance\_window) | (optional) Whether to enable the maintenance window or not? | `bool` | `true` | no |
| <a name="input_enable_microsoft_defender"></a> [enable\_microsoft\_defender](#input\_enable\_microsoft\_defender) | (Optional) whether to enable the microsoft defender or not ,ref: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#microsoft_defender | `bool` | `false` | no |
| <a name="input_enable_not_allowed_maintenance_window"></a> [enable\_not\_allowed\_maintenance\_window](#input\_enable\_not\_allowed\_maintenance\_window) | (optional) Whether to enable the [not\_allowed maintenance window](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#not_allowed) block or not? | `bool` | `false` | no |
| <a name="input_eventhub_authorization_rule_id"></a> [eventhub\_authorization\_rule\_id](#input\_eventhub\_authorization\_rule\_id) | (optional) Specifies the ID of an Event Hub Namespace Authorization Rule used to send Diagnostics Data. | `string` | `null` | no |
| <a name="input_eventhub_name"></a> [eventhub\_name](#input\_eventhub\_name) | (optional) Specifies the name of the Event Hub where Diagnostics Data should be sent. | `string` | `null` | no |
| <a name="input_existing_aks_cluster"></a> [existing\_aks\_cluster](#input\_existing\_aks\_cluster) | (optional) Is there any existing AKS cluster? | `bool` | `false` | no |
| <a name="input_file_driver_enabled"></a> [file\_driver\_enabled](#input\_file\_driver\_enabled) | (Optional) Is the File CSI driver enabled? Defaults to true. | `bool` | `true` | no |
| <a name="input_fluxcd_blob_storage_account_key"></a> [fluxcd\_blob\_storage\_account\_key](#input\_fluxcd\_blob\_storage\_account\_key) | (Optional) Specifies the account key (shared key) to access the storage account. | `string` | `null` | no |
| <a name="input_fluxcd_blob_storage_container_id"></a> [fluxcd\_blob\_storage\_container\_id](#input\_fluxcd\_blob\_storage\_container\_id) | (Required) Specifies the Azure Blob container ID. | `string` | `""` | no |
| <a name="input_fluxcd_blob_storage_local_auth_reference"></a> [fluxcd\_blob\_storage\_local\_auth\_reference](#input\_fluxcd\_blob\_storage\_local\_auth\_reference) | (Optional) Specifies the name of a local secret on the Kubernetes cluster to use as the authentication secret rather than the managed or user-provided configuration secrets. | `string` | `null` | no |
| <a name="input_fluxcd_blob_storage_managed_identity_client_id"></a> [fluxcd\_blob\_storage\_managed\_identity\_client\_id](#input\_fluxcd\_blob\_storage\_managed\_identity\_client\_id) | (Required) Specifies the client ID for authenticating a Managed Identity. | `string` | `""` | no |
| <a name="input_fluxcd_blob_storage_sas_token"></a> [fluxcd\_blob\_storage\_sas\_token](#input\_fluxcd\_blob\_storage\_sas\_token) | (Optional) Specifies the shared access token to access the storage container. | `string` | `null` | no |
| <a name="input_fluxcd_blob_storage_service_principal_client_certificate_base64"></a> [fluxcd\_blob\_storage\_service\_principal\_client\_certificate\_base64](#input\_fluxcd\_blob\_storage\_service\_principal\_client\_certificate\_base64) | (Optional) Base64-encoded certificate used to authenticate a Service Principal . | `string` | `null` | no |
| <a name="input_fluxcd_blob_storage_service_principal_client_certificate_password"></a> [fluxcd\_blob\_storage\_service\_principal\_client\_certificate\_password](#input\_fluxcd\_blob\_storage\_service\_principal\_client\_certificate\_password) | (Optional) Specifies the password for the certificate used to authenticate a Service Principal . | `string` | `null` | no |
| <a name="input_fluxcd_blob_storage_service_principal_client_certificate_send_chain"></a> [fluxcd\_blob\_storage\_service\_principal\_client\_certificate\_send\_chain](#input\_fluxcd\_blob\_storage\_service\_principal\_client\_certificate\_send\_chain) | (Optional) Specifies whether to include x5c header in client claims when acquiring a token to enable subject name / issuer based authentication for the client certificate. | `string` | `null` | no |
| <a name="input_fluxcd_blob_storage_service_principal_client_id"></a> [fluxcd\_blob\_storage\_service\_principal\_client\_id](#input\_fluxcd\_blob\_storage\_service\_principal\_client\_id) | (Required) Specifies the client ID for authenticating a Service Principal. | `string` | `""` | no |
| <a name="input_fluxcd_blob_storage_service_principal_client_secret"></a> [fluxcd\_blob\_storage\_service\_principal\_client\_secret](#input\_fluxcd\_blob\_storage\_service\_principal\_client\_secret) | (Optional) Specifies the client secret for authenticating a Service Principal. | `string` | `null` | no |
| <a name="input_fluxcd_blob_storage_service_principal_tenant_id"></a> [fluxcd\_blob\_storage\_service\_principal\_tenant\_id](#input\_fluxcd\_blob\_storage\_service\_principal\_tenant\_id) | (Required) Specifies the tenant ID for authenticating a Service Principal. | `string` | `""` | no |
| <a name="input_fluxcd_blob_storage_ssas_token"></a> [fluxcd\_blob\_storage\_ssas\_token](#input\_fluxcd\_blob\_storage\_ssas\_token) | (Optional) Specifies the shared access token to access the storage container. | `string` | `null` | no |
| <a name="input_fluxcd_blob_storage_sync_interval_in_seconds"></a> [fluxcd\_blob\_storage\_sync\_interval\_in\_seconds](#input\_fluxcd\_blob\_storage\_sync\_interval\_in\_seconds) | (Optional) Specifies the interval at which to re-reconcile the cluster Azure Blob source with the remote. | `number` | `null` | no |
| <a name="input_fluxcd_blob_storage_timeout_in_seconds"></a> [fluxcd\_blob\_storage\_timeout\_in\_seconds](#input\_fluxcd\_blob\_storage\_timeout\_in\_seconds) | (Optional) Specifies the maximum time to attempt to reconcile the cluster Azure Blob source with the remote. | `number` | `null` | no |
| <a name="input_fluxcd_bucket_access_key"></a> [fluxcd\_bucket\_access\_key](#input\_fluxcd\_bucket\_access\_key) | (Optional) Specifies the plaintext access key used to securely access the S3 bucket. | `string` | `null` | no |
| <a name="input_fluxcd_bucket_local_auth_reference"></a> [fluxcd\_bucket\_local\_auth\_reference](#input\_fluxcd\_bucket\_local\_auth\_reference) | (Optional) Specifies the name of a local secret on the Kubernetes cluster to use as the authentication secret rather than the managed or user-provided configuration secrets. It must be between 1 and 63 characters. It can contain only lowercase letters, numbers, and hyphens (-). It must start and end with a lowercase letter or number. | `string` | `null` | no |
| <a name="input_fluxcd_bucket_name"></a> [fluxcd\_bucket\_name](#input\_fluxcd\_bucket\_name) | (Optional) Specifies the bucket name to sync from the url endpoint for the flux configuration. Required if `enable_fluxcd_bucket` is true. | `string` | `""` | no |
| <a name="input_fluxcd_bucket_secret_key_base64"></a> [fluxcd\_bucket\_secret\_key\_base64](#input\_fluxcd\_bucket\_secret\_key\_base64) | (Optional) Specifies the Base64-encoded secret key used to authenticate with the bucket source. | `string` | `null` | no |
| <a name="input_fluxcd_bucket_sync_interval_in_seconds"></a> [fluxcd\_bucket\_sync\_interval\_in\_seconds](#input\_fluxcd\_bucket\_sync\_interval\_in\_seconds) | (Optional) Specifies the interval at which to re-reconcile the cluster git repository source with the remote. Defaults to 600. | `number` | `null` | no |
| <a name="input_fluxcd_bucket_timeout_in_seconds"></a> [fluxcd\_bucket\_timeout\_in\_seconds](#input\_fluxcd\_bucket\_timeout\_in\_seconds) | (Optional) Specifies the maximum time to attempt to reconcile the cluster git repository source with the remote. Defaults to 600. | `number` | `null` | no |
| <a name="input_fluxcd_bucket_tls_enabled"></a> [fluxcd\_bucket\_tls\_enabled](#input\_fluxcd\_bucket\_tls\_enabled) | (Optional) Specify whether to communicate with a bucket using TLS is enabled. Defaults to true. | `bool` | `null` | no |
| <a name="input_fluxcd_bucket_url"></a> [fluxcd\_bucket\_url](#input\_fluxcd\_bucket\_url) | (Optional) Specifies the URL to sync for the flux configuration S3 bucket. It must start with http:// or https://. Required if `enable_fluxcd_bucket` is true. | `string` | `""` | no |
| <a name="input_fluxcd_configuration_name"></a> [fluxcd\_configuration\_name](#input\_fluxcd\_configuration\_name) | (Optional) Specifies the name which should be used for this Kubernetes Flux Configuration. Required if `enable_fluxcd` is true. Changing this forces a new Kubernetes Flux Configuration to be created. | `string` | `null` | no |
| <a name="input_fluxcd_continuous_reconciliation_enabled"></a> [fluxcd\_continuous\_reconciliation\_enabled](#input\_fluxcd\_continuous\_reconciliation\_enabled) | (Optional) Whether the configuration will keep its reconciliation of its kustomizations and sources with the repository. Defaults to true. | `bool` | `null` | no |
| <a name="input_fluxcd_extension_configuration_protected_settings"></a> [fluxcd\_extension\_configuration\_protected\_settings](#input\_fluxcd\_extension\_configuration\_protected\_settings) | (optional) Configuration settings that are sensitive, as name-value pairs for configuring this extension | `map(string)` | `{}` | no |
| <a name="input_fluxcd_extension_configuration_settings"></a> [fluxcd\_extension\_configuration\_settings](#input\_fluxcd\_extension\_configuration\_settings) | (Optional) Configuration settings, as name-value pairs for configuring this extension. | `map(string)` | `{}` | no |
| <a name="input_fluxcd_extension_name"></a> [fluxcd\_extension\_name](#input\_fluxcd\_extension\_name) | (optional)Specifies the name which should be used for this Kubernetes Cluster Extension. Changing this forces a new Kubernetes Cluster Extension to be created. | `string` | `"fluxcd"` | no |
| <a name="input_fluxcd_extension_release_namespace"></a> [fluxcd\_extension\_release\_namespace](#input\_fluxcd\_extension\_release\_namespace) | (Optional) Namespace where the extension release must be placed for a cluster scoped extension. If this namespace does not exist, it will be created. Changing this forces a new Kubernetes Cluster Extension to be created. | `string` | `null` | no |
| <a name="input_fluxcd_extension_release_train"></a> [fluxcd\_extension\_release\_train](#input\_fluxcd\_extension\_release\_train) | (Optional) The release train used by this extension. Possible values include but are not limited to Stable, Preview. Changing this forces a new Kubernetes Cluster Extension to be created. | `string` | `null` | no |
| <a name="input_fluxcd_extension_target_namespace"></a> [fluxcd\_extension\_target\_namespace](#input\_fluxcd\_extension\_target\_namespace) | (Optional) Namespace where the extension will be created for a namespace scoped extension. If this namespace does not exist, it will be created. Changing this forces a new Kubernetes Cluster Extension to be created. | `string` | `null` | no |
| <a name="input_fluxcd_extension_version"></a> [fluxcd\_extension\_version](#input\_fluxcd\_extension\_version) | (Optional) User-specified version that the extension should pin to. If it is not set, Azure will use the latest version and auto upgrade it. Changing this forces a new Kubernetes Cluster Extension to be created. | `string` | `null` | no |
| <a name="input_fluxcd_git_repository_https_ca_cert_base64"></a> [fluxcd\_git\_repository\_https\_ca\_cert\_base64](#input\_fluxcd\_git\_repository\_https\_ca\_cert\_base64) | (Optional) Specifies the Base64-encoded HTTPS certificate authority contents used to access git private git repositories over HTTPS. | `string` | `null` | no |
| <a name="input_fluxcd_git_repository_https_key_base64"></a> [fluxcd\_git\_repository\_https\_key\_base64](#input\_fluxcd\_git\_repository\_https\_key\_base64) | (Optional) Specifies the Base64-encoded HTTPS personal access token or password that will be used to access the repository. | `string` | `null` | no |
| <a name="input_fluxcd_git_repository_https_user"></a> [fluxcd\_git\_repository\_https\_user](#input\_fluxcd\_git\_repository\_https\_user) | (Optional) Specifies the plaintext HTTPS username used to access private git repositories over HTTPS. | `string` | `null` | no |
| <a name="input_fluxcd_git_repository_local_auth_reference"></a> [fluxcd\_git\_repository\_local\_auth\_reference](#input\_fluxcd\_git\_repository\_local\_auth\_reference) | (Optional) Specifies the name of a local secret on the Kubernetes cluster to use as the authentication secret rather than the managed or user-provided configuration secrets. It must be between 1 and 63 characters. It can contain only lowercase letters, numbers, and hyphens (-). It must start and end with a lowercase letter or number. | `string` | `null` | no |
| <a name="input_fluxcd_git_repository_reference_type"></a> [fluxcd\_git\_repository\_reference\_type](#input\_fluxcd\_git\_repository\_reference\_type) | (Optional) Specifies the source reference type for the GitRepository object. Possible values are branch, commit, semver and tag. | `string` | `"branch"` | no |
| <a name="input_fluxcd_git_repository_reference_value"></a> [fluxcd\_git\_repository\_reference\_value](#input\_fluxcd\_git\_repository\_reference\_value) | (Optional) Specifies the source reference value for the GitRepository object. | `string` | `"main"` | no |
| <a name="input_fluxcd_git_repository_ssh_known_hosts_base64"></a> [fluxcd\_git\_repository\_ssh\_known\_hosts\_base64](#input\_fluxcd\_git\_repository\_ssh\_known\_hosts\_base64) | (Optional) Specifies the Base64-encoded known\_hosts value containing public SSH keys required to access private git repositories over SSH. | `string` | `null` | no |
| <a name="input_fluxcd_git_repository_ssh_private_key_base64"></a> [fluxcd\_git\_repository\_ssh\_private\_key\_base64](#input\_fluxcd\_git\_repository\_ssh\_private\_key\_base64) | (Optional) Specifies the Base64-encoded SSH private key in PEM format. | `string` | `null` | no |
| <a name="input_fluxcd_git_repository_sync_interval_in_seconds"></a> [fluxcd\_git\_repository\_sync\_interval\_in\_seconds](#input\_fluxcd\_git\_repository\_sync\_interval\_in\_seconds) | (Optional) Specifies the interval at which to re-reconcile the cluster git repository source with the remote. Defaults to 600. | `number` | `null` | no |
| <a name="input_fluxcd_git_repository_timeout_in_seconds"></a> [fluxcd\_git\_repository\_timeout\_in\_seconds](#input\_fluxcd\_git\_repository\_timeout\_in\_seconds) | (Optional) Specifies the maximum time to attempt to reconcile the cluster git repository source with the remote. Defaults to 600. | `number` | `null` | no |
| <a name="input_fluxcd_git_repository_url"></a> [fluxcd\_git\_repository\_url](#input\_fluxcd\_git\_repository\_url) | (Optional) Specifies the URL to sync for the flux configuration git repository. It must start with http://, https://, git@ or ssh://. Required if `enable_fluxcd` is true | `string` | `""` | no |
| <a name="input_fluxcd_namespace"></a> [fluxcd\_namespace](#input\_fluxcd\_namespace) | (Optional) Specifies the namespace to which this configuration is installed to. Required if `enable_fluxcd` is true. Changing this forces a new Kubernetes Flux Configuration to be created. | `string` | `null` | no |
| <a name="input_fluxcd_scope"></a> [fluxcd\_scope](#input\_fluxcd\_scope) | (Optional) Specifies the scope at which the operator will be installed. Possible values are cluster and namespace. Defaults to namespace. Changing this forces a new Kubernetes Flux Configuration to be created. | `string` | `null` | no |
| <a name="input_http_application_routing_enabled"></a> [http\_application\_routing\_enabled](#input\_http\_application\_routing\_enabled) | (Optional) Should HTTP Application Routing be enabled? | `bool` | `null` | no |
| <a name="input_http_proxy_config"></a> [http\_proxy\_config](#input\_http\_proxy\_config) | Proxy config: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#http_proxy | `any` | `null` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | (optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Kubernetes Cluster | `set(string)` | `null` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | (optional) Specifies the type of Managed Service Identity that should be configured on this Kubernetes Cluster. | `string` | `"SystemAssigned"` | no |
| <a name="input_image_cleaner_enabled"></a> [image\_cleaner\_enabled](#input\_image\_cleaner\_enabled) | (Optional) Specifies whether Image Cleaner is enabled. | `bool` | `false` | no |
| <a name="input_image_cleaner_interval_hours"></a> [image\_cleaner\_interval\_hours](#input\_image\_cleaner\_interval\_hours) | (Optional) Specifies the interval in hours when images should be cleaned up. | `number` | `null` | no |
| <a name="input_include_preview"></a> [include\_preview](#input\_include\_preview) | (Optional) Should Preview versions of Kubernetes in AKS be included? Defaults to false | `bool` | `false` | no |
| <a name="input_ingress_app_gw_enabled"></a> [ingress\_app\_gw\_enabled](#input\_ingress\_app\_gw\_enabled) | If the Ingress Application Gateway is should be enabled or not? | `bool` | `false` | no |
| <a name="input_ingress_app_gw_id"></a> [ingress\_app\_gw\_id](#input\_ingress\_app\_gw\_id) | (Optional) The ID of the Application Gateway to integrate with the ingress controller of this Kubernetes Cluster, ref:  https://docs.microsoft.com/en-us/azure/application-gateway/tutorial-ingress-controller-add-on-existing | `string` | `null` | no |
| <a name="input_ingress_app_gw_name"></a> [ingress\_app\_gw\_name](#input\_ingress\_app\_gw\_name) | (Optional) The name of the Application Gateway to be used or created in the Nodepool Resource Group, which in turn will be integrated with the ingress controller of this Kubernetes Cluster, ref: https://docs.microsoft.com/azure/application-gateway/tutorial-ingress-controller-add-on-new | `string` | `null` | no |
| <a name="input_ingress_app_gw_subnet_cidr"></a> [ingress\_app\_gw\_subnet\_cidr](#input\_ingress\_app\_gw\_subnet\_cidr) | (Optional) The subnet CIDR to be used to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster, ref: https://docs.microsoft.com/azure/application-gateway/tutorial-ingress-controller-add-on-new | `string` | `null` | no |
| <a name="input_ingress_app_gw_subnet_id"></a> [ingress\_app\_gw\_subnet\_id](#input\_ingress\_app\_gw\_subnet\_id) | (Optional) The ID of the subnet on which to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster, ref: https://docs.microsoft.com/azure/application-gateway/tutorial-ingress-controller-add-on-new | `string` | `null` | no |
| <a name="input_key_data"></a> [key\_data](#input\_key\_data) | (optional) The Admin Username for the Cluster. Changing this forces a new resource to be created.) An ssh\_key block.Only one is currently allowed. Changing this will update the key on all node pools. More information can be found in the [documentation](https://learn.microsoft.com/en-us/azure/aks/node-access#update-ssh-key-on-an-existing-aks-cluster-preview). | `string` | `""` | no |
| <a name="input_key_vault_secrets_provider_enabled"></a> [key\_vault\_secrets\_provider\_enabled](#input\_key\_vault\_secrets\_provider\_enabled) | (Optional) If the secrets provider should be enabled | `bool` | `false` | no |
| <a name="input_key_vault_secrets_provider_secret_rotation_enabled"></a> [key\_vault\_secrets\_provider\_secret\_rotation\_enabled](#input\_key\_vault\_secrets\_provider\_secret\_rotation\_enabled) | (Optional) Is secret rotation enabled? | `bool` | `false` | no |
| <a name="input_key_vault_secrets_provider_secret_rotation_interval"></a> [key\_vault\_secrets\_provider\_secret\_rotation\_interval](#input\_key\_vault\_secrets\_provider\_secret\_rotation\_interval) | (Optional) The interval to poll for secret rotation. This attribute is only set when secret\_rotation is true and defaults to 2m. | `string` | `null` | no |
| <a name="input_kubelet_identity_client_id"></a> [kubelet\_identity\_client\_id](#input\_kubelet\_identity\_client\_id) | (Optional) The Client ID of the user-defined Managed Identity to be assigned to the Kubelets. If not specified a Managed Identity is created automatically.Can be also specified when kubelet\_identity is true | `string` | `null` | no |
| <a name="input_kubelet_identity_enabled"></a> [kubelet\_identity\_enabled](#input\_kubelet\_identity\_enabled) | (optional) If kubelet identity should be enabled | `bool` | `false` | no |
| <a name="input_kubelet_identity_object_id"></a> [kubelet\_identity\_object\_id](#input\_kubelet\_identity\_object\_id) | (optional) The Object ID of the user-defined Managed Identity assigned to the Kubelets.If not specified a Managed Identity is created automatically.Can be also specified when kubelet\_identity is true | `string` | `null` | no |
| <a name="input_kubelet_identity_user_assigned_identity_id"></a> [kubelet\_identity\_user\_assigned\_identity\_id](#input\_kubelet\_identity\_user\_assigned\_identity\_id) | (optional) The ID of the User Assigned Identity assigned to the Kubelets. If not specified a Managed Identity is created automatically.Can be also specified when kubelet\_identity is true | `string` | `null` | no |
| <a name="input_kubernetes_cluster_id"></a> [kubernetes\_cluster\_id](#input\_kubernetes\_cluster\_id) | (optional) Kubernetes Cluster ID of the existing aks cluster | `string` | `""` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | (Optional) Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time and will change as per the stable availability of the AKS version. It is also set as orchestrator version of nodepools if not specified. | `string` | `""` | no |
| <a name="input_kustomizations"></a> [kustomizations](#input\_kustomizations) | (optional) FluxCD Kustomization Configurations. `name` is Required if `enable_fluxcd` is true | <pre>list(object({<br>    path                       = optional(string)<br>    name                       = optional(string)<br>    timeout_in_seconds         = optional(number)<br>    sync_interval_in_seconds   = optional(number)<br>    recreating_enabled         = optional(bool)<br>    garbage_collection_enabled = optional(bool)<br>    retry_interval_in_seconds  = optional(number)<br>    depends_on                 = optional(list(string))<br>  }))</pre> | `[]` | no |
| <a name="input_load_balancer_sku"></a> [load\_balancer\_sku](#input\_load\_balancer\_sku) | (Optional) Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are basic and standard. Defaults to standard. Changing this forces a new resource to be created. | `string` | `"standard"` | no |
| <a name="input_local_account_disabled"></a> [local\_account\_disabled](#input\_local\_account\_disabled) | (Optional) - If true local accounts will be disabled. Defaults to false. see https://docs.microsoft.com/en-us/azure/aks/managed-aad#azure-ad-authentication-overview | `bool` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | (optional) The location where the Managed Kubernetes Cluster should be created. | `string` | `"westeurope"` | no |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | (Optional) Specifies the ID of the Log Analytics Workspace where the audit logs collected by Microsoft Defender & OMS agent should be sent to | `string` | `null` | no |
| <a name="input_monitor_diagnostic_log_analytics_destination_type"></a> [monitor\_diagnostic\_log\_analytics\_destination\_type](#input\_monitor\_diagnostic\_log\_analytics\_destination\_type) | (optional)  Possible values are AzureDiagnostics and Dedicated. When set to Dedicated, logs sent to a Log Analytics workspace will go into resource specific tables, instead of the legacy AzureDiagnostics table | `string` | `null` | no |
| <a name="input_monitor_diagnostic_log_analytics_workspace_id"></a> [monitor\_diagnostic\_log\_analytics\_workspace\_id](#input\_monitor\_diagnostic\_log\_analytics\_workspace\_id) | (optional) Specifies the ID of a Log Analytics Workspace where Diagnostics Data should be sent. | `string` | `null` | no |
| <a name="input_monitor_diagnostic_storage_account_id"></a> [monitor\_diagnostic\_storage\_account\_id](#input\_monitor\_diagnostic\_storage\_account\_id) | (optional) The ID of the Storage Account where logs should be sent. | `string` | `null` | no |
| <a name="input_network_plugin"></a> [network\_plugin](#input\_network\_plugin) | (Optional) Network plugin to use for networking. | `string` | `"kubenet"` | no |
| <a name="input_network_plugin_mode"></a> [network\_plugin\_mode](#input\_network\_plugin\_mode) | (Optional) Specifies the network plugin mode used for building the Kubernetes network. Possible value is overlay. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_network_policy"></a> [network\_policy](#input\_network\_policy) | (Optional) Sets up network policy to be used with Azure CNI. | `string` | `"calico"` | no |
| <a name="input_node_resource_group"></a> [node\_resource\_group](#input\_node\_resource\_group) | (Optional) The name of the Resource Group where the Kubernetes Nodes should exist. | `string` | `null` | no |
| <a name="input_not_allowed_maintenance_window_end"></a> [not\_allowed\_maintenance\_window\_end](#input\_not\_allowed\_maintenance\_window\_end) | (optional) Required if `enable_not_allowed_maintenance_window` is set to true The end of a time span, formatted as an RFC3339 string. | `string` | `null` | no |
| <a name="input_not_allowed_maintenance_window_start"></a> [not\_allowed\_maintenance\_window\_start](#input\_not\_allowed\_maintenance\_window\_start) | (optional) Required if `enable_not_allowed_maintenance_window` is set to true The start of a time span, formatted as an RFC3339 string. | `string` | `null` | no |
| <a name="input_oidc_issuer_enabled"></a> [oidc\_issuer\_enabled](#input\_oidc\_issuer\_enabled) | (Optional) Enable or Disable the OIDC issuer URL | `bool` | `null` | no |
| <a name="input_open_service_mesh_enabled"></a> [open\_service\_mesh\_enabled](#input\_open\_service\_mesh\_enabled) | (Optional) Is Open Service Mesh enabled? more info: https://docs.microsoft.com/azure/aks/open-service-mesh-about | `bool` | `null` | no |
| <a name="input_outbound_type"></a> [outbound\_type](#input\_outbound\_type) | (Optional) The outbound (egress) routing method which should be used for this Kubernetes Cluster. | `string` | `null` | no |
| <a name="input_partner_solution_id"></a> [partner\_solution\_id](#input\_partner\_solution\_id) | (optional) The ID of the market partner solution where Diagnostics Data should be sent. For potential partner integrations, click to learn more about partner integration. | `string` | `null` | no |
| <a name="input_pod_cidr"></a> [pod\_cidr](#input\_pod\_cidr) | (Optional) The CIDR to use for pod IP addresses. | `string` | `null` | no |
| <a name="input_pod_cidrs"></a> [pod\_cidrs](#input\_pod\_cidrs) | (Optional) A list of CIDRs to use for pod IP addresses. For single-stack networking a single IPv4 CIDR is expected. For dual-stack networking an IPv4 and IPv6 CIDR are expected. Changing this forces a new resource to be created. | `list(string)` | `null` | no |
| <a name="input_private_cluster_enabled"></a> [private\_cluster\_enabled](#input\_private\_cluster\_enabled) | (Optional) Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? | `bool` | `null` | no |
| <a name="input_private_cluster_public_fqdn_enabled"></a> [private\_cluster\_public\_fqdn\_enabled](#input\_private\_cluster\_public\_fqdn\_enabled) | (optional)  Specifies whether a Public FQDN for this Private Cluster should be added. | `bool` | `null` | no |
| <a name="input_private_dns_zone_id"></a> [private\_dns\_zone\_id](#input\_private\_dns\_zone\_id) | (Optional) Either the ID of Private DNS Zone which should be delegated to this Cluster, System to have AKS manage this or None, see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#private_dns_zone_id | `string` | `null` | no |
| <a name="input_role_based_access_control_enabled"></a> [role\_based\_access\_control\_enabled](#input\_role\_based\_access\_control\_enabled) | (Optional) - Whether Role Based Access Control for the Kubernetes Cluster should be enabled. | `bool` | `true` | no |
| <a name="input_run_command_enabled"></a> [run\_command\_enabled](#input\_run\_command\_enabled) | (Optional) Whether to enable run command for the cluster or not? | `bool` | `true` | no |
| <a name="input_service_cidr"></a> [service\_cidr](#input\_service\_cidr) | (Optional) The Network Range used by the Kubernetes service. | `string` | `null` | no |
| <a name="input_service_cidrs"></a> [service\_cidrs](#input\_service\_cidrs) | (Optional) A list of CIDRs to use for Kubernetes services. For single-stack networking a single IPv4 CIDR is expected. For dual-stack networking an IPv4 and IPv6 CIDR are expected. Changing this forces a new resource to be created. | `list(string)` | `null` | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | (Optional) The SKU Tier that should be used for this Kubernetes Cluster | `string` | `null` | no |
| <a name="input_snapshot_controller_enabled"></a> [snapshot\_controller\_enabled](#input\_snapshot\_controller\_enabled) | (Optional) Is the Snapshot Controller enabled? Defaults to true. | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for the cluster | `map(string)` | `null` | no |
| <a name="input_vnet_integration_enabled"></a> [vnet\_integration\_enabled](#input\_vnet\_integration\_enabled) | Should API Server VNet Integration be enabled? For more details please visit [Use API Server VNet Integration.](https://learn.microsoft.com/en-us/azure/aks/api-server-vnet-integration) | `bool` | `false` | no |
| <a name="input_vnet_subnet_id"></a> [vnet\_subnet\_id](#input\_vnet\_subnet\_id) | (optional) The ID of the Subnet where this Node Pool should exist.At this time the vnet\_subnet\_id must be the same for all node pools in the cluster | `string` | `null` | no |
| <a name="input_windows_profile_admin_password"></a> [windows\_profile\_admin\_password](#input\_windows\_profile\_admin\_password) | (optional) The Admin Password for Windows VMs.(Required) if windows\_profile\_enabled is true. | `string` | `"Super$ecUreP@$$w04d"` | no |
| <a name="input_windows_profile_admin_username"></a> [windows\_profile\_admin\_username](#input\_windows\_profile\_admin\_username) | (optional) The Admin Username for Windows VMs. (Required) if windows\_profile\_enabled is true. | `string` | `"azureadmin"` | no |
| <a name="input_windows_profile_enabled"></a> [windows\_profile\_enabled](#input\_windows\_profile\_enabled) | (optional) Is windows profile enabled? | `bool` | `false` | no |
| <a name="input_windows_profile_license"></a> [windows\_profile\_license](#input\_windows\_profile\_license) | (optional)Specifies the type of on-premise license which should be used for Node Pool Windows Virtual Machine | `string` | `"Windows_Server"` | no |
| <a name="input_workload_identity_enabled"></a> [workload\_identity\_enabled](#input\_workload\_identity\_enabled) | (Optional) Specifies whether Azure AD Workload Identity should be enabled for the Cluster. Defaults to false | `bool` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_additional_node_pool_ids"></a> [additional\_node\_pool\_ids](#output\_additional\_node\_pool\_ids) | The IDs of the additional Kubernetes Cluster Node Pools. |
| <a name="output_aks_id"></a> [aks\_id](#output\_aks\_id) | AKS cluster ID |
| <a name="output_azurerm_kubernetes_cluster"></a> [azurerm\_kubernetes\_cluster](#output\_azurerm\_kubernetes\_cluster) | Entire AKS cluster object as an output |

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have any suggestion that would make this project better, feel free to  fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement" with your suggestion.

**⭐️ Don't forget to give the project a star! Thanks again! ⭐️**

<!-- LICENSE -->
## License

Released under [MIT](/LICENSE) by [@ishuar](https://github.com/ishuar).

<!-- CONTACT -->
## Contact

- 👯 [LinkedIn](https://linkedin.com/in/ishuar)

<p align="right"><a href="#top">Back To Top ⬆️</a></p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[contributors-url]: https://github.com/ishuar/terraform-azure-aks/graphs/contributors
[contributors-shield]: https://img.shields.io/github/contributors/ishuar/terraform-azure-aks?style=for-the-badge

[forks-url]: https://github.com/ishuar/terraform-azure-aks/network/members
[forks-shield]: https://img.shields.io/github/forks/ishuar/terraform-azure-aks?style=for-the-badge

[stars-url]: https://github.com/ishuar/terraform-azure-aks/stargazers
[stars-shield]: https://img.shields.io/github/stars/ishuar/terraform-azure-aks?style=for-the-badge

[issues-url]: https://github.com/ishuar/terraform-azure-aks/issues
[issues-shield]: https://img.shields.io/github/issues/ishuar/terraform-azure-aks?style=for-the-badge

[license-url]: https://github.com/ishuar/terraform-azure-aks/blob/main/LICENSE
[license-shield]: https://img.shields.io/github/license/ishuar/terraform-azure-aks?style=for-the-badge