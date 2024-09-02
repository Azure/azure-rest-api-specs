terraform {
  required_providers {
    azapi = {
      source = "Azure/azapi"
    }
  }
}

provider "azapi" {
  # This is not needed after the api is completely onboarded 
  endpoint = [ {
    resource_manager_endpoint = "https://eastus2euap.management.azure.com/"
    resource_manager_audience = "https://management.core.windows.net/"
    active_directory_authority_host = "https://login.microsoftonline.com"
  } ]
}

variable "resource_name" {
  type    = string
  default = "acctest5766"
}

variable "location" {
  type    = string
  default = "eastus2euap"
}

resource "azapi_resource" "resourceGroup" {
  type     = "Microsoft.Resources/resourceGroups@2020-06-01"
  name     = var.resource_name
  location = var.location
}

resource "azapi_resource" "webPubSub" {
  type      = "Microsoft.SignalRService/webPubSub@2023-02-01"
  parent_id = azapi_resource.resourceGroup.id
  name      = var.resource_name
  location  = var.location
  body = {
    properties = {
      disableAadAuth      = false
      disableLocalAuth    = false
      publicNetworkAccess = "Enabled"
      tls = {
        clientCertEnabled = false
      }
    }
    sku = {
      capacity = 1
      name     = "Premium_P1"
    }
  }
  schema_validation_enabled = false
  response_export_values    = ["*"]
}

// OperationId: WebPubSubCustomCertificates_CreateOrUpdate, WebPubSubCustomCertificates_Get, WebPubSubCustomCertificates_Delete
// PUT GET DELETE /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/customCertificates/{certificateName}
resource "azapi_resource" "customCertificate" {
  type      = "Microsoft.SignalRService/webPubSub/customCertificates@2024-08-01-preview"
  parent_id = azapi_resource.webPubSub.id
  name      = var.resource_name
  body = {
    properties = {
      keyVaultBaseUri       = "https://signalrtest.vault.azure.net/"
      keyVaultSecretName    = "domain"
      keyVaultSecretVersion = "856559a3253341e69c23c1737987b959"
    }
  }
  schema_validation_enabled = false
}

// OperationId: WebPubSubCustomDomains_CreateOrUpdate, WebPubSubCustomDomains_Get, WebPubSubCustomDomains_Delete
// PUT GET DELETE /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/customDomains/{name}
resource "azapi_resource" "customDomain" {
  type      = "Microsoft.SignalRService/webPubSub/customDomains@2024-08-01-preview"
  parent_id = azapi_resource.webPubSub.id
  name      = var.resource_name
  body = {
    properties = {
      customCertificate = {
        id = azapi_resource.customCertificate.id
      }
      domainName = "apitest2.e2e-prod.signalr-test.azure.com"
    }
  }
  schema_validation_enabled = false
}

// OperationId: WebPubSubCustomDomains_List
// GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/customDomains
data "azapi_resource_list" "listCustomDomainsByWebPubSub" {
  type       = "Microsoft.SignalRService/webPubSub/customDomains@2024-08-01-preview"
  parent_id  = azapi_resource.webPubSub.id
  depends_on = [azapi_resource.customDomain]
}

