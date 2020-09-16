## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-netapp-2020-06-01
  - tag: schema-netapp-2020-02-01
  - tag: schema-netapp-2019-11-01
  - tag: schema-netapp-2019-10-01
  - tag: schema-netapp-2019-08-01
  - tag: schema-netapp-2019-07-01
  - tag: schema-netapp-2019-06-01
  - tag: schema-netapp-2019-05-01
  - tag: schema-netapp-2017-08-15

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-netapp-2020-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-netapp-2020-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.NetApp/stable/2020-06-01/netapp.json

```

### Tag: schema-netapp-2020-02-01 and azureresourceschema

``` yaml $(tag) == 'schema-netapp-2020-02-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.NetApp/stable/2020-02-01/netapp.json

```

### Tag: schema-netapp-2019-11-01 and azureresourceschema

``` yaml $(tag) == 'schema-netapp-2019-11-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.NetApp/stable/2019-11-01/netapp.json

```

### Tag: schema-netapp-2019-10-01 and azureresourceschema

``` yaml $(tag) == 'schema-netapp-2019-10-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.NetApp/stable/2019-10-01/netapp.json

```

### Tag: schema-netapp-2019-08-01 and azureresourceschema

``` yaml $(tag) == 'schema-netapp-2019-08-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.NetApp/stable/2019-08-01/netapp.json

```

### Tag: schema-netapp-2019-07-01 and azureresourceschema

``` yaml $(tag) == 'schema-netapp-2019-07-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.NetApp/stable/2019-07-01/netapp.json

```

### Tag: schema-netapp-2019-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-netapp-2019-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.NetApp/stable/2019-06-01/netapp.json

```

### Tag: schema-netapp-2019-05-01 and azureresourceschema

``` yaml $(tag) == 'schema-netapp-2019-05-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.NetApp/stable/2019-05-01/netapp.json

```

### Tag: schema-netapp-2017-08-15 and azureresourceschema

``` yaml $(tag) == 'schema-netapp-2017-08-15' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.NetApp/preview/2017-08-15/netapp.json

```
