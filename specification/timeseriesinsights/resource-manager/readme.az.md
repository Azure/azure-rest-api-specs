## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az) && $(target-mode) != 'core'
az:
  extensions: timeseriesinsights
  namespace: azure.mgmt.timeseriesinsights
  package-name: azure-mgmt-timeseriesinsights
az-output-folder: $(azure-cli-extension-folder)/src/timeseriesinsights
python-sdk-output-folder: "$(az-output-folder)/azext_timeseriesinsights/vendored_sdks/timeseriesinsights"

#cli:
#    cli-directive:
#      - where:
#            group: MachineLearningCompute
#            op: CreateOrUpdate
#            param: properties
#        poly-resource: true
```
``` yaml $(az) && $(target-mode) == 'core'
az:
  extensions: timeseriesinsights
  namespace: azure.mgmt.timeseriesinsights
  package-name: azure-mgmt-timeseriesinsights
az-output-folder: $(azure-cli-folder)/src/azure-cli/azure/cli/command_modules/timeseriesinsights
python-sdk-output-folder: "$(az-output-folder)/vendored_sdks/timeseriesinsights"
```