output "outputs" {

#https://tf-numerai-submission-func-app.azurewebsites.net/api/azure_trigger
#webhook_url = azurerm_function_app_function.function.invocation_url
#webhook_url = azurerm_linux_function_app.function_app.outbound_ip_addresses
  value={for node, config in var.nodes:
  node => {
    #docker_repo = var.image_url
    docker_repo = azurerm_container_group.container[node].container[0].image
    webhook_url = "https://${azurerm_linux_function_app.function_app[node].name}.azurewebsites.net/api/azure_trigger"
    webhook_log_group = azurerm_application_insights.app_insights[node].name
    cluster_log_group = azurerm_log_analytics_workspace.container_instance[node].name
    }
  }
  #value = azurerm_resource_group.rg.name
  
  #value = {for node, config in var.nodes:
  #node => {
  #  #docker_repo = aws_ecr_repository.node[node].repository_url
  #  webhook_url = "${aws_apigatewayv2_api.submit.api_endpoint}/predict${split(" ", aws_apigatewayv2_route.submit[node].route_key)[1]}"
  #  cluster_log_group = aws_cloudwatch_log_group.ecs[node].name
  #  webhook_log_group = aws_cloudwatch_log_group.lambda[node].name
  #  api_log_group = aws_cloudwatch_log_group.gateway.name
  #  }
  #}
}