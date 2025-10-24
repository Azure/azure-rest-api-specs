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
  default = "acctest90892"
}

variable "primary_location" {
  type    = string
  default = "eastus2euap"
}

variable "replica_location" {
  type    = string
  default = "centraluseuap"
}

resource "azapi_resource" "resourceGroup" {
  type     = "Microsoft.Resources/resourceGroups@2020-06-01"
  name     = var.resource_name
  location = var.primary_location
}

resource "azapi_resource" "signalR" {
  type      = "Microsoft.SignalRService/signalR@2023-02-01"
  parent_id = azapi_resource.resourceGroup.id
  name      = var.resource_name
  location  = var.primary_location
  body = {
    identity = {
      type                   = "None"
      userAssignedIdentities = null
    }
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

// OperationId: SignalRReplicas_CreateOrUpdate, SignalRReplicas_Get, SignalRReplicas_Delete
// PUT GET DELETE /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/replicas/{replicaName}
resource "azapi_resource" "replica" {
  type      = "Microsoft.SignalRService/signalR/replicas@2024-08-01-preview"
  parent_id = azapi_resource.signalR.id
  name      = var.resource_name
  location  = var.replica_location
  body = {
    properties = {
      resourceStopped       = "false"
      regionEndpointEnabled = "Enabled"
    }
    sku = {
      capacity = 1
      name     = "Premium_P1"
      tier     = "Premium"
    }
    tags = {
      key1 = "value2"
    }
  }
  schema_validation_enabled = false
}

// OperationId: SignalRReplicas_Update
// PATCH /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/replicas/{replicaName}
resource "azapi_resource_action" "patch_replica" {
  type        = "Microsoft.SignalRService/signalR/replicas@2024-08-01-preview"
  resource_id = azapi_resource.replica.id
  action      = ""
  method      = "PATCH"
  body = {
    location = var.replica_location
    properties = {
      resourceStopped       = "false"
      regionEndpointEnabled = "Enabled"
    }
    sku = {
      capacity = 1
      name     = "Premium_P1"
      tier     = "Premium"
    }
    tags = {
      key1 = "value2"
    }
  }
  depends_on = [azapi_resource.replica]
}

// OperationId: SignalRReplicas_Restart
// POST /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/replicas/{replicaName}/restart
resource "azapi_resource_action" "restart" {
  type        = "Microsoft.SignalRService/signalR/replicas@2024-08-01-preview"
  resource_id = azapi_resource.replica.id
  action      = "restart"
  method      = "POST"
  depends_on  = [azapi_resource_action.patch_replica]
}

// OperationId: SignalR_ListReplicaSkus
// GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/replicas/{replicaName}/skus
data "azapi_resource_action" "skus" {
  type        = "Microsoft.SignalRService/signalR/replicas@2024-08-01-preview"
  resource_id = azapi_resource.replica.id
  action      = "skus"
  method      = "GET"
}
