## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.Cache/preview/2019-07-01/redis.json
  - Microsoft.Cache/stable/2018-03-01/redis.json
  - Microsoft.Cache/stable/2017-10-01/redis.json
  - Microsoft.Cache/stable/2017-02-01/redis.json
  - Microsoft.Cache/stable/2016-04-01/redis.json
  - Microsoft.Cache/stable/2015-08-01/redis.json

```