resource "azurerm_resource_group" "aks_rg" {
  name     = "rg-aks-module-test-euw"
  location = "West Europe"
  tags     = local.tags
}

## Minimal Example
module "aks" {
  source = "../"

  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  kubernetes_version  = "1.23.5"
  node_resource_group = "rg-node-aks-module-test-euw"
  dns_prefix          = "exampleaks1"
  public_ssh_key      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC/NdhaxsAXDMNzybpCt7VNBl9d5Tgi2LwG3EJ6O199ao2ad4gCFKaQm6Ba/7p3ce7AFZlnAnRDwj7giIVkTmXD/VPHMr8gSFh743tZR9w50UbmVvy6FtKx/g+KBY+DjxhtKb6H+BP61qbghUGkenV2z7sGaR3Ndz6BGSNCBk+Fw9QrsQBgEoMEzlyggVHnPUJFLTL904xu/9/5jXos4B5j8drHASdLCpu7f0IXOa7+fEGAIFQk89WhRfx6ZEYBymdKeAdLPfHB07V5SdvEfV+8LH+RYPLc6i5xFYDWFKo4Nv/LFuzAugN/N6IO/JSQbyNGrzlH8gNTW86nvx/PMUSswPxOZtMmezOEnSNaO91XZ+Tvk7tSED2k9RVZ6Pv36qZNpHFAq8WY012tZ96jBBzj3maIN05yhnpCdT2qEVngr7a7Cft7AX7ES2VPWmBar+InA2I+jad1IHWMBoUyjS5E4/liH4ilK0dgdjDx3d1tf+EFhTSpKQCm1h9EuvFW+YgyTWlBTNZYK8TzwoYabaLWgiM8BOPcee+0QEmpqsajdihIpeQWhkEgwG3cld5XShp6/h8JbHpfGA27BBJW3Xa1DM3WbN8pYiW76VWRND2Py2463gpsgWZhH6gD8QR864CUFngWgLk8FDwBwjlr7WusCejlMvjklYDUsJ8S0oMCjQ=="
  tags                = local.tags
}
