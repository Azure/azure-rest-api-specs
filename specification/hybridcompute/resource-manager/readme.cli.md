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
            param: 'name'
        alias:
            - n
            - extension_name
```
