## CLI

These settings apply only when `--cli` is specified on the command line.

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
```