output "ssh_pub_key" {
  value = replace(var.public_ssh_key, "\n", "")
}
output "aks_id" {
  value = azurerm_kubernetes_cluster.aks.id
}
