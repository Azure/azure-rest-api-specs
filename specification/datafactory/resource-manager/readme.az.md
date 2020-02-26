## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: datafactory
  namespace: azure.mgmt.datafactory
  package-name: azure-mgmt-datafactory
python-sdk-output-folder: "$(output-folder)/src/datafactory/azext_datafactory/vendored_sdks/datafactory"

directive:
  from: swagger-document
  where: $..parameters[?(@.in=='body')]
  transform: >
    $['x-ms-client-flatten'] = true;
  reason: Flatten everything for Azure CLI

```
