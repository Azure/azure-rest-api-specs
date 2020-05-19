## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: costmanagement
  namespace: azure.mgmt.costmanagement
  package-name: azure-mgmt-costmanagement
  client-subscription-bound: false
  client-base-url-bound: true
az-output-folder: $(azure-cli-extension-folder)/src/costmanagement
python-sdk-output-folder: "$(az-output-folder)/azext_costmanagement/vendored_sdks/costmanagement"

```
