<!-- region Generated -->
# Dns
This directory contains the Cli common model for the Dns service.

> Metadata


``` yaml
# Migrated from Powershell's readme
title: KeyVault

directive: 
  # we have to pick the model that will not be inlined in a circular reference. (was very bad previously)
  - no-inline: 
    - Error
    
  - from: swagger-document
    where: $["x-ms-parameterized-host"]
    transform: >
      return {
      "hostTemplate": "https://{vaultName}.{keyVaultDnsSuffix}/",
      "useSchemePrefix": false,
      "positionInOperation": "first",
      "parameters": [
        {
          "name": "vaultName",
          "description": "The name of the vault to execute operations on.",
          "required": true,
          "type": "string",
          "in": "path",
          "x-ms-skip-url-encoding": true
        },
        {
          "name": "keyVaultDnsSuffix",
          "description": "The URI used as the base for all key vault requests.",
          "required": true,
          "type": "string",
          "in": "path",
          "x-ms-skip-url-encoding": true,
          "default": "vault.azure.net",
          "x-ms-parameter-location": "client"
        }
      ]}

cli:
    cli-directive:
      - where:
            resource: 'vaults'
            op: '^(getDeleted|purgeDeleted)$'
        hidden: true
      - where:
            enum: 'skuName'
        alias: 'sku'
        name: 'sku'
      - where:
            resource: 'vaults'
            op: 'checkNameAvailability'
        name: 'test'
        hidden: true
      - where:
            resource: 'vaults'
            op: 'update'
        hidden: true
      - where:
            type: 'vault'
        formatTable:
            properties:
                - Name
                - ResourceGroupName
                - Location
                - Uri
      - where:
            type: 'deletedVault'
        formatTable:
            properties:
              - Name
              - ResourceGroupName
              - Location
              - DeletionDate
              - ScheduledPurgeDate

```