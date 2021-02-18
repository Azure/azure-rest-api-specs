## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-peering-2020-04-01
  - tag: schema-peering-2020-01-01-preview
  - tag: schema-peering-2019-09-01-preview
  - tag: schema-peering-2019-08-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-peering-2020-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-peering-2020-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Peering/stable/2020-04-01/peering.json

```

### Tag: schema-peering-2020-01-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-peering-2020-01-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Peering/preview/2020-01-01-preview/peering.json

```

### Tag: schema-peering-2019-09-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-peering-2019-09-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Peering/preview/2019-09-01-preview/peering.json

```

### Tag: schema-peering-2019-08-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-peering-2019-08-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Peering/preview/2019-08-01-preview/peering.json

```
