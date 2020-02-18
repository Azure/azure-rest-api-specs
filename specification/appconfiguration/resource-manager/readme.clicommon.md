<!-- region Generated -->
# Az.Aks
This directory contains the Cli common model for the Aks service.

> Metadata
``` yaml
# Migrated from Powershell's readme

```

``` yaml
# Migrated from Powershell's readme

clicommon:
    cli-directive:
      - select: 'parameter'
        where:
            parameter: '(config_store_creation_parameter|regenerate_key_parameter|check_name_availability_parameter)'
        set:
            hide: 'true'
      - select: 'operation'
        where:
            operationGroup: 'configuration_stores'
            operation: 'update'
        set:
            hide: 'true'
      - select: 'parameter'
        where:
            parameter: 'config_store_name'
        set:
            name: 'name'
      - select: 'operationGroup'
        where:
            operationGroup: 'operations'
        set:
            name: 'stores'
```