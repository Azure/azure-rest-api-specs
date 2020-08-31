## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.StorageCache/stable/2020-03-01/storagecache.json
  - Microsoft.StorageCache/stable/2019-11-01/storagecache.json
  - Microsoft.StorageCache/preview/2019-08-01-preview/storagecache.json

```