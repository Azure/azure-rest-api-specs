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
  default = "acctest7766"
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

resource "azapi_resource" "virtualNetwork" {
  type      = "Microsoft.Network/virtualNetworks@2023-05-01"
  parent_id = azapi_resource.resourceGroup.id
  name      = var.resource_name
  location  = var.location
  body = jsonencode({
    properties = {
      addressSpace = {
        addressPrefixes = [
          "10.5.0.0/16",
        ]
      }
    }
  })
  schema_validation_enabled = false
  response_export_values    = ["*"]
}

resource "azapi_resource" "subnet" {
  type      = "Microsoft.Network/virtualNetworks/subnets@2023-05-01"
  parent_id = azapi_resource.virtualNetwork.id
  name      = var.resource_name
  body = jsonencode({
    properties = {
      addressPrefix                  = "10.5.2.0/24"
      privateEndpointNetworkPolicies = "Enabled"
    }
  })
  schema_validation_enabled = false
  response_export_values    = ["*"]
}

resource "azapi_resource" "private_endpoint" {
  type      = "Microsoft.Network/privateEndpoints@2022-09-01"
  name      = var.resource_name
  location  = var.location
  parent_id = azapi_resource.resourceGroup.id

  body = jsonencode({
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
  })
}

// OperationId: WebPubSubPrivateEndpointConnections_Update, WebPubSubPrivateEndpointConnections_Get, WebPubSubPrivateEndpointConnections_Delete
// PUT GET DELETE /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/privateEndpointConnections/{privateEndpointConnectionName}
resource "azapi_update_resource" "privateEndpointConnection" {
  type      = "Microsoft.SignalRService/webPubSub/privateEndpointConnections@2024-08-01-preview"
  parent_id = azapi_resource.webPubSub.id
  name      = local.privateEndpointConnectionName
  body = {
    properties = {
      privateEndpoint = {
      }
      privateLinkServiceConnectionState = {
        actionsRequired = "None"
        status          = "Approved"
      }
    }
  }
}

# resource "azapi_resource_action" "delete_privateEndpointConnection" {
#   type      = "Microsoft.SignalRService/webPubSub/privateEndpointConnections@2024-08-01-preview"
#   resource_id = azapi_update_resource.privateEndpointConnection.id
#   method = "DELETE"
# }


// OperationId: WebPubSubPrivateEndpointConnections_List
// GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/privateEndpointConnections
data "azapi_resource_list" "listPrivateEndpointConnectionsByWebPubSub" {
  type       = "Microsoft.SignalRService/webPubSub/privateEndpointConnections@2024-08-01-preview"
  parent_id  = azapi_resource.webPubSub.id
  response_export_values = ["*"]
  depends_on = [azapi_resource.private_endpoint]
}


locals {
  privateEndpointConnectionName = one([for r in jsondecode(data.azapi_resource_list.listPrivateEndpointConnectionsByWebPubSub.output).value : r.name
  if r.properties.privateEndpoint.id == azapi_resource.private_endpoint.id])
}
