
resource "azapi_resource" "resourceGroup" {
  type     = "Microsoft.Resources/resourceGroups@2020-06-01"
  name     = var.resource_name
  location = var.location
}

resource "azurerm_user_assigned_identity" "userAssignedIdentity" {
  name                = "${var.resource_name}-primary"
  location            = var.location
  resource_group_name = azapi_resource.resourceGroup.name
}

resource "azurerm_user_assigned_identity" "userAssignedIdentity2" {
  name                = "${var.resource_name}-update"
  location            = var.location
  resource_group_name = azapi_resource.resourceGroup.name
}

# User Assigned Identity for SSDv2 service principal user
resource "azurerm_user_assigned_identity" "user_identity_ssdv2" {
  name                = "${var.resource_name}-ssdv2-user"
  location            = var.location
  resource_group_name = azapi_resource.resourceGroup.name
}

resource "azurerm_key_vault" "cmk_vault" {
  name                        = "${substr(var.resource_name, 0, 15)}-cmk-v"
  location                    = var.location
  resource_group_name         = azapi_resource.resourceGroup.name
  tenant_id                   = azurerm_user_assigned_identity.userAssignedIdentity.tenant_id
  sku_name                    = "standard"
  purge_protection_enabled    = true
  public_network_access_enabled = true
  enable_rbac_authorization   = false

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
    key_permissions = [
      "Get",
      "List",
      "Create",
      "Delete",
      "Update",
      "Import",
      "Backup",
      "Restore",
      "Recover",
      "WrapKey",
      "UnwrapKey",
      "Rotate",
      "GetRotationPolicy",
      "SetRotationPolicy",
    ]
  }

  access_policy {
    tenant_id = azurerm_user_assigned_identity.userAssignedIdentity.tenant_id
    object_id = azurerm_user_assigned_identity.userAssignedIdentity.principal_id

    key_permissions = [
      "Get",
      "List",
      "WrapKey",
      "UnwrapKey",
    ]
  }

  access_policy {
    tenant_id = azurerm_user_assigned_identity.userAssignedIdentity2.tenant_id
    object_id = azurerm_user_assigned_identity.userAssignedIdentity2.principal_id

    key_permissions = [
      "Get",
      "List",
      "WrapKey",
      "UnwrapKey",
    ]
  }
}

resource "azurerm_key_vault_key" "encryptionKey" {
  name         = "cmk-encryption-key-01"
  key_vault_id = azurerm_key_vault.cmk_vault.id
  key_type     = "RSA"
  key_size     = 4096
  key_opts     = ["wrapKey", "unwrapKey"]

  depends_on = [azurerm_key_vault.cmk_vault]
}

# Add sleep to ensure access policies are propagated
resource "time_sleep" "wait_for_vault_policies" {
  depends_on = [
    azurerm_key_vault.cmk_vault,
    azurerm_key_vault_key.encryptionKey,
    azurerm_key_vault_key.encryptionKey2,
    azurerm_key_vault.cmk_vault_replica,
    azurerm_key_vault_key.encryptionKey_replica
  ]

  create_duration = "60s"
}

resource "azurerm_key_vault_key" "encryptionKey2" {
  name         = "cmk-encryption-key-02"
  key_vault_id = azurerm_key_vault.cmk_vault.id
  key_type     = "RSA"
  key_size     = 4096
  key_opts     = ["wrapKey", "unwrapKey"]

  depends_on = [azurerm_key_vault.cmk_vault]
}

# Resources for geo-replica in centralus region
resource "azurerm_user_assigned_identity" "userAssignedIdentity_replica" {
  name                = "${var.resource_name}-replica"
  location            = var.replica_location
  resource_group_name = azapi_resource.resourceGroup.name
}

resource "azurerm_key_vault" "cmk_vault_replica" {
  name                        = "${substr(var.resource_name, 0, 15)}-cmk-r"
  location                    = var.replica_location
  resource_group_name         = azapi_resource.resourceGroup.name
  tenant_id                   = azurerm_user_assigned_identity.userAssignedIdentity_replica.tenant_id
  sku_name                    = "standard"
  purge_protection_enabled    = true
  public_network_access_enabled = true
  enable_rbac_authorization   = false

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
    key_permissions = [
      "Get",
      "List",
      "Create",
      "Delete",
      "Update",
      "Import",
      "Backup",
      "Restore",
      "Recover",
      "WrapKey",
      "UnwrapKey",
      "Rotate",
      "GetRotationPolicy",
      "SetRotationPolicy",
    ]
  }

  access_policy {
    tenant_id = azurerm_user_assigned_identity.userAssignedIdentity_replica.tenant_id
    object_id = azurerm_user_assigned_identity.userAssignedIdentity_replica.principal_id

    key_permissions = [
      "Get",
      "List",
      "WrapKey",
      "UnwrapKey",
    ]
  }
}

resource "azurerm_key_vault_key" "encryptionKey_replica" {
  name         = "cmk-encryption-key-replica"
  key_vault_id = azurerm_key_vault.cmk_vault_replica.id
  key_type     = "RSA"
  key_size     = 4096
  key_opts     = ["wrapKey", "unwrapKey"]

  depends_on = [azurerm_key_vault.cmk_vault_replica]
}
