## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.OffAzure/stable/2020-07-07/migrate.json
  - Microsoft.Migrate/stable/2018-02-02/migrate.json
  - Microsoft.Migrate/stable/2019-10-01/migrate.json
  - Microsoft.OffAzure/stable/2020-01-01/migrate.json

```