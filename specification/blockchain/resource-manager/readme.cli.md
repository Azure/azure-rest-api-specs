<!-- region Generated -->
# Dns
This directory contains the Cli common model for the Blockchain service.

> Metadata
``` yaml
# Migrated from Powershell's readme

```

``` yaml
# Migrated from Powershell's readme
directive:
  - from: swagger-document
    where: $.paths..operationId
    transform: return $.replace(/ListRegenerateApiKeys$/, "RegenerateApiKeys")
  - from: swagger-document
    where: $
    transform: return $.replace(/locationName/, "location")


clicommon:
    cli-directive:
      - select: 'operationGroup'  
        where:
            operationGroup: 'operations'
        set:
            hide: true
      - select: 'operationGroup'
        where:
            operationGroup: 'locations'
        set:
            name: 'Consortium'
      - select: 'operation'
        where:
            operationGroup: 'locations'
            operation: 'list_consortiums'
        set:
            name: 'list'
      - select: 'operationGroup'
        where:
            operationGroup: 'blockchain_member_operation_results'
        set:
            hide: true
      - select: 'operation'
        where:
            operationGroup: 'blockchain_members'
            operation: '(create|update)'
        set:
            hide: true
      - select: 'operation'
        where:
            operationGroup: 'transaction_nodes'
            operation: '(create|update)'
        set:
            hide: true
```