resource "azurerm_storage_account" "funcsta" {
  name                     = local.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = var.account_replication_type

  tags = var.tags
}

resource "azurerm_app_service_plan" "serviceplan" {
  count               = var.service_plan_id == "" ? 1 : 0  
  name                = local.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  kind = "functionapp"
  sku {
    tier = "Standard"
    size = "S1"
  }

  tags = var.tags
}

resource "azurerm_application_insights" "app_insights" {
  count               = var.application_insights_enabled? 1 : 0
  name                = var.function_app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "other"
  tags                 = var.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_function_app" "functionapp" {
  name                      = var.function_app_name
  location                  = var.location
  resource_group_name       = var.resource_group_name
  app_service_plan_id       = try(azurerm_app_service_plan.serviceplan[0].id, var.service_plan_id)
  storage_account_name       = azurerm_storage_account.funcsta.name
  storage_account_access_key = azurerm_storage_account.funcsta.primary_access_key
  https_only                = true
  version                   = var.function_version
  #client_affinity_enabled   = false
  os_type                   = null # ? "linux" : null

  tags = var.tags

  site_config {
    always_on = false
  }

  identity {
    type = "SystemAssigned"
  }

  app_settings = merge(local.default_application_settings,var.app_settings)

  lifecycle {
    ignore_changes = [
      tags,
      app_settings,
      version
    ]
  }
}