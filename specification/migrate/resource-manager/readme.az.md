## CLI

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  batch: true
batch:
  - package-migrate: true
  - package-offazure: true
```

``` yaml $(az) && $(package-migrate)
az:
  extensions: migrate
  namespace: azure.mgmt.migrate
  package-name: azure-mgmt-migrate
az-output-folder: $(azure-cli-extension-folder)/src/migrate
python-sdk-output-folder: $(az-output-folder)/azext_migrate/vendored_sdks/migrate
```

``` yaml $(az) && $(package-offazure)
az:
  extensions: offazure
  namespace: azure.mgmt.offazure
  package-name: azure-mgmt-offazure
az-output-folder: $(azure-cli-extension-folder)/src/offazure
python-sdk-output-folder: $(az-output-folder)/azext_offazure/vendored_sdks/offazure
```