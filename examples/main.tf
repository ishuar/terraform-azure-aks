terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.99"
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
