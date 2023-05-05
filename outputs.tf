output "aks_id" {
  value       = local.aks_cluster.id
  description = "AKS cluster ID"
}

output "azurerm_kubernetes_cluster" {
  value       = local.aks_cluster
  description = "Entire AKS cluster object as an output"
}
output "additional_node_pool_ids" {
  value = {
    for k, v in azurerm_kubernetes_cluster_node_pool.this : k => v.id
  }
  description = "The IDs of the additional Kubernetes Cluster Node Pools."
}
