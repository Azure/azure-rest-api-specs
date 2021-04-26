## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-healthbot-2020-12-08-preview
  - tag: schema-healthbot-2020-12-08
  - tag: schema-healthbot-2020-10-20-preview
  - tag: schema-healthbot-2020-10-20

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-healthbot-2020-12-08-preview and azureresourceschema

``` yaml $(tag) == 'schema-healthbot-2020-12-08-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.HealthBot/preview/2020-12-08-preview/healthbot.json

```

### Tag: schema-healthbot-2020-12-08 and azureresourceschema

``` yaml $(tag) == 'schema-healthbot-2020-12-08' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.HealthBot/stable/2020-12-08/healthbot.json

```

### Tag: schema-healthbot-2020-10-20-preview and azureresourceschema

``` yaml $(tag) == 'schema-healthbot-2020-10-20-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.HealthBot/preview/2020-10-20-preview/healthbot.json

```

### Tag: schema-healthbot-2020-10-20 and azureresourceschema

``` yaml $(tag) == 'schema-healthbot-2020-10-20' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.HealthBot/stable/2020-10-20/healthbot.json

```
