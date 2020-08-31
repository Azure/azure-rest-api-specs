## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.ContainerInstance/stable/2019-12-01/containerInstance.json
  - Microsoft.ContainerInstance/stable/2018-10-01/containerInstance.json
  - Microsoft.ContainerInstance/stable/2018-09-01/containerInstance.json
  - Microsoft.ContainerInstance/stable/2018-06-01/containerInstance.json
  - Microsoft.ContainerInstance/stable/2018-04-01/containerInstance.json
  - Microsoft.ContainerInstance/preview/2018-02-01-preview/containerInstance.json
  - Microsoft.ContainerInstance/preview/2017-12-01-preview/containerInstance.json
  - Microsoft.ContainerInstance/preview/2017-10-01-preview/containerInstance.json
  - Microsoft.ContainerInstance/preview/2017-08-01-preview/containerInstance.json

```