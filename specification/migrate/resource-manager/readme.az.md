## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: migrate
  package-name: azure-mgmt-migrate
  namespace: azure.mgmt.migrate
az-output-folder: $(azure-cli-extension-folder)/src/migrate
python-sdk-output-folder: "$(az-output-folder)/azext_migrate/vendored_sdks/migrate"
```
