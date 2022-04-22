## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: operationsmanagement
  namespace: azure.mgmt.operationsmanagement
  package-name: azure-mgmt-operationsmanagement
az-output-folder: $(azure-cli-extension-folder)/src/operationsmanagement
python-sdk-output-folder: "$(az-output-folder)/azext_operationsmanagement/vendored_sdks/operationsmanagement"
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
  - from: OperationsManagement.json
    where: $.definitions.CodeMessageError.properties.error
    transform: $['x-ms-client-name'] = 'error'
```
