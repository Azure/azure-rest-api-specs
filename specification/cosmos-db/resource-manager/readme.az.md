## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: cosmosdb
  namespace: azure.mgmt.cosmosdb
  package-name: azure-mgmt-cosmosdb
az-output-folder: $(azure-cli-extension-folder)/src/cosmosdb-preview
python-sdk-output-folder: "$(az-output-folder)/azext_cosmosdb_preview/vendored_sdks/cosmodb"

directive:
      - where:
            group: 'cosmosdb data-transfer-job'
        set:
            group: 'cosmosdb dts'

cli:
    cli-directive:
      - where:
            group: 'DataTransferJobs'
            op: 'Create'
            param: 'jobCreateParameters'
        json: true
      - where:
            group: 'DataTransferJobs'
            op: 'Create'
            param: 'jobCreateParameters'
        cli-flatten: false

```