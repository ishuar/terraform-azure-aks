
## Monitor Diagnostic Setting Locals
locals {
  all_true_cluster                        = var.enable_cluster_all_category_group_log && var.enable_cluster_audit_category_group_log && var.enable_cluster_custom_categories_log
  enable_cluster_all_category_group_logs  = (var.enable_cluster_all_category_group_log && !var.enable_cluster_audit_category_group_log && !var.enable_cluster_custom_categories_log) || local.all_true_cluster
  enable_cluster_audit_category_group_log = var.enable_cluster_audit_category_group_log && !var.enable_cluster_all_category_group_log && !var.enable_cluster_custom_categories_log
  enable_cluster_custom_categories_log    = var.enable_cluster_custom_categories_log && !var.enable_cluster_audit_category_group_log && !var.enable_cluster_all_category_group_log
}

data "azurerm_monitor_diagnostic_categories" "this" {
  count       = var.enable_cluster_log_monitor_diagnostic ? 1 : 0
  resource_id = local.aks_cluster.id
}
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting
resource "azurerm_monitor_diagnostic_setting" "this" {
  count                          = var.enable_cluster_log_monitor_diagnostic ? 1 : 0
  name                           = "${var.name}-diagnostic-settings"
  target_resource_id             = local.aks_cluster.id
  storage_account_id             = var.monitor_diagnostic_storage_account_id
  eventhub_name                  = var.eventhub_name
  eventhub_authorization_rule_id = var.eventhub_authorization_rule_id
  log_analytics_workspace_id     = var.monitor_diagnostic_log_analytics_workspace_id
  log_analytics_destination_type = var.monitor_diagnostic_log_analytics_destination_type
  partner_solution_id            = var.partner_solution_id

  dynamic "enabled_log" {
    for_each = local.enable_cluster_all_category_group_logs ? data.azurerm_monitor_diagnostic_categories.this[0].log_category_groups : toset([])
    content {
      category_group = enabled_log.value
    }
  }

  dynamic "enabled_log" {
    for_each = local.enable_cluster_custom_categories_log ? ["custom_categories_log"] : []
    content {
      category_group = toset(var.cluster_custom_log_categories)
    }
  }

  dynamic "enabled_log" {
    for_each = var.enable_cluster_audit_category_group_log ? ["audit_category_group_log"] : []
    content {
      category_group = "audit"
    }
  }

  dynamic "metric" {
    for_each = var.enable_cluster_all_metrics ? ["enable_cluster_all_metrics_diagnostic_setting"] : []
    content {
      enabled  = var.enable_cluster_all_metrics
      category = "AllMetrics"
    }
  }
}
