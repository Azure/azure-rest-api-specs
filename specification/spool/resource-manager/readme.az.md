## AZ

These settings apply only when `--az` is specified on the command line.
Please also specify `--azure-cli-extension-folder=<path to output folder>`.

``` yaml $(az)
az:
  extensions: spoolservice
  namespace: azure.mgmt.spoolservice
  package-name: azure-mgmt-spoolservice
az-output-folder: $(azure-cli-extension-folder)/src/spoolservice
python-sdk-output-folder: "$(az-output-folder)/azext_spoolservice/vendored_sdks/spoolservice"

#cli:
#    cli-directive:
#      - where:
#            group: MachineLearningCompute
#            op: CreateOrUpdate
#            param: properties
#        poly-resource: true
```
