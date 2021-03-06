variable "resource_group_name" {
  description = "The resource group where the resources should be created."
}

variable "location" {
  default     = "eastus"
  description = "The azure datacenter location where the resources should be created."
}

variable "function_app_name" {
  description = "The name for the function app. Without environment naming."
}

variable "function_version" {
  default     = null
  description = "The runtime version the function app should have."
}

variable "account_replication_type" {
  default     = "LRS"
  description = "The Storage Account replication type. See azurerm_storage_account module for posible values."
}
variable "service_plan_id" {
  default     = ""
}
variable "app_settings" {
  default     = {}
  type        = map
  description = "Application settings to insert on creating the function app. Following updates will be ignored, and has to be set manually. Updates done on application deploy or in portal will not affect terraform state file."
}
variable "application_insights_enabled" {
  description = "Enable or disable the Application Insights deployment"
  type        = bool
  default     = true
}
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map

  default = {}
}