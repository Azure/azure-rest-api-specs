## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: managementgroup
  namespace: azure.mgmt.managementgroup
  package-name: azure-mgmt-managementgroup
  client-subscription-bound: false
  client-base-url-bound: true
az-output-folder: $(azure-cli-extension-folder)/src/managementgroup
python-sdk-output-folder: "$(az-output-folder)/azext_managementgroup/vendored_sdks/managementgroup"

```
