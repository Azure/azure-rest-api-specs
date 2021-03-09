## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: machinelearningservices
  namespace: azure.mgmt.machinelearningservices
  package-name: azure-mgmt-machinelearningservices
az-output-folder: $(azure-cli-extension-folder)/src/machinelearningservices
python-sdk-output-folder: "$(az-output-folder)/azext_machinelearningservices/vendored_sdks/machinelearningservices"
  
cli:
    cli-directive:
      - where:
            group: MachineLearningCompute
            op: CreateOrUpdate
            param: properties
        poly-resource: true
```
