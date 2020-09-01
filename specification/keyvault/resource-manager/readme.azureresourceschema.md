## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-keyvault-2020-04-01-preview
  - tag: schema-keyvault-2019-09-01
  - tag: schema-keyvault-2018-02-14-preview
  - tag: schema-keyvault-2018-02-14
  - tag: schema-keyvault-2016-10-01
  - tag: schema-keyvault-2015-06-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-keyvault-2020-04-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-keyvault-2020-04-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.KeyVault/preview/2020-04-01-preview/managedHsm.json
  - Microsoft.KeyVault/preview/2020-04-01-preview/keyvault.json
  - Microsoft.KeyVault/preview/2020-04-01-preview/providers.json
  - Microsoft.KeyVault/preview/2020-04-01-preview/secrets.json

```

### Tag: schema-keyvault-2019-09-01 and azureresourceschema

``` yaml $(tag) == 'schema-keyvault-2019-09-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.KeyVault/stable/2019-09-01/keyvault.json
  - Microsoft.KeyVault/stable/2019-09-01/providers.json

```

### Tag: schema-keyvault-2018-02-14-preview and azureresourceschema

``` yaml $(tag) == 'schema-keyvault-2018-02-14-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.KeyVault/preview/2018-02-14-preview/keyvault.json
  - Microsoft.KeyVault/preview/2018-02-14-preview/providers.json

```

### Tag: schema-keyvault-2018-02-14 and azureresourceschema

``` yaml $(tag) == 'schema-keyvault-2018-02-14' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.KeyVault/stable/2018-02-14/keyvault.json
  - Microsoft.KeyVault/stable/2018-02-14/providers.json

```

### Tag: schema-keyvault-2016-10-01 and azureresourceschema

``` yaml $(tag) == 'schema-keyvault-2016-10-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.KeyVault/stable/2016-10-01/keyvault.json
  - Microsoft.KeyVault/stable/2016-10-01/providers.json

```

### Tag: schema-keyvault-2015-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-keyvault-2015-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.KeyVault/stable/2015-06-01/keyvault.json

```
