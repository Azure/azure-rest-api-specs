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
            operation: '^(delete|purge|getPurgeStatus)$'
        removed: true
      - select: 'operation'
        where:
            operationGroup: 'APIkeys'
            operation: 'create|delete'
        removed: true
      - select: 'operation'
        where:
            operationGorup: 'components'
            operation: 'updateTags'
        removed: true
      - select: 'operationGroup'
        where:
            operationGroup: 'components'
        name: 'app_insights'
      - select: 'operation'
        where:
            operationGroup: 'components'
            operation: 'get|createOrUpdate'
        hidden: true
      - select: 'operation'
        where:
            operatoinGroup: 'APIKeys'
            operation: 'get'
        hidden: true
```