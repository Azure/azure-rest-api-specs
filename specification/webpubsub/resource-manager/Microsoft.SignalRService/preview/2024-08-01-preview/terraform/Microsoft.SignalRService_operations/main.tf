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
    # Use dogfood endpoint as apis in this tf will not be routed to canary regions
    resource_manager_endpoint       = "https://api-dogfood.resources.windows-int.net/"
    resource_manager_audience       = "https://management.core.windows.net/"
    active_directory_authority_host = "https://login.windows-ppe.net/"
  }]
}

variable "resource_name" {
  type    = string
  default = "acctest9570"
}

variable "location" {
  type    = string
  default = "southeastasia"
}

// OperationId: Operations_List
// GET /providers/Microsoft.SignalRService/operations
data "azapi_resource_list" "listOperationsByTenant" {
  type      = "Microsoft.SignalRService/operations@2024-08-01-preview"
  parent_id = "/"
}

