data "azurerm_resource_group" "assessment" {
  name = var.resource_group_name
}

resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

locals {
  # Storage account names must be globally unique, lowercase and alphanumeric.
  storage_account_name = substr(
    lower(replace("st${var.project_name}${var.environment}${random_string.suffix.result}", "-", "")),
    0,
    24
  )

  common_tags = merge(
    var.tags,
    {
      environment = var.environment
      project     = var.project_name
    }
  )
}

resource "azurerm_storage_account" "site" {
  name                = local.storage_account_name
  resource_group_name = data.azurerm_resource_group.assessment.name
  location            = data.azurerm_resource_group.assessment.location

  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  https_traffic_only_enabled = true
  min_tls_version            = "TLS1_2"

  # GitHub Actions uploads website files using Microsoft Entra authentication.
  # Disabling shared-key authentication reduces reliance on account keys.
  shared_access_key_enabled = false

  tags = local.common_tags
}

resource "azurerm_storage_account_static_website" "site" {
  storage_account_id = azurerm_storage_account.site.id
  index_document     = "index.html"
  error_404_document = "404.html"
}
