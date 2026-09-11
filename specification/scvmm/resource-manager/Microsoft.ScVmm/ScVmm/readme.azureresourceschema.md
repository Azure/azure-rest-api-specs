## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-scvmm-2020-06-05-preview
  - tag: schema-scvmm-2022-05-21-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-scvmm-2020-06-05-preview and azureresourceschema

``` yaml $(tag) == 'schema-scvmm-2020-06-05-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.SCVMM/preview/2020-06-05-preview/scvmm.json

```

### Tag: schema-scvmm-2022-05-21-preview and azureresourceschema

``` yaml $(tag) == 'schema-scvmm-2022-05-21-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.SCVMM/preview/2022-05-21-preview/scvmm.json

```