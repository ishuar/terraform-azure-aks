terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.55"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  tags = {
    type       = "aks-module"
    managed_by = "terraform"
  }
}
