output "azure_subscription_id" {
  description = "azure_subscription_id to use in Github Secrets"
  value       = data.azurerm_subscription.current.subscription_id
}
output "azure_tenant_id" {
  description = "azure_tenant_id to use in Github Secrets"
  value       = data.azurerm_subscription.current.tenant_id
}
output "azure_client_id" {
  description = "azure_client_id to use in Github Secrets"
  value       = azuread_application.github.application_id
}