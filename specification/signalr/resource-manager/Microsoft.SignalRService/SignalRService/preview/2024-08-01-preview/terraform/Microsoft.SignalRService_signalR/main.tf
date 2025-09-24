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
  default = "acctest33253"
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

// OperationId: SignalR_CreateOrUpdate, SignalR_Get, SignalR_Delete
// PUT GET DELETE /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}
resource "azapi_resource" "signalR" {
  type      = "Microsoft.SignalRService/signalR@2024-08-01-preview"
  parent_id = azapi_resource.resourceGroup.id
  name      = var.resource_name
  location  = var.location
  body = {
    identity = {
      type = "SystemAssigned"
    }
    kind = "SignalR"
    properties = {
      cors = {
        allowedOrigins = [
          "https://foo.com",
          "https://bar.com",
        ]
      }
      resourceStopped       = "false"
      regionEndpointEnabled = "Enabled"
      disableAadAuth        = false
      disableLocalAuth      = false
      features = [
        {
          flag = "ServiceMode"
          properties = {
          }
          value = "Serverless"
        },
        {
          flag = "EnableConnectivityLogs"
          properties = {
          }
          value = "True"
        },
        {
          flag = "EnableMessagingLogs"
          properties = {
          }
          value = "False"
        },
        {
          flag = "EnableLiveTrace"
          properties = {
          }
          value = "False"
        },
      ]
      applicationFirewall = {
        clientConnectionCountRules = [
          {
            type     = "ThrottleByJwtSignatureRule",
            maxCount = 13
          },
          {
            type     = "ThrottleByUserIdRule",
            maxCount = 20
          },
          {
            type      = "ThrottleByJwtCustomClaimRule",
            claimName = "claimName",
            maxCount  = 20
          }
        ]
      },
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
        ipRules = [
          {
            action = "Allow"
            value  = "0.0.0.0/0"
        }, ]
        defaultAction = "Deny"
        privateEndpoints = [
          // Need to create a private endpoint first
          # {
          #   allow = [
          #     "ServerConnection",
          #   ]
          #   name = "mysignalrservice.1fa229cd-bf3f-47f0-8c49-afb36723997e"
          # },
        ]
        publicNetwork = {
          allow = [
            "ClientConnection",
          ]
          deny = []
        }
      }
      publicNetworkAccess = "Enabled"
      serverless = {
        connectionTimeoutInSeconds = 5
      }
      tls = {
        clientCertEnabled = false
      }
      upstream = {
        templates = [
          {
            auth = {
              managedIdentity = {
                resource = "api://example"
              }
              type = "ManagedIdentity"
            }
            categoryPattern = "*"
            eventPattern    = "connect,disconnect"
            hubPattern      = "*"
            urlTemplate     = "https://example.com/chat/api/connect"
          },
        ]
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

// OperationId: SignalR_Update
// PATCH /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}
resource "azapi_resource_action" "patch_signalR" {
  type        = "Microsoft.SignalRService/signalR@2024-08-01-preview"
  resource_id = azapi_resource.signalR.id
  action      = ""
  method      = "PATCH"
  body = {
    location = var.location
    identity = {
      type = "SystemAssigned"
    }
    kind = "SignalR"
    properties = {
      resourceStopped       = "false"
      regionEndpointEnabled = "Enabled"
      cors = {
        allowedOrigins = [
          "https://foo.com",
          "https://bar.com",
        ]
      }
      disableAadAuth   = false
      disableLocalAuth = false
      features = [
        {
          flag = "ServiceMode"
          properties = {
          }
          value = "Serverless"
        },
        {
          flag = "EnableConnectivityLogs"
          properties = {
          }
          value = "True"
        },
        {
          flag = "EnableMessagingLogs"
          properties = {
          }
          value = "False"
        },
        {
          flag = "EnableLiveTrace"
          properties = {
          }
          value = "False"
        },
      ]
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
          #   name = "mysignalrservice.1fa229cd-bf3f-47f0-8c49-afb36723997e"
          # },
        ]
        ipRules = [
          {
            action = "Allow"
            value  = "0.0.0.0/0"
        }, ]
        publicNetwork = {
          allow = [
            "ClientConnection",
          ]
          deny = []
        }
      }
      publicNetworkAccess = "Enabled"
      serverless = {
        connectionTimeoutInSeconds = 5
      }
      tls = {
        clientCertEnabled = false
      }
      applicationFirewall = {
        clientConnectionCountRules = [
          {
            type     = "ThrottleByJwtSignatureRule",
            maxCount = 13
          },
          {
            type     = "ThrottleByUserIdRule",
            maxCount = 20
          },
          {
            type      = "ThrottleByJwtCustomClaimRule",
            claimName = "claimName",
            maxCount  = 20
          }
        ]
      },
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
      upstream = {
        templates = [
          {
            auth = {
              managedIdentity = {
                resource = "api://example"
              }
              type = "ManagedIdentity"
            }
            categoryPattern = "*"
            eventPattern    = "connect,disconnect"
            hubPattern      = "*"
            urlTemplate     = "https://example.com/chat/api/connect"
          },
        ]
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
  depends_on = [azapi_resource.signalR]
}

// OperationId: SignalR_ListKeys
// POST /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/listKeys
resource "azapi_resource_action" "listKeys" {
  type        = "Microsoft.SignalRService/signalR@2024-08-01-preview"
  resource_id = azapi_resource.signalR.id
  action      = "listKeys"
  method      = "POST"
}

// OperationId: SignalRPrivateLinkResources_List
// GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/privateLinkResources
data "azapi_resource_action" "privateLinkResources" {
  type        = "Microsoft.SignalRService/signalR@2024-08-01-preview"
  resource_id = azapi_resource.signalR.id
  action      = "privateLinkResources"
  method      = "GET"
}

// OperationId: SignalR_RegenerateKey
// POST /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/regenerateKey
resource "azapi_resource_action" "regenerateKey" {
  type        = "Microsoft.SignalRService/signalR@2024-08-01-preview"
  resource_id = azapi_resource.signalR.id
  action      = "regenerateKey"
  method      = "POST"
  body = {
    keyType = "Primary"
  }
  depends_on = [azapi_resource_action.patch_signalR]
}

// OperationId: SignalR_Restart
// POST /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/restart
resource "azapi_resource_action" "restart" {
  type        = "Microsoft.SignalRService/signalR@2024-08-01-preview"
  resource_id = azapi_resource.signalR.id
  action      = "restart"
  method      = "POST"
  depends_on  = [azapi_resource_action.regenerateKey]
}

// OperationId: SignalR_ListSkus
// GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/skus
data "azapi_resource_action" "skus" {
  type        = "Microsoft.SignalRService/signalR@2024-08-01-preview"
  resource_id = azapi_resource.signalR.id
  action      = "skus"
  method      = "GET"
}

data "azapi_resource" "subscription" {
  type                   = "Microsoft.Resources/subscriptions@2020-06-01"
  response_export_values = ["*"]
}

// OperationId: SignalR_ListBySubscription
// GET /subscriptions/{subscriptionId}/providers/Microsoft.SignalRService/signalR
data "azapi_resource_list" "listSignalRBySubscription" {
  type       = "Microsoft.SignalRService/signalR@2024-08-01-preview"
  parent_id  = data.azapi_resource.subscription.id
  depends_on = [azapi_resource.signalR]
}

// OperationId: SignalR_ListByResourceGroup
// GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR
data "azapi_resource_list" "listSignalRByResourceGroup" {
  type       = "Microsoft.SignalRService/signalR@2024-08-01-preview"
  parent_id  = azapi_resource.resourceGroup.id
  depends_on = [azapi_resource.signalR]
}

# // OperationId: SignalRReplicas_List
# // GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/replicas
data "azapi_resource_list" "listReplicasBySignalR" {
  type      = "Microsoft.SignalRService/signalR/replicas@2024-08-01-preview"
  parent_id = azapi_resource.signalR.id
}

resource "azapi_resource" "user_assigned_identity" {
  type      = "Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30"
  name      = var.resource_name
  location  = var.location
  parent_id = azapi_resource.resourceGroup.id
}

# validate properties that can't exist together
// OperationId: SignalR_CreateOrUpdate, SignalR_Get, SignalR_Delete
// PUT GET DELETE /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}
resource "azapi_resource" "signalR2" {
  type      = "Microsoft.SignalRService/signalR@2024-08-01-preview"
  parent_id = azapi_resource.resourceGroup.id
  name      = format("%s2", var.resource_name)
  location  = var.location
  body = {
    identity = {
      type = "UserAssigned",
      userAssignedIdentities = {
        "${azapi_resource.user_assigned_identity.id}" = {}
      }
    },
    kind = "SignalR"
    sku = {
      capacity = 1
      name     = "Premium_P1"
      tier     = "Premium"
    }
  }
  schema_validation_enabled = false
}


// OperationId: SignalR_Update
// PATCH /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}
resource "azapi_resource_action" "patch_signalR2" {
  type        = "Microsoft.SignalRService/signalR@2024-08-01-preview"
  resource_id = azapi_resource.signalR2.id
  action      = ""
  method      = "PATCH"
  body = {
    location = var.location
    identity = {
      type = "UserAssigned",
      userAssignedIdentities = {
        "${azapi_resource.user_assigned_identity.id}" = {}
      }
    },
  }
}

