## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.StorageSync/stable/2020-03-01/storagesync.json
  - Microsoft.StorageSync/stable/2019-10-01/storagesync.json
  - Microsoft.StorageSync/stable/2019-06-01/storagesync.json
  - Microsoft.StorageSync/stable/2019-03-01/storagesync.json
  - Microsoft.StorageSync/stable/2019-02-01/storagesync.json
  - Microsoft.StorageSync/stable/2018-10-01/storagesync.json
  - Microsoft.StorageSync/stable/2018-07-01/storagesync.json
  - Microsoft.StorageSync/stable/2018-04-02/storagesync.json
  - Microsoft.StorageSync/preview/2017-06-05-preview/storagesync.json

```