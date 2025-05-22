terraform {
  required_providers {
    azapi = {
      source = "Azure/azapi"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
    key_vault {
      purge_soft_delete_on_destroy       = false
      purge_soft_deleted_keys_on_destroy = false
    }
  }
  skip_provider_registration = true
}

provider "azapi" {
  skip_provider_registration = false
}

variable "resource_name" {
  type    = string
  default = "acctest2547"
}

variable "location" {
  type    = string
  default = "westeurope"
}

// OperationId: Operations_List
// GET /providers/Microsoft.AzureTerraform/operations
data "azapi_resource_list" "listOperationsByTenant" {
  type      = "Microsoft.AzureTerraform/operations@2023-07-01-preview"
  parent_id = "/"
}

