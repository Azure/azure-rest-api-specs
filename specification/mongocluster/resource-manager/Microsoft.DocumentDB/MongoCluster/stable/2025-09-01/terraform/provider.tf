terraform {
  required_providers {
    azapi = {
      source = "Azure/azapi"
    }
    time = {
      source = "hashicorp/time"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
    key_vault {
      purge_soft_delete_on_destroy       = false
      purge_soft_deleted_keys_on_destroy = false
      recover_soft_deleted_keys          = true
    }
  }
  skip_provider_registration = true
}

provider "azapi" {
  skip_provider_registration = false
}

data "azurerm_client_config" "current" {
}

variable "resource_name" {
  type    = string
  default = "acctest8960"
}

variable "location" {
  type    = string
  default = "westus3"
}

variable "replica_location" {
  type    = string
  default = "centralus"
}

variable "admin_username" {
  type    = string
  default = "mongoAdmin"
}

variable "admin_password" {
  type    = string
  default = "terraformTest@2025!"
  sensitive = true
}

variable "restore_admin_password" {
  type    = string
  default = "restoreTest@2025!"
  sensitive = true
}

