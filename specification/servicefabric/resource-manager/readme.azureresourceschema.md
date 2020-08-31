## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.ServiceFabric/stable/2020-03-01/cluster.json
  - Microsoft.ServiceFabric/stable/2020-03-01/application.json
  - Microsoft.ServiceFabric/preview/2020-01-01-preview/managedcluster.json
  - Microsoft.ServiceFabric/preview/2020-01-01-preview/nodetype.json
  - Microsoft.ServiceFabric/preview/2019-11-01-preview/cluster.json
  - Microsoft.ServiceFabric/preview/2019-11-01-preview/application.json
  - Microsoft.ServiceFabric/preview/2019-06-01-preview/cluster.json
  - Microsoft.ServiceFabric/preview/2019-06-01-preview/application.json
  - Microsoft.ServiceFabric/stable/2019-03-01/cluster.json
  - Microsoft.ServiceFabric/stable/2019-03-01/application.json
  - Microsoft.ServiceFabric/preview/2019-03-01-preview/cluster.json
  - Microsoft.ServiceFabric/preview/2019-03-01-preview/application.json
  - Microsoft.ServiceFabric/stable/2018-02-01/cluster.json
  - Microsoft.ServiceFabric/preview/2017-07-01-preview/application.json
  - Microsoft.ServiceFabric/preview/2017-07-01-preview/servicefabric.json
  - Microsoft.ServiceFabric/stable/2016-09-01/servicefabric.json

```