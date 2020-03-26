<!-- region Generated -->
# Dns
This directory contains the Cli common model for the Dns service.

> Metadata
``` yaml
# Migrated from Powershell's readme

title: 'ConnectedMachine'

cli:
    cli-directive:
      - select: 'operationGroup'
        where:
            operatoinGroup: 'operations'
        hidden: true
      - select: 'operation'
        where:
            operationGroup: 'machines'
            operation: '(reconnect|createOrUpdate|update)'
        removed: true
      - select: 'operation'
        where:
            operationGroup: 'machineExtensions'
            operation: '(createOrUpdate|update|delete|get|list)'
        removed: true
```