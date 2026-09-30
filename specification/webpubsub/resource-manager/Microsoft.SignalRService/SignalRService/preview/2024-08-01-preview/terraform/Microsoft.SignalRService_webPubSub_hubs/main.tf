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
  default = "acctest3241"
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
      name     = "Standard_S1"
    }
  }
  schema_validation_enabled = false
  response_export_values    = ["*"]
}

// OperationId: WebPubSubHubs_CreateOrUpdate, WebPubSubHubs_Get, WebPubSubHubs_Delete
// PUT GET DELETE /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/hubs/{hubName}
resource "azapi_resource" "hub" {
  type      = "Microsoft.SignalRService/webPubSub/hubs@2024-08-01-preview"
  parent_id = azapi_resource.webPubSub.id
  name      = var.resource_name
  body = {
    properties = {
      anonymousConnectPolicy = "allow"
      eventHandlers = [
        {
          auth = {
            managedIdentity = {
              resource = "abc"
            }
            type = "ManagedIdentity"
          }
          systemEvents = [
            "connect",
            "connected",
          ]
          urlTemplate      = "http://host.com"
          userEventPattern = "*"
        },
      ]
      eventListeners = [
        {
          endpoint = {
            eventHubName            = "eventHubName1"
            fullyQualifiedNamespace = "example.servicebus.windows.net"
            type                    = "EventHub"
          }
          filter = {
            systemEvents = [
              "connected",
              "disconnected",
            ]
            type             = "EventName"
            userEventPattern = "*"
          }
        },
      ]
      webSocketKeepAliveIntervalInSeconds = 50
    }
  }
  schema_validation_enabled = false
}

// OperationId: WebPubSubHubs_List
// GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/hubs
data "azapi_resource_list" "listHubsByWebPubSub" {
  type       = "Microsoft.SignalRService/webPubSub/hubs@2024-08-01-preview"
  parent_id  = azapi_resource.webPubSub.id
  depends_on = [azapi_resource.hub]
}

