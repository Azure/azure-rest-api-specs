## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.ContainerService/stable/2019-04-30/openShiftManagedClusters.json
  - Microsoft.ContainerService/stable/2017-07-01/containerService.json
  - Microsoft.ContainerService/stable/2019-08-01/location.json
  - Microsoft.ContainerService/stable/2020-07-01/managedClusters.json
  - Microsoft.ContainerService/stable/2020-06-01/managedClusters.json
  - Microsoft.ContainerService/stable/2020-04-01/managedClusters.json
  - Microsoft.ContainerService/stable/2020-03-01/managedClusters.json
  - Microsoft.ContainerService/stable/2020-02-01/managedClusters.json
  - Microsoft.ContainerService/stable/2020-01-01/managedClusters.json
  - Microsoft.ContainerService/stable/2019-11-01/managedClusters.json
  - Microsoft.ContainerService/preview/2019-10-27-preview/openShiftManagedClusters.json
  - Microsoft.ContainerService/preview/2019-09-30/openShiftManagedClusters.json
  - Microsoft.ContainerService/stable/2019-08-01/managedClusters.json
  - Microsoft.ContainerService/stable/2019-10-01/managedClusters.json
  - Microsoft.ContainerService/stable/2019-06-01/location.json
  - Microsoft.ContainerService/stable/2019-06-01/managedClusters.json
  - Microsoft.ContainerService/stable/2019-04-01/managedClusters.json
  - Microsoft.ContainerService/stable/2019-04-01/location.json
  - Microsoft.ContainerService/preview/2018-09-30-preview/openShiftManagedClusters.json
  - Microsoft.ContainerService/stable/2019-02-01/managedClusters.json
  - Microsoft.ContainerService/stable/2017-09-30/location.json
  - Microsoft.ContainerService/preview/2018-08-01-preview/managedClusters.json
  - Microsoft.ContainerService/stable/2018-03-31/managedClusters.json
  - Microsoft.ContainerService/stable/2017-08-31/managedClusters.json
  - Microsoft.ContainerService/stable/2017-01-31/containerService.json
  - Microsoft.ContainerService/stable/2016-09-30/containerService.json
  - Microsoft.ContainerService/stable/2016-03-30/containerService.json

```