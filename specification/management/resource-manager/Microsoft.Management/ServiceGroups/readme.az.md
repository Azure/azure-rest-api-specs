## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: servicegroup
  namespace: azure.mgmt.servicegroup
  package-name: azure-mgmt-servicegroup
  client-subscription-bound: false
  client-base-url-bound: true
az-output-folder: $(azure-cli-extension-folder)/src/servicegroup
python-sdk-output-folder: "$(az-output-folder)/azext_servicegroup/vendored_sdks/servicegroup"

```
