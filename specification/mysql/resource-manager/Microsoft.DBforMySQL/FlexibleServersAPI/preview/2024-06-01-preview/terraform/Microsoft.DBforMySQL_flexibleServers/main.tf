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
    resource_manager_endpoint       = "https://centraluseuap.management.azure.com/"
    resource_manager_audience       = "https://management.core.windows.net/"
    active_directory_authority_host = "https://login.microsoftonline.com"
  }]
}

variable "resource_name" {
  type    = string
  default = "acctest6578"
}

variable "resource_name_2" {
  type    = string
  default = "acctest6578-2"
}

variable "location" {
  type    = string
  default = "eastus2euap"
}

variable "flexible_server_password" {
  type = string
}

resource "azapi_resource" "resourceGroup" {
  type     = "Microsoft.Resources/resourceGroups@2024-03-01"
  name     = var.resource_name
  location = var.location
  body     = {}
}

// OperationId: Servers_Create, Servers_Get, Servers_Delete
// PUT GET DELETE /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DBforMySQL/flexibleServers/{serverName}
resource "azapi_resource" "flexibleServer" {
  type      = "Microsoft.DBforMySQL/flexibleServers@2024-06-01-preview"
  parent_id = azapi_resource.resourceGroup.id
  name      = var.resource_name
  location  = var.location
  body = {
    properties = {
      administratorLogin         = "cloudsa"
      administratorLoginPassword = var.flexible_server_password
      availabilityZone           = "1"
      backup = {
        backupIntervalHours = 24
        backupRetentionDays = 7
        geoRedundantBackup  = "Disabled"
      }
      highAvailability = {
        mode                    = "ZoneRedundant"
        standbyAvailabilityZone = "3"
      }
      network = {
        publicNetworkAccess = "Enabled"
      }
      replicationRole = "None"
      storage = {
        autoGrow          = "Enabled"
        autoIoScaling     = "Enabled"
        iops              = 390
        logOnDisk         = "Disabled"
        storageSizeGB     = 30
        storageRedundancy = "ZoneRedundancy"
      }
      version = "8.0.21"
    }
    sku = {
      name = "Standard_D2s_v3"
      tier = "GeneralPurpose"
    }
  }

  schema_validation_enabled = false
  ignore_missing_property   = true
}

// OperationId: Servers_Create, Servers_Get, Servers_Delete
// PUT GET DELETE /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DBforMySQL/flexibleServers/{serverName}
resource "azapi_resource" "flexibleServer2" {
  type      = "Microsoft.DBforMySQL/flexibleServers@2024-06-01-preview"
  parent_id = azapi_resource.resourceGroup.id
  name      = var.resource_name_2
  location  = var.location
  body = {
    properties = {
      administratorLogin         = "cloudsa"
      administratorLoginPassword = var.flexible_server_password
      availabilityZone           = "1"
      backup = {
        backupIntervalHours = 24
        backupRetentionDays = 7
        geoRedundantBackup  = "Disabled"
      }
      highAvailability = {
        mode                    = "Disabled"
        standbyAvailabilityZone = ""
      }
      network = {
        publicNetworkAccess = "Enabled"
      }
      replicationRole = "None"
      storage = {
        autoGrow      = "Enabled"
        autoIoScaling = "Enabled"
        iops          = 390
        logOnDisk     = "Disabled"
        storageSizeGB = 30
      }
      version = "8.0.21"
    }
    sku = {
      name = "Standard_D2s_v3"
      tier = "GeneralPurpose"
    }
  }

  schema_validation_enabled = false
  ignore_missing_property   = true
}

// OperationId: Servers_ValidateEstimateHighAvailability
// POST /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DBforMySQL/flexibleServers/{serverName}/validateEstimateHighAvailability
resource "azapi_resource_action" "validateEstimateHighAvailability" {
  type        = "Microsoft.DBforMySQL/flexibleServers@2024-06-01-preview"
  resource_id = azapi_resource.flexibleServer2.id
  action      = "validateEstimateHighAvailability"
  method      = "POST"
  body = {
    expectedStandbyAvailabilityZone = "1"
  }
}

// OperationId: Replicas_ListByServer
// GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DBforMySQL/flexibleServers/{serverName}/replicas
data "azapi_resource_action" "replicas" {
  type        = "Microsoft.DBforMySQL/flexibleServers@2024-06-01-preview"
  resource_id = azapi_resource.flexibleServer.id
  action      = "replicas"
  method      = "GET"
}

// OperationId: Servers_ListByResourceGroup
// GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DBforMySQL/flexibleServers
data "azapi_resource_list" "listFlexibleServersByResourceGroup" {
  type       = "Microsoft.DBforMySQL/flexibleServers@2024-06-01-preview"
  parent_id  = azapi_resource.resourceGroup.id
  depends_on = [azapi_resource.flexibleServer]
}

