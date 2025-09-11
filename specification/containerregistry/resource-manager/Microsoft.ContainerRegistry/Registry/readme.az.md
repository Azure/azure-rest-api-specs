## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: containerregistry
  namespace: azure.mgmt.containerregistry
  package-name: azure-mgmt-containerregistry
az-output-folder: $(azure-cli-extension-folder)/src/containerregistry
python-sdk-output-folder: "$(az-output-folder)/azext_containerregistry/vendored_sdks/containerregistry"

#cli:
#    cli-directive:
#      - where:
#            group: MachineLearningCompute
#            op: CreateOrUpdate
#            param: properties
#        poly-resource: true
```
