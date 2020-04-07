## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: account
  package-name: azure-mgmt-subscription
  namespace: azure.mgmt.subscription
python-sdk-output-folder: "$(output-folder)/src/account/azext_account/vendored_sdks/subscription"
```
