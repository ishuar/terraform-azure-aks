# Changelog

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).


> **INFO:** This file is only maintained after `v2.0.0` due to no initial availability , please refer to release notes for versions equal or older than `v2.0.0`.


## [v2.0.1]

### Fixed

- Corrected variable name to `fluxcd_bucket_name` from `fluxcd_bucket_bucket_name` for [`azurerm_kubernetes_flux_configuration/bucket_name`](https://registry.terraform.io/providers/hashicorp/azurerm/3.75.0/docs/resources/kubernetes_flux_configuration#bucket_name)
- Added missing variable `fluxcd_blob_storage_sas_token` for [`azurerm_kubernetes_flux_configuration/sas_token`](https://registry.terraform.io/providers/hashicorp/azurerm/3.75.0/docs/resources/kubernetes_flux_configuration#sas_token)

### Others

- Removed deprecated attribute `api_server_authorized_ip_ranges` and use the same variable (`api_server_authorized_ip_ranges`) for `api_server_access_profile` to maintain the backward compatibility. **Removed `api_server_access_profile_authorized_ip_ranges` variable.**

>> Switch to `api_server_authorized_ip_ranges` in case removed variable (api_server_access_profile_authorized_ip_ranges) was used.

- Modify the default value for `allowed_maintenance_window_day` to `Saturday` from `Monday` in maintenance window.
