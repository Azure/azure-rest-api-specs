terraform {
  required_providers {
    azapi = {
      source = "Azure/azapi"
    }
  }
}

provider "azapi" {
}

provider "azurerm" {
  features {
  }
}

variable "resource_name" {
  type    = string
  default = "acctest049822"
}

variable "location" {
  type    = string
  default = "eastus2euap"
}

data "azurerm_client_config" "current" {
}

resource "azapi_resource" "resourceGroup" {
  type     = "Microsoft.Resources/resourceGroups@2020-06-01"
  name     = var.resource_name
  location = var.location
}

resource "azapi_resource" "signalR" {
  type      = "Microsoft.SignalRService/SignalR@2023-02-01"
  parent_id = azapi_resource.resourceGroup.id
  name      = var.resource_name
  location  = var.location
  identity {
    type         = "SystemAssigned"
    identity_ids = []
  }

  body = {
    properties = {
      cors = {
      }
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

resource "azurerm_key_vault" "test" {
  name                       = var.resource_name
  location                   = var.location
  resource_group_name        = azapi_resource.resourceGroup.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    certificate_permissions = [
      "Create",
      "Delete",
      "Get",
      "Import",
      "Purge",
      "Recover",
      "Update",
      "List",
    ]

    secret_permissions = [
      "Get",
      "Set",
    ]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = azapi_resource.signalR.identity[0].principal_id

    certificate_permissions = [
      "Create",
      "Delete",
      "Get",
      "Import",
      "Purge",
      "Recover",
      "Update",
      "List",
    ]

    secret_permissions = [
      "Get",
      "Set",
    ]
  }
}

resource "azurerm_key_vault_certificate" "test" {
  name         = var.resource_name
  key_vault_id = azurerm_key_vault.test.id
  certificate {
    contents = filebase64("certificate-to-import.pfx")
    password = ""
  }
}

// OperationId: SignalRCustomCertificates_CreateOrUpdate, SignalRCustomCertificates_Get, SignalRCustomCertificates_Delete
// PUT GET DELETE /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/customCertificates/{certificateName}
resource "azapi_resource" "customCertificate" {
  type      = "Microsoft.SignalRService/signalR/customCertificates@2024-08-01-preview"
  parent_id = azapi_resource.signalR.id
  name      = var.resource_name
  body = {
    properties = {
      keyVaultBaseUri       = azurerm_key_vault.test.vault_uri
      keyVaultSecretName    = azurerm_key_vault_certificate.test.name
      keyVaultSecretVersion = azurerm_key_vault_certificate.test.version
    }
  }
  schema_validation_enabled = false
}

resource "azapi_resource" "dnsZone" {
  type      = "Microsoft.Network/dnsZones@2018-05-01"
  parent_id = azapi_resource.resourceGroup.id
  name      = "${var.resource_name}.com"
  location  = "global"
}

resource "azapi_resource" "CNAME" {
  type      = "Microsoft.Network/dnsZones/CNAME@2018-05-01"
  parent_id = azapi_resource.dnsZone.id
  name      = "signalr"
  body = {
    properties = {
      CNAMERecord = {
        cname = azapi_resource.signalR.output.properties.hostName
      }
      TTL = 3600
      metadata = {
      }
      targetResource = {
      }
    }
  }
  depends_on = [azapi_resource.customCertificate]
}

// OperationId: SignalRCustomDomains_CreateOrUpdate, SignalRCustomDomains_Get, SignalRCustomDomains_Delete
// PUT GET DELETE /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/customDomains/{name}
resource "azapi_resource" "customDomain" {
  type      = "Microsoft.SignalRService/signalR/customDomains@2024-08-01-preview"
  parent_id = azapi_resource.signalR.id
  name      = var.resource_name
  body = {
    properties = {
      customCertificate = {
        id = azapi_resource.customCertificate.id
      }
      domainName = "signalr.${azapi_resource.dnsZone.name}"
    }
  }
  schema_validation_enabled = false
}

// OperationId: SignalRCustomDomains_List
// GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/customDomains
data "azapi_resource_list" "listCustomDomainsBySignalR" {
  type       = "Microsoft.SignalRService/signalR/customDomains@2024-08-01-preview"
  parent_id  = azapi_resource.signalR.id
  depends_on = [azapi_resource.customDomain]
}

