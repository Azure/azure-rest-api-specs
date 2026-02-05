terraform {
  required_providers {
    azapi = {
      source = "Azure/azapi"
    }
  }
}

provider "azapi" {
  # This is not needed after the api is completely onboarded 
  endpoint = [{
    resource_manager_endpoint       = "https://eastus2euap.management.azure.com/"
    resource_manager_audience       = "https://management.core.windows.net/"
    active_directory_authority_host = "https://login.microsoftonline.com"
  }]
}

variable "resource_name" {
  type    = string
  default = "acctest7791"
}

variable "location" {
  type    = string
  default = "eastus2euap"
}

data "azapi_resource" "subscription" {
  type                   = "Microsoft.Resources/subscriptions@2020-06-01"
  response_export_values = ["*"]
}

data "azapi_resource_id" "location" {
  type      = "Microsoft.SignalRService/locations@2023-12-12"
  parent_id = data.azapi_resource.subscription.id
  name      = var.location
}

// OperationId: WebPubSub_CheckNameAvailability
// POST /subscriptions/{subscriptionId}/providers/Microsoft.SignalRService/locations/{location}/checkNameAvailability
resource "azapi_resource_action" "checkNameAvailability" {
  type        = "Microsoft.SignalRService/locations@2024-08-01-preview"
  resource_id = data.azapi_resource_id.location.id
  action      = "checkNameAvailability"
  method      = "POST"
  body = {
    name = "myWebPubSubService"
    type = "Microsoft.SignalRService/WebPubSub"
  }
}

// OperationId: Usages_List
// GET /subscriptions/{subscriptionId}/providers/Microsoft.SignalRService/locations/{location}/usages
data "azapi_resource_action" "usages" {
  type        = "Microsoft.SignalRService/locations@2024-08-01-preview"
  resource_id = data.azapi_resource_id.location.id
  action      = "usages"
  method      = "GET"
}

