# Changelog

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

<!--
## version
### Added
  - Added new feature

### Fixed
  - Bug fixes

### Removed
  - Removed/Deprecated features

### Others
  - Other changes
-->

> **INFO:** This file is only maintained after `v2.0.0` due to no initial availability , please refer to release notes for versions equal or older than `v2.0.0`.

## v2.2.0
### Added

- A complete example is added for the module at [examples/complete](./examples/complete).
- Updated Docs

### Removed

- Removed `retention_policy` block from `azurerm_monitor_diagnostic_setting` resource as it has been deprecated and not supported anymore. Please use [azurerm_storage_management_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy) resource for lifecycle management for retention.
****
  - Following variables are removed and not available in module anymore.
    - `enable_cluster_log_retention_policy`
    - `cluster_log_retention_policy_days`
    - `enable_cluster_metric_retention_policy`
    - `cluster_metric_retention_policy_days`

### Others

- Added automated testing for module via github actions.
  - Syntax/Static testing using `terraform validate`
  - Integration/working testing using `terraform test`

## v2.1.0
### Added

- Getting stable and in-preview AKS versions automatically. Set `kubernetes_version` to static value accordingly if you want to use any specific version and controll upgrades.
  - To enable preview aks version set `include_preview = true`.

### Removed

- Removed `public_network_access_enabled` as it is deprecated from the azurem provider.
> **NOTE:** `public_network_access_enabled` is currently not functional and is not passed to the Azure API. For further information please see this issue. For controlling the public and private exposure of a cluster please see the properties private_cluster_enabled and api_server_access_profile.

### Others
- Updated Docs accordingly.

## v2.0.1
### Fixed

- Corrected variable name to `fluxcd_bucket_name` from `fluxcd_bucket_bucket_name` for [`azurerm_kubernetes_flux_configuration/bucket_name`](https://registry.terraform.io/providers/hashicorp/azurerm/3.75.0/docs/resources/kubernetes_flux_configuration#bucket_name)
- Added missing variable `fluxcd_blob_storage_sas_token` for [`azurerm_kubernetes_flux_configuration/sas_token`](https://registry.terraform.io/providers/hashicorp/azurerm/3.75.0/docs/resources/kubernetes_flux_configuration#sas_token)

### Removed

- Removed deprecated attribute `api_server_authorized_ip_ranges` and use the same variable (`api_server_authorized_ip_ranges`) for `api_server_access_profile` to maintain the backward compatibility. **Removed `api_server_access_profile_authorized_ip_ranges` variable.**
  - Switch to `api_server_authorized_ip_ranges` in case removed variable (api_server_access_profile_authorized_ip_ranges) was used.

## Others

- Modify the default value for `allowed_maintenance_window_day` to `Saturday` from `Monday` in maintenance window.
