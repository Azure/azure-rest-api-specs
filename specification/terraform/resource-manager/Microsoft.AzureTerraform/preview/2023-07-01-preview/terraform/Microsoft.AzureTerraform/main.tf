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
  subscription_id = jsondecode(data.azapi_resource.subscription.output).subscriptionId
}

provider "azapi" {
  skip_provider_registration = false
}

variable "resource_name" {
  type    = string
  default = "acctest5125"
}

variable "location" {
  type    = string
  default = "westeurope"
}

data "azapi_resource" "subscription" {
  type                   = "Microsoft.Resources/subscriptions@2020-06-01"
  response_export_values = ["*"]
}

data "azapi_resource_id" "subscriptionScopeProvider" {
  type      = "Microsoft.Resources/providers@2020-06-01"
  parent_id = data.azapi_resource.subscription.id
  name      = "Microsoft.AzureTerraform"
}

resource "azurerm_resource_group" "test_rg" {
  name     = "${var.resource_name}_rg"
  location = var.location
}

resource "azurerm_virtual_network" "test_vn" {
  name                = "${var.resource_name}_vn"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.test_rg.name
}

resource "azapi_resource_action" "exportTerraform_ExportResourceGroup" {
  type        = "Microsoft.AzureTerraform@2023-07-01-preview"
  resource_id = data.azapi_resource_id.subscriptionScopeProvider.id
  action      = "exportTerraform"
  method      = "POST"
  body = {
    type              = "ExportResourceGroup"
    targetProvider    = "azurerm"
    fullProperties    = true
    maskSensitive     = true
    resourceGroupName = azurerm_resource_group.test_rg.name
    namePattern       = "res-"
  }
}

resource "azapi_resource_action" "exportTerraform_ExportResource_1" {
  type        = "Microsoft.AzureTerraform@2023-07-01-preview"
  resource_id = data.azapi_resource_id.subscriptionScopeProvider.id
  action      = "exportTerraform"
  method      = "POST"
  body = {
    type           = "ExportResource"
    targetProvider = "azurerm"
    fullProperties = true
    maskSensitive  = true
    resourceIds    = [azurerm_virtual_network.test_vn.id]
    resourceType   = "azurerm_virtual_network"
    resourceName   = "res-0"
  }
}

resource "azapi_resource_action" "exportTerraform_ExportResource_2" {
  type        = "Microsoft.AzureTerraform@2023-07-01-preview"
  resource_id = data.azapi_resource_id.subscriptionScopeProvider.id
  action      = "exportTerraform"
  method      = "POST"
  body = {
    type           = "ExportResource"
    targetProvider = "azurerm"
    fullProperties = true
    maskSensitive  = true
    resourceIds    = [azurerm_resource_group.test_rg.id]
    resourceType   = "azurerm_virtual_network"
    namePattern    = "res-"
  }
}

resource "azapi_resource_action" "exportTerraform_ExportQuery" {
  type        = "Microsoft.AzureTerraform@2023-07-01-preview"
  resource_id = data.azapi_resource_id.subscriptionScopeProvider.id
  action      = "exportTerraform"
  method      = "POST"
  body = {
    type           = "ExportQuery"
    targetProvider = "azurerm"
    fullProperties = true
    maskSensitive  = true
    query          = "resourceGroup =~ \"${azurerm_resource_group.test_rg.name}\""
    namePattern    = "res-"
    recursive      = false
  }
}
