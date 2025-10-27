
resource "azapi_resource" "mongoCluster" {
  type      = "Microsoft.DocumentDB/mongoClusters@2025-09-01"
  parent_id = azapi_resource.resourceGroup.id
  name      = var.resource_name
  location  = var.location
  body = {
    identity = {
      type = "UserAssigned"
      userAssignedIdentities = {
        (azurerm_user_assigned_identity.userAssignedIdentity.id) = {
        }
      }
    }
    properties = {
      administrator = {
        password = var.admin_password
        userName = var.admin_username
      }
      authConfig = {
        allowedModes = ["MicrosoftEntraID", "NativeAuth"]
      }
      compute = {
        tier = "M30"
      }
      dataApi = {
        mode = "Disabled"
      }
      encryption = {
        customerManagedKeyEncryption = {
          keyEncryptionKeyIdentity = {
            identityType                   = "UserAssignedIdentity"
            userAssignedIdentityResourceId = azurerm_user_assigned_identity.userAssignedIdentity.id
          }
          keyEncryptionKeyUrl = "https://${azurerm_key_vault.cmk_vault.name}.vault.azure.net/keys/${azurerm_key_vault_key.encryptionKey.name}"
        }
      }
      highAvailability = {
        targetMode = "Disabled"
      }
      previewFeatures = [
        "ShardRebalancer"
      ]
      publicNetworkAccess = "Enabled"
      serverVersion       = "5.0"
      sharding = {
        shardCount = 1
      }
      storage = {
        sizeGb = 32
      }
    }
  }
  tags = {
    Environment = "Test"
    Purpose     = "Armstrong-CMK-Coverage"
    API         = "MongoDB-Cluster-2025-09-01"
  }
  schema_validation_enabled = false
  ignore_casing             = false
  ignore_missing_property   = false

  depends_on = [
    azurerm_key_vault_key.encryptionKey,
    time_sleep.wait_for_vault_policies
  ]
}

# Wait for the MongoDB cluster to have backup capability available
resource "time_sleep" "wait_for_backup_ready" {
  depends_on = [azapi_resource.mongoCluster]

  # Wait 5 minutes for backup to be available - MongoDB clusters typically need time to enable backup
  create_duration = "300s"
}

# Data source to get the updated cluster info with backup details
data "azapi_resource" "mongoCluster_backup_check" {
  type        = "Microsoft.DocumentDB/mongoClusters@2025-09-01"
  resource_id = azapi_resource.mongoCluster.id

  response_export_values = ["properties.backup.earliestRestoreTime"]
  depends_on             = [time_sleep.wait_for_backup_ready]
}


resource "azapi_resource" "mongoCluster_1" {
  type      = "Microsoft.DocumentDB/mongoClusters@2025-09-01"
  parent_id = azapi_resource.resourceGroup.id
  name      = "${var.resource_name}-restore"
  location  = var.location
  body = {
    identity = {
      type = "UserAssigned"
      userAssignedIdentities = {
        (azurerm_user_assigned_identity.userAssignedIdentity2.id) = {
        }
      }
    }
    properties = {
      createMode = "PointInTimeRestore"
      administrator = {
        password = var.restore_admin_password
        userName = var.admin_username
      }
      encryption = {
        customerManagedKeyEncryption = {
          keyEncryptionKeyIdentity = {
            identityType                   = "UserAssignedIdentity"
            userAssignedIdentityResourceId = azurerm_user_assigned_identity.userAssignedIdentity2.id
          }
          keyEncryptionKeyUrl = "https://${azurerm_key_vault.cmk_vault.name}.vault.azure.net/keys/${azurerm_key_vault_key.encryptionKey2.name}"
        }
      }
      restoreParameters = {
        pointInTimeUTC   = data.azapi_resource.mongoCluster_backup_check.output.properties.backup.earliestRestoreTime
        sourceResourceId = azapi_resource.mongoCluster.id
      }
    }
  }
  schema_validation_enabled = false
  ignore_casing             = false
  ignore_missing_property   = false

  depends_on = [
    azapi_resource.mongoCluster,
    azurerm_key_vault_key.encryptionKey2,
    time_sleep.wait_for_vault_policies,
    data.azapi_resource.mongoCluster_backup_check
  ]
}


