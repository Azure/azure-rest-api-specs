## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.Compute/stable/2020-06-01/compute.json
  - Microsoft.Compute/stable/2020-06-01/runCommands.json
  - Microsoft.Compute/stable/2019-04-01/skus.json
  - Microsoft.Compute/stable/2020-06-30/disk.json
  - Microsoft.Compute/stable/2019-12-01/gallery.json
  - Microsoft.ContainerService/stable/2017-01-31/containerService.json
  - Microsoft.Compute/stable/2020-05-01/disk.json
  - Microsoft.Compute/stable/2019-12-01/compute.json
  - Microsoft.Compute/stable/2019-12-01/runCommands.json
  - Microsoft.Compute/stable/2019-11-01/disk.json
  - Microsoft.Compute/stable/2019-07-01/compute.json
  - Microsoft.Compute/stable/2019-07-01/runCommands.json
  - Microsoft.Compute/stable/2019-07-01/gallery.json
  - Microsoft.Compute/stable/2019-07-01/disk.json
  - Microsoft.Compute/stable/2019-03-01/compute.json
  - Microsoft.Compute/stable/2019-03-01/runCommands.json
  - Microsoft.Compute/stable/2019-03-01/disk.json
  - Microsoft.Compute/stable/2019-03-01/gallery.json
  - Microsoft.Compute/stable/2018-10-01/compute.json
  - Microsoft.Compute/stable/2018-10-01/runCommands.json
  - Microsoft.Compute/stable/2017-09-01/skus.json
  - Microsoft.Compute/stable/2018-09-30/disk.json
  - Microsoft.Compute/stable/2018-06-01/gallery.json
  - Microsoft.Compute/stable/2018-06-01/disk.json
  - Microsoft.Compute/stable/2018-06-01/compute.json
  - Microsoft.Compute/stable/2018-06-01/runCommands.json
  - Microsoft.Compute/stable/2018-04-01/compute.json
  - Microsoft.Compute/stable/2018-04-01/runCommands.json
  - Microsoft.Compute/stable/2018-04-01/disk.json
  - Microsoft.Compute/stable/2017-12-01/compute.json
  - Microsoft.Compute/stable/2017-12-01/runCommands.json
  - Microsoft.Compute/stable/2017-03-30/disk.json
  - Microsoft.Compute/stable/2017-03-30/compute.json
  - Microsoft.Compute/stable/2017-03-30/runCommands.json
  - Microsoft.ContainerService/stable/2016-09-30/containerService.json
  - Microsoft.Compute/preview/2016-04-30-preview/compute.json
  - Microsoft.Compute/preview/2016-04-30-preview/disk.json
  - Microsoft.Compute/stable/2016-03-30/compute.json
  - Microsoft.ContainerService/stable/2016-03-30/containerService.json
  - Microsoft.ContainerService/preview/2015-11-01-preview/containerService.json
  - Microsoft.Compute/stable/2015-06-15/compute.json

```