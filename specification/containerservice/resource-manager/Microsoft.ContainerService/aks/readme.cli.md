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
            operationGroup: 'agentPools'
            operation: '^(get|createOrUpdate|delete)$'
            parameter: 'resourceName'
        set:
            name: 'aks_name'
            alias: 'resource_name'
      - select: 'parameter'
        where:
            operationGroup: '(managedClusters|containerServices|openShiftManagedClusters|operations)'
            parameter: 'resourceName'
        set:
            name: 'name'
            alias: 'resourceName'
      - select: 'parameter'
        where:
            operationGroup: 'agentPools'
            operation: '(getAvailableAgentPoolVersions|getUpgradeProfile)'
            parameter: 'resourceName'
        set:
            name: 'name'
            alias: 'resource_name'
      - select: 'operationGroup'
        where:
            operationGroup: 'managedClusters'
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