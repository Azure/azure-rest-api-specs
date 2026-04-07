# CLI HybridCompute

This directory contains the Cli common model for the Hybrid Compute service.

> Metadata
``` yaml
title: 'ConnectedMachine'

cli:
  cli-directive:
    - where:
          group: machines
          op: createOrUpdate
      hidden: true

  test-scenario:
    ConnectedMachine:
      - name: /Machines/get/Get Machine
      - name: /Machines/get/List Machines by resource group
      - name: /Machines/delete/Delete a Machine
    ConnectedMachineExtension:
      - name: /connectedmachine/post/Upgrade Machine Extensions
      - name: /MachineExtensions/put/Create or Update a Machine Extension
      - name: /MachineExtensions/get/GET all Machine Extensions
      - name: /MachineExtensions/get/GET Machine Extension
      - name: /MachineExtensions/patch/Create or Update a Machine Extension
      - name: /MachineExtensions/delete/Delete a Machine Extension
    PrivateEndpointConnection:
      - name: /PrivateEndpointConnections/put/Approve or reject a private endpoint connection with a given name.
      - name: /PrivateEndpointConnections/get/Gets list of private endpoint connections on a private link scope.
      - name: /PrivateEndpointConnections/get/Gets private endpoint connection.
      - name: /PrivateEndpointConnections/delete/Deletes a private endpoint connection with a given name.
    PrivateLinkResource:
      - name: /PrivateLinkResources/get/Gets private endpoint connection.
    PrivateLinkScope:
      - name: /PrivateLinkScopes/put/PrivateLinkScopeCreate
      - name: /PrivateLinkScopes/put/PrivateLinkScopeUpdate
      - name: /PrivateLinkScopes/get/PrivateLinkScopeGet
      - name: /PrivateLinkScopes/get/PrivateLinkScopeListByResourceGroup
      - name: /PrivateLinkScopes/get/PrivateLinkScopesList.json
      - name: /PrivateLinkScopes/patch/PrivateLinkScopeUpdateTagsOnly
      - name: /PrivateLinkScopes/delete/PrivateLinkScopesDelete
```