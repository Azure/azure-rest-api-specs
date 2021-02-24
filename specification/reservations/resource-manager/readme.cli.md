## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
title: 'Quota'
cli:
  cli-name: capacity
  package-name: azure-mgmt-capacity
  namespace: azure.mgmt.capacity
  cli:
  cli-directive:
    - select: 'operationGroup'
      where:
          operationGroup: 'operations'
      hidden: true
    - select: 'operation'
      where:
          operationGroup: 'QuotaInformation'
          operation: '(get|createOrUpdate|update)'
```