## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-digitaltwins-2020-12-01
  - tag: schema-digitaltwins-2020-10-31
  - tag: schema-digitaltwins-2020-03-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-digitaltwins-2020-12-01 and azureresourceschema

``` yaml $(tag) == 'schema-digitaltwins-2020-12-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DigitalTwins/stable/2020-12-01/digitaltwins.json

```

### Tag: schema-digitaltwins-2020-10-31 and azureresourceschema

``` yaml $(tag) == 'schema-digitaltwins-2020-10-31' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DigitalTwins/stable/2020-10-31/digitaltwins.json

```

### Tag: schema-digitaltwins-2020-03-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-digitaltwins-2020-03-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DigitalTwins/preview/2020-03-01-preview/digitaltwins.json

```
