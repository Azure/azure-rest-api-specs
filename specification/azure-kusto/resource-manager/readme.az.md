## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
    extensions: kusto
    namespace: azure.mgmt.kusto
    package-name: azure-mgmt-kusto
python-sdk-output-folder: "$(output-folder)/src/kusto/azext_kusto/vendored_sdks/kusto"
  
cli:
    polymorphism:
        expand-as-resource: true
    cli-directive:
        - select: 'operationGroup'
          where:
            operationGroup: 'operations'
          hidden: true
        - where:
            parameter: location
          required: true
        - where:
            group: DataConnections
            op: CreateOrUpdate
            param: parameters
          poly-resource: true
        - where:
            group: Databases
            op: CreateOrUpdate
            param: parameters
          poly-resource: true
```
