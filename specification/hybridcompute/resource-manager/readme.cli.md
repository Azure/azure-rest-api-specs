# CLI HybridCompute

This directory contains the Cli common model for the Hybrid Compute service.

> Metadata
``` yaml
title: 'ConnectedMachine'

cli:
  cli-directive:
    - select: 'operationGroup'
      where:
          operationGroup: 'operations'
      hidden: true
    - select: 'operation'
      where:
          operationGroup: 'machines'
          operation: '(reconnect|createOrUpdate|update)'
      removed: true
    - where:
          param: 'autoUpgradeMinorVersion'
      alias:
          - auto_upgrade_minor
    - where:
          operationGroup: 'machineExtensions'
          param: 'extensionName'
      alias:
          - n
          - extension_name
          - name
  test-scenario:
    - name: /MachineExtensions/put/Create or Update a Machine Extension
    - name: /MachineExtensions/get/Get all Machine Extensions
    - name: /MachineExtensions/get/Get Machine Extension
    - name: /MachineExtensions/patch/Create or Update a Machine Extension
    - name: /MachineExtensions/delete/Delete a Machine Extension
    - name: /Machines/get/Get Machine
    - name: /Machines/get/List Machines by resource group
    - name: /Machines/get/List Machines by resource group
    - name: /Machines/delete/Delete a Machine
```
