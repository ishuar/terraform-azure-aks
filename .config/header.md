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

**⭐️ For Latest updates Don't forget to star the repo! ⭐️**

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
  version = "~> 2.2"

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
- [flux-enabled-aks](/examples/flux-enabled-aks)
- [complete](/examples/complete)

## Submodule


**⭐️ Don't forget to give the project a star! Thanks again! ⭐️**