resource "azapi_resource" "mongoCluster_2" {
  type      = "Microsoft.DocumentDB/mongoClusters@2025-09-01"
  parent_id = azapi_resource.resourceGroup.id
  name      = "${var.resource_name}-repl"
  location  = var.replica_location
  body = {
    identity = {
      type = "UserAssigned"
      userAssignedIdentities = {
        (azurerm_user_assigned_identity.userAssignedIdentity_replica.id) = {
        }
      }
    }
    properties = {
      createMode = "GeoReplica"
      encryption = {
        customerManagedKeyEncryption = {
          keyEncryptionKeyIdentity = {
            identityType                   = "UserAssignedIdentity"
            userAssignedIdentityResourceId = azurerm_user_assigned_identity.userAssignedIdentity_replica.id
          }
          keyEncryptionKeyUrl = "https://${azurerm_key_vault.cmk_vault_replica.name}.vault.azure.net/keys/${azurerm_key_vault_key.encryptionKey_replica.name}"
        }
      }
      replicaParameters = {
        sourceLocation   = var.location # Source location matches the primary cluster
        sourceResourceId = azapi_resource.mongoCluster.id
      }
    }
  }
  schema_validation_enabled = false
  ignore_casing             = false
  ignore_missing_property   = false

  depends_on = [azapi_resource.mongoCluster, azurerm_key_vault_key.encryptionKey_replica, time_sleep.wait_for_vault_policies]
}

# Additional cluster for PremiumSSDv2 storage type coverage
resource "azapi_resource" "mongoClusterSSDv2" {
  type      = "Microsoft.DocumentDB/mongoClusters@2025-09-01"
  parent_id = azapi_resource.resourceGroup.id
  name      = "${var.resource_name}-ssdv2"
  location  = var.location
  body = {
    properties = {
      authConfig = {
        allowedModes = ["MicrosoftEntraID"]
      }
      compute = {
        tier = "M30"
      }
      highAvailability = {
        targetMode = "Disabled"
      }
      serverVersion = "6.0"
      publicNetworkAccess = "Disabled"
      sharding = {
        shardCount = 1
      }
      storage = {
        sizeGb = 64
        type   = "PremiumSSDv2"
      }
    }
  }
  schema_validation_enabled = false
  ignore_casing             = false
  ignore_missing_property   = false
}

# User (Entra Service Principal) for SSDv2 cluster using managed identity
resource "azapi_resource" "mongoUser_EntraServicePrincipal" {
  type      = "Microsoft.DocumentDB/mongoClusters/users@2025-09-01"
  name      = azurerm_user_assigned_identity.user_identity_ssdv2.principal_id
  parent_id = azapi_resource.mongoClusterSSDv2.id

  body = {
    properties = {
      roles = [
        {
          role = "root"
          db   = "admin"
        }
      ]
      identityProvider = {
        type = "MicrosoftEntraID"
        properties = {
          principalType = "servicePrincipal"
        }
      }
    }
  }
  schema_validation_enabled = false
  ignore_casing             = false
  ignore_missing_property   = false

  depends_on = [azurerm_user_assigned_identity.user_identity_ssdv2]
}


resource "azapi_resource" "firewallRule" {
  type      = "Microsoft.DocumentDB/mongoClusters/firewallRules@2025-09-01"
  parent_id = azapi_resource.mongoCluster.id
  name      = var.resource_name
  body = {
    properties = {
      endIpAddress   = "0.0.0.0"
      startIpAddress = "0.0.0.0"
    }
  }
  schema_validation_enabled = false
  ignore_casing             = false
  ignore_missing_property   = false
}
