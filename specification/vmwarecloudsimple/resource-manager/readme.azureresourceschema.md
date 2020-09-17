## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-vmwarecloudsimple-2019-04-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-vmwarecloudsimple-2019-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-vmwarecloudsimple-2019-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.VMwareCloudSimple/stable/2019-04-01/vmwarecloudsimple.json

```
