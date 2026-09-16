output "storage_account_name" {
  description = "Storage account that hosts the static website."
  value       = azurerm_storage_account.site.name
}

output "website_endpoint" {
  description = "Public Azure Storage static website endpoint."
  value       = azurerm_storage_account.site.primary_web_endpoint
}

output "resource_group_name" {
  description = "Resource group containing the deployed workload."
  value       = data.azurerm_resource_group.assessment.name
}
