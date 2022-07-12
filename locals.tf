locals {
  storage_account_name    = replace(lower("st${var.function_app_name}"), "/[^a-z0-9]/", "")
  app_service_plan_name   = "${var.function_app_name}-plan"
  autoscale_settings_name = "${var.function_app_name}-autoscale"

  app_insights_key = try(azurerm_application_insights.app_insights[0].instrumentation_key, {})

  default_application_settings = merge(
    var.application_insights_enabled? {"APPINSIGHTS_INSTRUMENTATIONKEY" = local.app_insights_key} : {}
  )
}