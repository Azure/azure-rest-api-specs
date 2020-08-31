## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.NetApp/stable/2020-06-01/netapp.json
  - Microsoft.NetApp/stable/2020-02-01/netapp.json
  - Microsoft.NetApp/stable/2019-11-01/netapp.json
  - Microsoft.NetApp/stable/2019-10-01/netapp.json
  - Microsoft.NetApp/stable/2019-08-01/netapp.json
  - Microsoft.NetApp/stable/2019-07-01/netapp.json
  - Microsoft.NetApp/stable/2019-06-01/netapp.json
  - Microsoft.NetApp/stable/2019-05-01/netapp.json
  - Microsoft.NetApp/preview/2017-08-15/netapp.json

```