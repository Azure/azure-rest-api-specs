## CLI

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: migrate
  namespace: azure.mgmt.migrate
  package-name: azure-mgmt-migrate
python-sdk-output-folder: "$(output-folder)/src/migrate/azext_migrate/vendored_sdks/migrate"
```
