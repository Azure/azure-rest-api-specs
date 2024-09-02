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
  default = "acctest049822"
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

resource "azapi_resource" "signalR" {
  type      = "Microsoft.SignalRService/SignalR@2023-02-01"
  parent_id = azapi_resource.resourceGroup.id
  name      = var.resource_name
  location  = var.location
  body = jsonencode({
    identity = {
      type                   = "SystemAssigned"
    }
    properties = {
      cors = {
      }
      disableAadAuth   = false
      disableLocalAuth = false
      features = [
        {
          flag  = "ServiceMode"
          value = "Default"
        },
        {
          flag  = "EnableConnectivityLogs"
          value = "False"
        },
        {
          flag  = "EnableMessagingLogs"
          value = "False"
        },
        {
          flag  = "EnableLiveTrace"
          value = "False"
        },
      ]
      publicNetworkAccess = "Enabled"
      resourceLogConfiguration = {
        categories = [
          {
            enabled = "false"
            name    = "MessagingLogs"
          },
          {
            enabled = "false"
            name    = "ConnectivityLogs"
          },
          {
            enabled = "false"
            name    = "HttpRequestLogs"
          },
        ]
      }
      serverless = {
        connectionTimeoutInSeconds = 30
      }
      tls = {
        clientCertEnabled = false
      }
      upstream = {
        templates = [
        ]
      }
    }
    sku = {
      capacity = 1
      name     = "Premium_P1"
    }
  })
  schema_validation_enabled = false
  response_export_values    = ["*"]
}

# Maunal Step: grant msi access to keyvault

// OperationId: SignalRCustomCertificates_CreateOrUpdate, SignalRCustomCertificates_Get, SignalRCustomCertificates_Delete
// PUT GET DELETE /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/customCertificates/{certificateName}
resource "azapi_resource" "customCertificate" {
  type      = "Microsoft.SignalRService/signalR/customCertificates@2024-08-01-preview"
  parent_id = azapi_resource.signalR.id
  name      = var.resource_name
  body = jsonencode({
    properties = {
      keyVaultBaseUri       = "https://signalrtest.vault.azure.net/"
      keyVaultSecretName    = "domain"
      keyVaultSecretVersion = "856559a3253341e69c23c1737987b959"
    }
  })
  schema_validation_enabled = false
}

// OperationId: SignalRCustomCertificates_List
// GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/customCertificates
data "azapi_resource_list" "listCustomCertificatesBySignalR" {
  type       = "Microsoft.SignalRService/signalR/customCertificates@2024-08-01-preview"
  parent_id  = azapi_resource.signalR.id
  depends_on = [azapi_resource.customCertificate]
}

# Maunal Step: point custom domain to signalr

// OperationId: SignalRCustomDomains_CreateOrUpdate, SignalRCustomDomains_Get, SignalRCustomDomains_Delete
// PUT GET DELETE /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/customDomains/{name}
resource "azapi_resource" "customDomain" {
  type      = "Microsoft.SignalRService/signalR/customDomains@2024-08-01-preview"
  parent_id = azapi_resource.signalR.id
  name      = var.resource_name
  body = jsonencode({
    properties = {
      customCertificate = {
        id = azapi_resource.customCertificate.id
      }
      domainName = "apitest.e2e-prod.signalr-test.azure.com"
    }
  })
  schema_validation_enabled = false
}

// OperationId: SignalRCustomDomains_List
// GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/customDomains
data "azapi_resource_list" "listCustomDomainsBySignalR" {
  type       = "Microsoft.SignalRService/signalR/customDomains@2024-08-01-preview"
  parent_id  = azapi_resource.signalR.id
  depends_on = [azapi_resource.customDomain]
}

