## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: account
  package-name: azure-mgmt-subscription
  namespace: azure.mgmt.subscription
az-output-folder: $(azure-cli-extension-folder)/src/account
python-sdk-output-folder: "$(az-output-folder)/azext_account/vendored_sdks/subscription"
```
