## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-cdn-2020-04-15
  - tag: schema-cdn-2019-12-31
  - tag: schema-cdn-2019-06-15-preview
  - tag: schema-cdn-2019-06-15
  - tag: schema-cdn-2019-04-15
  - tag: schema-cdn-2017-10-12
  - tag: schema-cdn-2017-04-02
  - tag: schema-cdn-2016-10-02
  - tag: schema-cdn-2016-04-02
  - tag: schema-cdn-2015-06-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-cdn-2020-04-15 and azureresourceschema

``` yaml $(tag) == 'schema-cdn-2020-04-15' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Cdn/stable/2020-04-15/cdn.json
  - Microsoft.Cdn/stable/2020-04-15/cdnwebapplicationfirewall.json

```

### Tag: schema-cdn-2019-12-31 and azureresourceschema

``` yaml $(tag) == 'schema-cdn-2019-12-31' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Cdn/stable/2019-12-31/cdn.json

```

### Tag: schema-cdn-2019-06-15-preview and azureresourceschema

``` yaml $(tag) == 'schema-cdn-2019-06-15-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Cdn/preview/2019-06-15-preview/cdn.json
  - Microsoft.Cdn/preview/2019-06-15-preview/cdnwebapplicationfirewall.json

```

### Tag: schema-cdn-2019-06-15 and azureresourceschema

``` yaml $(tag) == 'schema-cdn-2019-06-15' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Cdn/stable/2019-06-15/cdn.json
  - Microsoft.Cdn/stable/2019-06-15/cdnwebapplicationfirewall.json

```

### Tag: schema-cdn-2019-04-15 and azureresourceschema

``` yaml $(tag) == 'schema-cdn-2019-04-15' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Cdn/stable/2019-04-15/cdn.json

```

### Tag: schema-cdn-2017-10-12 and azureresourceschema

``` yaml $(tag) == 'schema-cdn-2017-10-12' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Cdn/stable/2017-10-12/cdn.json

```

### Tag: schema-cdn-2017-04-02 and azureresourceschema

``` yaml $(tag) == 'schema-cdn-2017-04-02' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Cdn/stable/2017-04-02/cdn.json

```

### Tag: schema-cdn-2016-10-02 and azureresourceschema

``` yaml $(tag) == 'schema-cdn-2016-10-02' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Cdn/stable/2016-10-02/cdn.json

```

### Tag: schema-cdn-2016-04-02 and azureresourceschema

``` yaml $(tag) == 'schema-cdn-2016-04-02' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Cdn/stable/2016-04-02/cdn.json

```

### Tag: schema-cdn-2015-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-cdn-2015-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Cdn/stable/2015-06-01/cdn.json

```
