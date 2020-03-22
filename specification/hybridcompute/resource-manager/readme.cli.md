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
            operation: '(reconnect|create_or_update|update)'
        removed: true
      - select: 'operation'
        where:
            operationGroup: 'machine_extensions'
            operation: '(create_or_update|update|delete|get|list)'
        removed: true
```