data "azapi_resource" "subscription" {
  type                   = "Microsoft.Resources/subscriptions@2020-06-01"
  response_export_values = ["*"]
}

// OperationId: Servers_List
// GET /subscriptions/{subscriptionId}/providers/Microsoft.DBforMySQL/flexibleServers
data "azapi_resource_list" "listFlexibleServersBySubscription" {
  type       = "Microsoft.DBforMySQL/flexibleServers@2024-06-01-preview"
  parent_id  = data.azapi_resource.subscription.id
  depends_on = [azapi_resource.flexibleServer]
}


// OperationId: Servers_Update
// PATCH /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DBforMySQL/flexibleServers/{serverName}
resource "azapi_resource_action" "patch_flexibleServer" {
  type        = "Microsoft.DBforMySQL/flexibleServers@2024-06-01-preview"
  resource_id = azapi_resource.flexibleServer.id
  action      = ""
  method      = "PATCH"
  body = {
    properties = {
      network = {
        publicNetworkAccess = "Disabled"
      }
      storage = {
        iops = 200
      }
    }
  }
}

// OperationId: Servers_Update
// PATCH /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DBforMySQL/flexibleServers/{serverName}
resource "azapi_resource_action" "patch_flexibleServer_rollback" {
  type        = "Microsoft.DBforMySQL/flexibleServers@2024-06-01-preview"
  resource_id = azapi_resource_action.patch_flexibleServer.resource_id
  action      = ""
  method      = "PATCH"
  body = {
    properties = {
      network = {
        publicNetworkAccess = "Enabled"
      }
      storage = {
        iops = 390
      }
    }
  }
}

// OperationId: Servers_ResetGtid
// POST /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DBforMySQL/flexibleServers/{serverName}/resetGtid
resource "azapi_resource_action" "resetGtid" {
  type        = "Microsoft.DBforMySQL/flexibleServers@2024-06-01-preview"
  resource_id = azapi_resource_action.patch_flexibleServer_rollback.resource_id
  action      = "resetGtid"
  method      = "POST"
  body = {
    gtidSet = "4aff5b51-97ba-11ed-a955-002248036acc:1-16"
  }
}

// OperationId: Servers_Failover
// POST /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DBforMySQL/flexibleServers/{serverName}/failover
resource "azapi_resource_action" "failover" {
  type        = "Microsoft.DBforMySQL/flexibleServers@2024-06-01-preview"
  resource_id = azapi_resource_action.resetGtid.resource_id
  action      = "failover"
  method      = "POST"
}

// OperationId: Servers_Restart
// POST /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DBforMySQL/flexibleServers/{serverName}/restart
resource "azapi_resource_action" "restart" {
  type        = "Microsoft.DBforMySQL/flexibleServers@2024-06-01-preview"
  resource_id = azapi_resource_action.failover.resource_id
  action      = "restart"
  method      = "POST"
  body = {
    maxFailoverSeconds  = 60
    restartWithFailover = "Disabled"
  }
}

// OperationId: Servers_Stop
// POST /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DBforMySQL/flexibleServers/{serverName}/stop
resource "azapi_resource_action" "stop" {
  type        = "Microsoft.DBforMySQL/flexibleServers@2024-06-01-preview"
  resource_id = azapi_resource_action.restart.resource_id
  action      = "stop"
  method      = "POST"
}

// OperationId: Servers_Start
// POST /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DBforMySQL/flexibleServers/{serverName}/start
resource "azapi_resource_action" "start" {
  type        = "Microsoft.DBforMySQL/flexibleServers@2024-06-01-preview"
  resource_id = azapi_resource_action.stop.resource_id
  action      = "start"
  method      = "POST"
}

// OperationId: ServersMigration_CutoverMigration
// POST /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DBforMySQL/flexibleServers/{serverName}/cutoverMigration
//resource "azapi_resource_action" "cutoverMigration" {
//  type        = "Microsoft.DBforMySQL/flexibleServers@2024-06-01-preview"
//  resource_id = azapi_resource.flexibleServer.id
//  action      = "cutoverMigration"
//  method      = "POST"
//}

// OperationId: Servers_DetachVNet
// POST /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DBforMySQL/flexibleServers/{serverName}/detachVNet
//resource "azapi_resource_action" "detachVNet" {
//  type        = "Microsoft.DBforMySQL/flexibleServers@2024-06-01-preview"
//  resource_id = azapi_resource.flexibleServer.id
//  action      = "DetachVNet"
//  method      = "POST"
//  body = {
//    publicNetworkAccess = "Enabled"
//  }
//}

