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
  default = "acctest5509"
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
    identity = {
      type                   = "None"
      userAssignedIdentities = null
    }
    sku = {
      capacity = 1
      name     = "Standard_S1"
    }
  }
  schema_validation_enabled = false
  response_export_values    = ["*"]
}

resource "azapi_resource" "virtualNetwork" {
  type      = "Microsoft.Network/virtualNetworks@2023-05-01"
  parent_id = azapi_resource.resourceGroup.id
  name      = var.resource_name
  location  = var.location
  body = {
    properties = {
      addressSpace = {
        addressPrefixes = [
          "10.5.0.0/16",
        ]
      }
    }
  }
  lifecycle {
    ignore_changes = [body.properties.subnets]
  }
  schema_validation_enabled = false
}

resource "azapi_resource" "subnet" {
  type      = "Microsoft.Network/virtualNetworks/subnets@2023-05-01"
  parent_id = azapi_resource.virtualNetwork.id
  name      = var.resource_name
  body = {
    properties = {
      addressPrefix                  = "10.5.2.0/24"
      privateEndpointNetworkPolicies = "Enabled"
    }
  }
  schema_validation_enabled = false
  response_export_values    = ["*"]
}

resource "azapi_resource" "private_endpoint" {
  type      = "Microsoft.Network/privateEndpoints@2022-09-01"
  name      = var.resource_name
  location  = var.location
  parent_id = azapi_resource.resourceGroup.id

  body = {
    properties = {
      subnet = {
        id = azapi_resource.subnet.id
      }
      privateLinkServiceConnections = [{
        name = var.resource_name
        properties = {
          privateLinkServiceId = azapi_resource.webPubSub.id
          groupIds             = ["webpubsub"]
        }
      }]
    }
  }
}

// OperationId: WebPubSubPrivateEndpointConnections_List
// GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/privateEndpointConnections
data "azapi_resource_list" "listPrivateEndpointConnectionsByWebPubSub" {
  type                   = "Microsoft.SignalRService/webPubSub/privateEndpointConnections@2024-08-01-preview"
  parent_id              = azapi_resource.webPubSub.id
  response_export_values = ["*"]
  depends_on             = [azapi_resource.private_endpoint]
}


data "azapi_resource_id" "privateEndpointConnection" {
  type      = "Microsoft.SignalRService/webPubSub/privateEndpointConnections@2024-08-01-preview"
  parent_id = azapi_resource.webPubSub.id
  name      = coalesce(local.privateEndpointConnectionName, "dummy")
}

// OperationId: WebPubSubPrivateEndpointConnections_Update
// PUT /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/privateEndpointConnections/{privateEndpointConnectionName}
resource "azapi_resource_action" "put_privateEndpointConnection" {
  type        = "Microsoft.SignalRService/webPubSub/privateEndpointConnections@2024-08-01-preview"
  resource_id = data.azapi_resource_id.privateEndpointConnection.id
  method      = "PUT"
  body = {
    properties = {
      privateEndpoint = {
      }
      privateLinkServiceConnectionState = {
        actionsRequired = "None"
        status          = "Approved"
        description     = "Please approve"
      }
    }
  }
}

// OperationId: WebPubSubPrivateEndpointConnections_Get
// GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/privateEndpointConnections/{privateEndpointConnectionName}
resource "azapi_resource_action" "get_privateEndpointConnection" {
  type        = "Microsoft.SignalRService/webPubSub/privateEndpointConnections@2024-08-01-preview"
  resource_id = data.azapi_resource_id.privateEndpointConnection.id
  method      = "GET"
  depends_on  = [azapi_resource_action.put_privateEndpointConnection]
}

// OperationId:WebPubSubPrivateEndpointConnections_Delete
// DELETE /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/privateEndpointConnections/{privateEndpointConnectionName}
resource "azapi_resource_action" "delete_privateEndpointConnection" {
  type        = "Microsoft.SignalRService/webPubSub/privateEndpointConnections@2024-08-01-preview"
  resource_id = data.azapi_resource_id.privateEndpointConnection.id
  method      = "DELETE"
  when        = "destroy"
  depends_on  = [azapi_resource_action.get_privateEndpointConnection]
}

locals {
  privateEndpointConnectionName = one([for r in jsondecode(data.azapi_resource_list.listPrivateEndpointConnectionsByWebPubSub.output).value : r.name
  if r.properties.privateEndpoint.id == azapi_resource.private_endpoint.id])
}

resource "azapi_resource_action" "put_webPubSub" {
  type        = "Microsoft.SignalRService/webPubSub@2024-08-01-preview"
  resource_id = azapi_resource.webPubSub.id
  action      = ""
  method      = "PUT"
  body = {
    location = var.location
    properties = {
      networkACLs = {
        privateEndpoints = [
          {
            name = local.privateEndpointConnectionName
            allow = [
              "ServerConnection",
              "ClientConnection",
              "RESTAPI",
              "Trace"
            ]
            deny = []
          }
        ],
      }
    }
    sku = {
      capacity = 1
      name     = "Standard_S1"
      tier     = "Standard"
    }
  }
  depends_on = [azapi_resource_action.put_privateEndpointConnection]
}

resource "azapi_resource_action" "patch_webPubSub" {
  type        = "Microsoft.SignalRService/webPubSub@2024-08-01-preview"
  resource_id = azapi_resource.webPubSub.id
  action      = ""
  method      = "PATCH"
  body = {
    location = var.location
    properties = {
      networkACLs = {
        privateEndpoints = [
          {
            name = local.privateEndpointConnectionName
            allow = [
              "ServerConnection",
              "ClientConnection",
              "RESTAPI",
              "Trace"
            ]
            deny = []
          }
        ],
      }
    }
    sku = {
      capacity = 1
      name     = "Standard_S1"
      tier     = "Standard"
    }
  }
  depends_on = [azapi_resource_action.put_webPubSub]
}