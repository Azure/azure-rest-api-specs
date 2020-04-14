## CLI

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: migrateprojects
  namespace: azure.mgmt.migrateprojects
  package-name: azure-mgmt-migrateprojects
az-output-folder: $(azure-cli-extension-folder)/src/migrateprojects
python-sdk-output-folder: "$(az-output-folder)/azext_migrateprojects/vendored_sdks/migrateprojects"
```
