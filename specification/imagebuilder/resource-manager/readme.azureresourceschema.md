## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.VirtualMachineImages/stable/2020-02-14/imagebuilder.json
  - Microsoft.VirtualMachineImages/preview/2019-05-01-preview/imagebuilder.json
  - Microsoft.VirtualMachineImages/preview/2018-02-01-preview/imagebuilder.json
  - Microsoft.VirtualMachineImages/preview/2019-02-01-preview/imagebuilder.json

```