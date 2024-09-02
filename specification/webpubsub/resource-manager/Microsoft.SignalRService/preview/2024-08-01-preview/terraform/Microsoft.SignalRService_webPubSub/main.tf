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
  default = "acctest47452"
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

// OperationId: WebPubSub_CreateOrUpdate, WebPubSub_Get, WebPubSub_Delete
// PUT GET DELETE /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}
resource "azapi_resource" "webPubSub" {
  type      = "Microsoft.SignalRService/webPubSub@2024-08-01-preview"
  parent_id = azapi_resource.resourceGroup.id
  name      = var.resource_name
  location  = var.location
  body = {
    identity = {
      type = "SystemAssigned"
    }
    kind = "WebPubSub"
    properties = {
      disableAadAuth   = false
      disableLocalAuth = false
      liveTraceConfiguration = {
        categories = [
          {
            enabled = "true"
            name    = "ConnectivityLogs"
          },
        ]
        enabled = "false"
      }
      networkACLs = {
        defaultAction = "Deny"
      privateEndpoints = [
          // Need to create a private endpoint first
          # {
          #   allow = [
          #     "ServerConnection",
          #   ]
          #   name = "mywebpubsubservice.1fa229cd-bf3f-47f0-8c49-afb36723997e"
          # },
        ]
        publicNetwork = {
          allow = [
            "ClientConnection",
          ]
        }
      }
      publicNetworkAccess = "Enabled"
      tls = {
        clientCertEnabled = false
      }
    }
    sku = {
      capacity = 1
      name     = "Premium_P1"
      tier     = "Premium"
    }
    tags = {
      key1 = "value1"
    }
  }
  schema_validation_enabled = false
}

// OperationId: WebPubSub_Update
// PATCH /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}
resource "azapi_resource_action" "patch_webPubSub" {
  type        = "Microsoft.SignalRService/webPubSub@2024-08-01-preview"
  resource_id = azapi_resource.webPubSub.id
  action      = ""
  method      = "PATCH"
  body = {
    identity = {
      type = "SystemAssigned"
    }
    kind = "WebPubSub"
    properties = {
      disableAadAuth   = false
      disableLocalAuth = false
      liveTraceConfiguration = {
        categories = [
          {
            enabled = "true"
            name    = "ConnectivityLogs"
          },
        ]
        enabled = "false"
      }
      networkACLs = {
        defaultAction = "Deny"
        privateEndpoints = [
          {
            allow = [
              "ServerConnection",
            ]
            name = "mywebpubsubservice.1fa229cd-bf3f-47f0-8c49-afb36723997e"
          },
        ]
        publicNetwork = {
          allow = [
            "ClientConnection",
          ]
        }
      }
      publicNetworkAccess = "Enabled"
      socketIO = {
        serviceMode = "Serverless"
      }
      tls = {
        clientCertEnabled = false
      }
    }
    sku = {
      capacity = 1
      name     = "Premium_P1"
      tier     = "Premium"
    }
    tags = {
      key1 = "value1"
    }
  }
}

// OperationId: WebPubSub_ListKeys
// POST /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/listKeys
resource "azapi_resource_action" "listKeys" {
  type        = "Microsoft.SignalRService/webPubSub@2024-08-01-preview"
  resource_id = azapi_resource.webPubSub.id
  action      = "listKeys"
  method      = "POST"
}

// OperationId: WebPubSubPrivateLinkResources_List
// GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/privateLinkResources
data "azapi_resource_action" "privateLinkResources" {
  type        = "Microsoft.SignalRService/webPubSub@2024-08-01-preview"
  resource_id = azapi_resource.webPubSub.id
  action      = "privateLinkResources"
  method      = "GET"
  depends_on = [ azapi_resource_action.patch_webPubSub ]
}

// OperationId: WebPubSub_RegenerateKey
// POST /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/regenerateKey
resource "azapi_resource_action" "regenerateKey" {
  type        = "Microsoft.SignalRService/webPubSub@2024-08-01-preview"
  resource_id = azapi_resource.webPubSub.id
  action      = "regenerateKey"
  method      = "POST"
  body = {
    keyType = "Primary"
  }
}

// OperationId: WebPubSub_Restart
// POST /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/restart
resource "azapi_resource_action" "restart" {
  type        = "Microsoft.SignalRService/webPubSub@2024-08-01-preview"
  resource_id = azapi_resource.webPubSub.id
  action      = "restart"
  method      = "POST"
  depends_on = [ azapi_resource_action.regenerateKey ]
}

// OperationId: WebPubSub_ListSkus
// GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/skus
data "azapi_resource_action" "skus" {
  type        = "Microsoft.SignalRService/webPubSub@2024-08-01-preview"
  resource_id = azapi_resource.webPubSub.id
  action      = "skus"
  method      = "GET"
}

data "azapi_resource" "subscription" {
  type                   = "Microsoft.Resources/subscriptions@2020-06-01"
  response_export_values = ["*"]
}

// OperationId: WebPubSub_ListBySubscription
// GET /subscriptions/{subscriptionId}/providers/Microsoft.SignalRService/webPubSub
data "azapi_resource_list" "listWebPubSubBySubscription" {
  type       = "Microsoft.SignalRService/webPubSub@2024-08-01-preview"
  parent_id  = data.azapi_resource.subscription.id
  depends_on = [azapi_resource.webPubSub]
}

// OperationId: WebPubSub_ListByResourceGroup
// GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub
data "azapi_resource_list" "listWebPubSubByResourceGroup" {
  type       = "Microsoft.SignalRService/webPubSub@2024-08-01-preview"
  parent_id  = azapi_resource.resourceGroup.id
  depends_on = [azapi_resource.webPubSub]
}

