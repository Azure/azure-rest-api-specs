## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: datafactory
  namespace: azure.mgmt.datafactory
  package-name: azure-mgmt-datafactory
python-sdk-output-folder: "$(output-folder)/src/datafactory/azext_datafactory/vendored_sdks/datafactory"
  
clicommon:
    cli-directive:
    # directive on operationGroup
      - select: 'operationGroup'
        where:
            operationGroup: 'operations'
        hidden: true
      - where:
            parameter: location
        required: true

```
