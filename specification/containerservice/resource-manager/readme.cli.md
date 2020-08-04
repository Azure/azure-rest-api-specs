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
  cli-name: containerservice
  package-name: azure-mgmt-containerservice
  namespace: azure.mgmt.containerservice
  test-scenario:
    - name: /ManagedClusters/put/Create/Update Managed Cluster
    - name: /ManagedClusters/put/Create Managed Cluster with PPG
    - name: /ManagedClusters/put/Create/Update AAD Managed Cluster with EnableAzureRBAC
    - name: /OpenShiftManagedClusters/put/Create/Update OpenShift Managed Cluster
    - name: /ContainerServices/put/Create/Update Container Service
    - name: /AgentPools/put/Create/Update Agent Pool
    - name: /AgentPools/put/Update Agent Pool
    - name: /AgentPools/put/Create Spot Agent Pool
    - name: /AgentPools/put/Create Agent Pool with PPG
    - name: /PrivateEndpointConnections/put/Update Private Endpoint Connection
    - name: /AgentPools/get/Get Upgrade Profile for Agent Pool
    - name: /PrivateEndpointConnections/get/Get Private Endpoint Connection
    - name: /ManagedClusters/get/Get Upgrade Profile for Managed Cluster
    - name: /AgentPools/get/Get Agent Pool
    - name: /PrivateEndpointConnections/get/List Private Endpoint Connections by Managed Cluster
    - name: /AgentPools/get/Get available versions for agent pool
    - name: /ContainerServices/get/Get Container Service
    - name: /AgentPools/get/List Agent Pools by Managed Cluster
    - name: /OpenShiftManagedClusters/get/Get OpenShift Managed Cluster
    - name: /ManagedClusters/get/Get Managed Cluster
    - name: /OpenShiftManagedClusters/get/Get Managed Clusters by Resource Group
    - name: /ContainerServices/get/List Container Services by Resource Group
    - name: /ManagedClusters/get/Get Managed Clusters by Resource Group
    - name: /ContainerServices/get/List Container Service Orchestrators
    - name: /OpenShiftManagedClusters/get/List Managed Clusters
    - name: /ContainerServices/get/List Container Services
    - name: /ManagedClusters/get/List Managed Clusters
    - name: /Operations/get/List Operations
    - name: /ManagedClusters/post/Get Managed Cluster
    - name: /ManagedClusters/post/Get Managed Cluster
    - name: /ManagedClusters/post/Reset Service Principal Profile
    - name: /ManagedClusters/post/Get Managed Cluster
    - name: /ManagedClusters/post/Rotate Cluster Certificates
    - name: /ManagedClusters/post/Get Managed Cluster
    - name: /ManagedClusters/post/Reset AAD Profile
    - name: /OpenShiftManagedClusters/patch/Update OpenShift Managed Cluster Tags
    - name: /ManagedClusters/patch/Update Managed Cluster Tags
    - name: /PrivateEndpointConnections/delete/Delete Private Endpoint Connection
    - name: /AgentPools/delete/Delete Agent Pool
    - name: /ContainerServices/delete/Delete Container Service
    - name: /OpenShiftManagedClusters/delete/Delete OpenShift Managed Cluster
    - name: /ManagedClusters/delete/Delete Managed Cluster
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