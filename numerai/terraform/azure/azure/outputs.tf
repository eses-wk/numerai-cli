output "outputs" {
  value= {for node, config in var.nodes:
    node => {
    docker_repo = config.docker_repo
    webhook_url = "https://${azurerm_linux_function_app.function_app[node].name}.azurewebsites.net/api/orchestrators/start_submission"
    resource_group_name = azurerm_resource_group.rg[node].name
    webhook_storage_account_name = azurerm_storage_account.function_app[node].name
    #webhook_log_group = azurerm_log_analytics_workspace.function_app[node].workspace_id
    #cluster_log_group = azurerm_log_analytics_workspace.container_instance[node].workspace_id
    }
  }
}