## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: containerregistrytasks
  namespace: azure.mgmt.containerregistrytasks
  package-name: azure-mgmt-containerregistrytasks
az-output-folder: $(azure-cli-extension-folder)/src/containerregistrytasks
python-sdk-output-folder: "$(az-output-folder)/azext_containerregistry/vendored_sdks/containerregistrytasks"

#cli:
#    cli-directive:
#      - where:
#            group: MachineLearningCompute
#            op: CreateOrUpdate
#            param: properties
#        poly-resource: true
```
