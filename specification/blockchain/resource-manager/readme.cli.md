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
        name: 'consortium'
      - select: 'operation'
        where:
            operationGroup: 'locations'
            operation: 'listConsortiums'
        name: 'list'
      - select: 'operationGroup'
        where:
            operationGroup: 'blockchainMemberOperationResults'
        hidden: true
      - select: 'operation'
        where:
            operationGroup: 'blockchainMembers'
            operation: '(create|update)'
        hidden: true
      - select: 'operation'
        where:
            operationGroup: 'transactionNodes'
            operation: '(create|update)'
        hidden: true
```