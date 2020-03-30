## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: operationsmanagement
  namespace: azure.mgmt.operationsmanagement
  package-name: azure-mgmt-operationsmanagement
python-sdk-output-folder: "$(output-folder)/src/operationsmanagement/azext_operationsmanagement/vendored_sdks/operationsmanagement"
directive:
  - from: OperationsManagement.json
    where: $.parameters.ProviderNameParameter
    transform: $['x-ms-parameter-location'] = 'method'
  - from: OperationsManagement.json
    where: $.parameters.ResourceTypeParameter
    transform: $['x-ms-parameter-location'] = 'method'
  - from: OperationsManagement.json
    where: $.parameters.ResourceNameParameter
    transform: $['x-ms-parameter-location'] = 'method'
```
