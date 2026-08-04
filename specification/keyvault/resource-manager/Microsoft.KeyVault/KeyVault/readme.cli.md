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
  test-scenario:
    - name: /Vaults/put/Create a new vault or update an existing vault
    - name: /Vaults/put/Create or update a vault with network acls
      disabled: true
    - name: /Vaults/put/Add an access policy, or update an access policy with new permissions
      disabled: true
    - name: /PrivateEndpointConnections/put/KeyVaultPutPrivateEndpointConnection
      disabled: true
    - name: /PrivateEndpointConnections/get/KeyVaultGetPrivateEndpointConnection
      disabled: true
    - name: /PrivateLinkResources/get/KeyVaultListPrivateLinkResources
      disabled: true
    - name: /Vaults/get/Retrieve a vault
    - name: /Vaults/get/List vaults in the specified resource group
    - name: /Vaults/get/List deleted vaults in the specified subscription
    - name: /Vaults/get/List vaults in the specified subscription
    - name: /Vaults/get/List vaults in the specified subscription
    - name: /Operations/get/Lists available Rest API operations.
    - name: /Vaults/patch/Update an existing vault
      disabled: true
    - name: /Vaults/post/Validate a vault name
    - name: /PrivateEndpointConnections/delete/KeyVaultDeletePrivateEndpointConnection
      disabled: true
    - name: /Vaults/delete/Delete a vault
    - name: /Vaults/get/Retrieve a deleted vault
      disabled: true
    - name: /Vaults/post/Purge a deleted vault
      disabled: true
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