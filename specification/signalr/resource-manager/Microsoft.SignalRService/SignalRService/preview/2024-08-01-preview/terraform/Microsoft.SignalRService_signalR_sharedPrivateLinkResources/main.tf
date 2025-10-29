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
  default = "acctest59673"
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
      name     = "Standard_S1"
    }
  }
  schema_validation_enabled = false
  response_export_values    = ["*"]
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
      fqdns                 = []
    }
  }
  schema_validation_enabled = false
}

// OperationId: SignalRSharedPrivateLinkResources_List
// GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/sharedPrivateLinkResources
data "azapi_resource_list" "listSharedPrivateLinkResourcesBySignalR" {
  type       = "Microsoft.SignalRService/signalR/sharedPrivateLinkResources@2024-08-01-preview"
  parent_id  = azapi_resource.signalR.id
  depends_on = [azapi_resource.sharedPrivateLinkResource]
}

