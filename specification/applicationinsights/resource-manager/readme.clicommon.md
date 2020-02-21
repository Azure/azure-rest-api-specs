<!-- region Generated -->
# Az.Aks
This directory contains the Cli common model for the Aks service.

> Metadata

``` yaml
# Migrated from Powershell's readme
clicommon:
    glossary:
        - 'insights'
    cli-directive:
      - select: 'operation'
        where:
            operationGroup: 'components'
            operation: '^(delete|purge|get_purge_status)$'
        set:
            remove: true
      - select: 'operation'
        where:
            operationGroup: 'API_keys'
            operation: 'create|delete'
        set:
            remove: true
      - select: 'operation'
        where:
            operationGorup: 'components'
            operation: 'update_tags'
        set:
            remove: true
      - select: 'operationGroup'
        where:
            operationGroup: 'components'
        set:
            name: 'app_insights'
      - select: 'operation'
        where:
            operationGroup: 'components'
            operation: 'get|create_or_update'
        set:
            hide: true
      - select: 'operation'
        where:
            operatoinGroup: 'API_keys'
            operation: 'get'
        set:
            hide: true
```