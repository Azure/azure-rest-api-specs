<!-- region Generated -->
# Az.Aks
This directory contains the Cli common model for the Aks service.

> Metadata

``` yaml
# Migrated from Powershell's readme
cli:
    naming:
        cli:
            glossary:
                - 'insights'
    cli-directive:
      - select: 'operation'
        where:
            operationGroup: 'components'
            operation: '^(delete|purge|get_purge_status)$'
        removed: true
      - select: 'operation'
        where:
            operationGroup: 'API_keys'
            operation: 'create|delete'
        removed: true
      - select: 'operation'
        where:
            operationGorup: 'components'
            operation: 'update_tags'
        removed: true
      - select: 'operationGroup'
        where:
            operationGroup: 'components'
        name: 'app_insights'
      - select: 'operation'
        where:
            operationGroup: 'components'
            operation: 'get|create_or_update'
        hidden: true
      - select: 'operation'
        where:
            operatoinGroup: 'API_keys'
            operation: 'get'
        hidden: true
```