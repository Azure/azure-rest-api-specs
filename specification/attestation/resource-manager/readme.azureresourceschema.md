## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-attestation-2020-10-01
  - tag: schema-attestation-2018-09-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-attestation-2020-10-01 and azureresourceschema

``` yaml $(tag) == 'schema-attestation-2020-10-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Attestation/stable/2020-10-01/attestation.json

```

### Tag: schema-attestation-2018-09-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-attestation-2018-09-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Attestation/stable/2018-09-01-preview/attestation.json

```
