## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-guestconfiguration-2020-06-25
  - tag: schema-guestconfiguration-2018-11-20
  - tag: schema-guestconfiguration-2018-06-30-preview
  - tag: schema-guestconfiguration-2018-01-20-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-guestconfiguration-2020-06-25 and azureresourceschema

``` yaml $(tag) == 'schema-guestconfiguration-2020-06-25' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.GuestConfiguration/stable/2020-06-25/guestconfiguration.json

```

### Tag: schema-guestconfiguration-2018-11-20 and azureresourceschema

``` yaml $(tag) == 'schema-guestconfiguration-2018-11-20' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.GuestConfiguration/stable/2018-11-20/guestconfiguration.json

```

### Tag: schema-guestconfiguration-2018-06-30-preview and azureresourceschema

``` yaml $(tag) == 'schema-guestconfiguration-2018-06-30-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.GuestConfiguration/preview/2018-06-30-preview/guestconfiguration.json

```

### Tag: schema-guestconfiguration-2018-01-20-preview and azureresourceschema

``` yaml $(tag) == 'schema-guestconfiguration-2018-01-20-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.GuestConfiguration/preview/2018-01-20-preview/guestconfiguration.json

```
