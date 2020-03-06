<!-- region Generated -->
# Dns
This directory contains the Cli common model for the Blockchain service.

> Metadata

``` yaml
# Migrated from Powershell's readme
directive:
  - from: swagger-document
    where: $.paths..operationId
    transform: return $.replace(/ListRegenerateApiKeys$/, "RegenerateApiKeys")
  - from: swagger-document
    where: $
    transform: return $.replace(/locationName/, "location")

cli:
    cli-directive:
      - select: 'operationGroup'  
        where:
            operationGroup: 'operations'
        hidden: true
      - select: 'operationGroup'
        where:
            operationGroup: 'locations'
        name: 'Consortium'
      - select: 'operation'
        where:
            operationGroup: 'locations'
            operation: 'list_consortiums'
        name: 'list'
      - select: 'operationGroup'
        where:
            operationGroup: 'blockchain_member_operation_results'
        hidden: true
      - select: 'operation'
        where:
            operationGroup: 'blockchain_members'
            operation: '(create|update)'
        hidden: true
      - select: 'operation'
        where:
            operationGroup: 'transaction_nodes'
            operation: '(create|update)'
        hidden: true
```