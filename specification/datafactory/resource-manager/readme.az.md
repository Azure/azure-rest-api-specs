## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: datafactory
  namespace: azure.mgmt.datafactory
  package-name: azure-mgmt-datafactory
az-output-folder:  $(azure-cli-extension-folder)/src/datafactory
python-sdk-output-folder: "$(az-output-folder)/azext_datafactory/vendored_sdks/datafactory"

input-file:
- Microsoft.DataFactory/stable/2018-06-01/entityTypes/DataFlow.json
- Microsoft.DataFactory/stable/2018-06-01/entityTypes/Dataset.json
- Microsoft.DataFactory/stable/2018-06-01/entityTypes/IntegrationRuntime.json
- Microsoft.DataFactory/stable/2018-06-01/entityTypes/LinkedService.json
- Microsoft.DataFactory/stable/2018-06-01/entityTypes/Pipeline.json
- Microsoft.DataFactory/stable/2018-06-01/entityTypes/Trigger.json

cli:
    cli-directive:
    # directive on operationGroup
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
