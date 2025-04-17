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
  default = "acctest99423"
}

variable "location" {
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
  location = var.location
}

resource "azapi_resource" "signalR" {
  type      = "Microsoft.SignalRService/signalR@2023-02-01"
  parent_id = azapi_resource.resourceGroup.id
  name      = var.resource_name
  location  = var.location
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
      resourceStopped = "false"
    }
    sku = {
      capacity = 2
      name     = "Premium_P1"
      tier     = "Premium"
    }
    tags = {
      key1 = "value1"
    }
  }
  schema_validation_enabled = false
}

resource "azapi_resource" "serverfarm" {
  type      = "Microsoft.Web/serverfarms@2022-09-01"
  parent_id = azapi_resource.resourceGroup.id
  name      = var.resource_name
  location  = "eastus"
  body = {
    properties = {
      hyperV         = false
      perSiteScaling = false
      reserved       = false
      zoneRedundant  = false
    }
    sku = {
      name = "S1"
    }
  }
  schema_validation_enabled = false
  response_export_values    = ["*"]
}

resource "azapi_resource" "site" {
  type      = "Microsoft.Web/sites@2022-09-01"
  parent_id = azapi_resource.resourceGroup.id
  name      = var.resource_name
  location  = "eastus"
  body = {
    identity = {
      type = "None"
    }
    properties = {
      clientAffinityEnabled = false
      clientCertEnabled     = false
      clientCertMode        = "Required"
      enabled               = true
      httpsOnly             = false
      publicNetworkAccess   = "Enabled"
      serverFarmId          = azapi_resource.serverfarm.id
      siteConfig = {
        acrUseManagedIdentityCreds       = false
        alwaysOn                         = true
        autoHealEnabled                  = false
        ftpsState                        = "Disabled"
        http20Enabled                    = false
        loadBalancing                    = "LeastRequests"
        localMySqlEnabled                = false
        managedPipelineMode              = "Integrated"
        minTlsVersion                    = "1.2"
        publicNetworkAccess              = "Enabled"
        remoteDebuggingEnabled           = false
        scmIpSecurityRestrictionsUseMain = false
        scmMinTlsVersion                 = "1.2"
        use32BitWorkerProcess            = true
        vnetRouteAllEnabled              = false
        webSocketsEnabled                = false
        windowsFxVersion                 = ""
      }
      vnetRouteAllEnabled = false
    }
  }
  schema_validation_enabled = false
  response_export_values    = ["*"]
}

// OperationId: SignalRSharedPrivateLinkResources_CreateOrUpdate, SignalRSharedPrivateLinkResources_Get, SignalRSharedPrivateLinkResources_Delete
// PUT GET DELETE /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}
resource "azapi_resource" "sharedPrivateLinkResource" {
  type      = "Microsoft.SignalRService/signalR/sharedPrivateLinkResources@2024-08-01-preview"
  parent_id = azapi_resource.signalR.id
  name      = var.resource_name
  body = {
    properties = {
      groupId               = "sites"
      privateLinkResourceId = azapi_resource.site.id
      requestMessage        = "Please approve"
    }
  }
  schema_validation_enabled = false
}

data "azapi_resource_list" "listPrivateEndpointConnectionsBySite" {
  type                   = "Microsoft.Web/sites/privateEndpointConnections@2023-12-01"
  parent_id              = azapi_resource.site.id
  response_export_values = ["*"]
  depends_on             = [azapi_resource.sharedPrivateLinkResource]
}

locals {
  privateEndpointConnectionNames = tolist(jsondecode(data.azapi_resource_list.listPrivateEndpointConnectionsBySite.output).value[*].name)
  privateEndpointConnectionName  = length(local.privateEndpointConnectionNames) > 0 ? local.privateEndpointConnectionNames[0] : null
}

resource "azapi_update_resource" "privateEndpointConnection" {
  type      = "Microsoft.Web/sites/privateEndpointConnections@2023-12-01"
  parent_id = azapi_resource.site.id
  name      = coalesce(local.privateEndpointConnectionName, "dummy")
  body = {
    properties = {
      privateLinkServiceConnectionState = {
        status = "Approved"
      }
    }
  }
}

resource "time_sleep" "wait" {
  depends_on      = [azapi_update_resource.privateEndpointConnection]
  create_duration = "600s"
}


data "azapi_resource_id" "sharedPrivateLinkResource" {
  type       = "Microsoft.SignalRService/signalR/replicas/sharedPrivateLinkResources@2023-12-12"
  parent_id  = azapi_resource.replica.id
  name       = var.resource_name
  depends_on = [azapi_resource.sharedPrivateLinkResource]
}

// OperationId: SignalRReplicaSharedPrivateLinkResources_CreateOrUpdate
// PUT /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}
resource "azapi_resource_action" "put_sharedPrivateLinkResource" {
  type        = "Microsoft.SignalRService/signalR/replicas/sharedPrivateLinkResources@2024-08-01-preview"
  resource_id = data.azapi_resource_id.sharedPrivateLinkResource.id
  method      = "PUT"
  body = {
    properties = {
      groupId               = "sites"
      privateLinkResourceId = azapi_resource.site.id
      requestMessage        = "Please approve"
      fqdns                 = []
    }
  }
  depends_on = [azapi_update_resource.privateEndpointConnection, time_sleep.wait]
}

// OperationId: SignalRReplicaSharedPrivateLinkResources_Get
// GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}
data "azapi_resource" "sharedPrivateLinkResource" {
  type        = "Microsoft.SignalRService/signalR/replicas/sharedPrivateLinkResources@2024-08-01-preview"
  resource_id = azapi_resource_action.put_sharedPrivateLinkResource.id
  depends_on  = [azapi_resource_action.put_sharedPrivateLinkResource]
}

// OperationId: SignalRReplicaSharedPrivateLinkResources_List
// GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources
data "azapi_resource_list" "listSharedPrivateLinkResourcesByReplica" {
  type       = "Microsoft.SignalRService/signalR/replicas/sharedPrivateLinkResources@2024-08-01-preview"
  parent_id  = azapi_resource.replica.id
  depends_on = [data.azapi_resource.sharedPrivateLinkResource]
}
