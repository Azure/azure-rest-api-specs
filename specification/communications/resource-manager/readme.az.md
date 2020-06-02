## AZ

These settings apply only when `--az` is specified on the command line.
Please also specify `--azure-cli-extension-folder=<path to output folder>`.

``` yaml $(az)
az:
  extensions: communication
  namespace: azure.mgmt.communication
  package-name: azure-mgmt-communication
az-output-folder: $(azure-cli-extension-folder)/src/communication
python-sdk-output-folder: "$(az-output-folder)/azext_communication/vendored_sdks/communication"

#cli:
#    cli-directive:
#      - where:
#            group: MachineLearningCompute
#            op: CreateOrUpdate
#            param: properties
#        poly-resource: true
```
