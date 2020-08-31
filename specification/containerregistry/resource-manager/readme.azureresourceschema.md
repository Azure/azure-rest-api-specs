## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.ContainerRegistry/preview/2019-12-01-preview/containerregistry.json
  - Microsoft.ContainerRegistry/preview/2019-06-01-preview/containerregistry_build.json
  - Microsoft.ContainerRegistry/preview/2019-05-01-preview/containerregistry_scopemap.json
  - Microsoft.ContainerRegistry/stable/2019-05-01/containerregistry.json
  - Microsoft.ContainerRegistry/stable/2019-04-01/containerregistry_build.json
  - Microsoft.ContainerRegistry/stable/2017-10-01/containerregistry.json
  - Microsoft.ContainerRegistry/stable/2018-09-01/containerregistry_build.json
  - Microsoft.ContainerRegistry/preview/2018-02-01-preview/containerregistry_build.json
  - Microsoft.ContainerRegistry/preview/2017-06-01-preview/containerregistry.json
  - Microsoft.ContainerRegistry/stable/2017-03-01/containerregistry.json
  - Microsoft.ContainerRegistry/preview/2016-06-27-preview/containerregistry.json

```