<!-- region Generated -->
# Az.Aks
This directory contains the Cli common model for the Aks service.

> Metadata
``` yaml
# Migrated from Powershell's readme

service-name: Aks
title: AksClient

directive:
  - from: managedClusters.json
    where: $.definitions.SubResource.properties
    transform: >
      return {
        "id": {
          "readOnly": true,
          "type": "string",
          "description": "Resource ID."
        },
        "name": {
          "readOnly": true,
          "type": "string",
          "description": "The name of the resource that is unique within a resource group. This name can be used to access the resource."
        },
        "restype": {
          "readOnly": true,
          "type": "string",
          "description": "Resource type"
        }
      }

cli:
    cli-directive:
      - select: 'operationGroup'
        where:
            operationGroup: 'operations'
        hidden: true
      - select: 'parameter'
        where:
            operationGroup: 'agent_pools'
            operation: '^(get|create_or_update|delete)$'
            parameter: 'resource_name'
        set:
            name: 'aks_name'
            alias: 'resource_name'
      - select: 'parameter'
        where:
            operationGroup: '(managed_clusters|container_services|open_shift_managed_clusters|operations)'
            parameter: 'resource_name'
        set:
            name: 'name'
            alias: 'resource_name'
      - select: 'parameter'
        where:
            operationGroup: 'agent_pools'
            operation: '(get_available_agent_pool_versions|get_upgrade_profile)'
            parameter: 'resource_name'
        set:
            name: 'name'
            alias: 'resource_name'
      - select: 'operationGroup'
        where:
            operationGroup: 'managed_clusters'
        formatTable:
            properties:
              - Name
              - Type
              - ProvisioningState
              - DnsPrefix
              - Fqdn
              - KubernetesVersion
              - Id
              - Tag
```