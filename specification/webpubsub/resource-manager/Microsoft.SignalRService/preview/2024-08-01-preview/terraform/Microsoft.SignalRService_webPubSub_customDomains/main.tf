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

resource "azapi_resource" "webPubSub" {
  type      = "Microsoft.SignalRService/WebPubSub@2023-02-01"
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
      disableAadAuth   = false
      disableLocalAuth = false
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
    object_id = azapi_resource.webPubSub.identity[0].principal_id

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

// OperationId: WebPubSubCustomCertificates_CreateOrUpdate, WebPubSubCustomCertificates_Get, WebPubSubCustomCertificates_Delete
// PUT GET DELETE /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/customCertificates/{certificateName}
resource "azapi_resource" "customCertificate" {
  type      = "Microsoft.SignalRService/webPubSub/customCertificates@2024-08-01-preview"
  parent_id = azapi_resource.webPubSub.id
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
        cname = azapi_resource.webPubSub.output.properties.hostName
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

// OperationId: WebPubSubCustomDomains_CreateOrUpdate, WebPubSubCustomDomains_Get, WebPubSubCustomDomains_Delete
// PUT GET DELETE /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/customDomains/{name}
resource "azapi_resource" "customDomain" {
  type      = "Microsoft.SignalRService/webPubSub/customDomains@2024-08-01-preview"
  parent_id = azapi_resource.webPubSub.id
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

// OperationId: WebPubSubCustomDomains_List
// GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/customDomains
data "azapi_resource_list" "listCustomDomainsByWebPubSub" {
  type       = "Microsoft.SignalRService/webPubSub/customDomains@2024-08-01-preview"
  parent_id  = azapi_resource.webPubSub.id
  depends_on = [azapi_resource.customDomain]
}

