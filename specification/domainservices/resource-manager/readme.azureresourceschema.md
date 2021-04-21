## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-aad-2020-01-01
  - tag: schema-aad-2017-06-01
  - tag: schema-aad-2017-01-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-aad-2020-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-aad-2020-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AAD/stable/2020-01-01/domainservices.json
  - Microsoft.AAD/stable/2020-01-01/oucontainer.json

```

### Tag: schema-aad-2017-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-aad-2017-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AAD/stable/2017-06-01/domainservices.json
  - Microsoft.AAD/stable/2017-06-01/oucontainer.json

```

### Tag: schema-aad-2017-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-aad-2017-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AAD/stable/2017-01-01/domainservices.json

```
