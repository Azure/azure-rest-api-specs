## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-attestation-2018-09-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-attestation-2018-09-01 and azureresourceschema

``` yaml $(tag) == 'schema-attestation-2018-09-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Attestation/stable/2018-09-01/attestation.json
  - Microsoft.Attestation/stable/2020-10-01/attestation.json

```
