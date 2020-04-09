## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: datafactory
  namespace: azure.mgmt.datafactory
  package-name: azure-mgmt-datafactory
python-sdk-output-folder: "$(output-folder)/azext_datafactory/vendored_sdks/datafactory"

cli:
    cli-directive:
    # directive on operationGroup
      - select: 'operationGroup'
        where:
            operationGroup: 'Operations'
            operation: 'List'
        hidden: true
      - where:
            parameter: location
        required: true
      - where:
            group: Pipelines
            parameter: pipeline
        json: true
      - where:
            group: IntegrationRuntimes
            op: CreateOrUpdate
            param: properties
        poly-resource: true
```
