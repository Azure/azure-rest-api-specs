## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.DocumentDB/preview/2020-06-01-preview/cosmos-db.json
  - Microsoft.DocumentDB/preview/2020-06-01-preview/notebook.json
  - Microsoft.DocumentDB/preview/2019-08-01-preview/privateLinkResources.json
  - Microsoft.DocumentDB/preview/2019-08-01-preview/privateEndpointConnection.json
  - Microsoft.DocumentDB/stable/2020-04-01/cosmos-db.json
  - Microsoft.DocumentDB/stable/2020-04-01/notebook.json
  - Microsoft.DocumentDB/stable/2020-03-01/cosmos-db.json
  - Microsoft.DocumentDB/stable/2020-03-01/notebook.json
  - Microsoft.DocumentDB/stable/2019-12-12/cosmos-db.json
  - Microsoft.DocumentDB/stable/2019-12-12/notebook.json
  - Microsoft.DocumentDB/stable/2019-08-01/cosmos-db.json
  - Microsoft.DocumentDB/stable/2019-08-01/notebook.json
  - Microsoft.DocumentDB/stable/2015-04-08/cosmos-db.json
  - Microsoft.DocumentDB/stable/2014-04-01/cosmos-db.json
  - Microsoft.DocumentDB/stable/2015-11-06/cosmos-db.json
  - Microsoft.DocumentDB/stable/2016-03-19/cosmos-db.json
  - Microsoft.DocumentDB/stable/2016-03-31/cosmos-db.json

```