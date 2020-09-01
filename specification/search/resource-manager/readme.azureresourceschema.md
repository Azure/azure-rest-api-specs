## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-search-2020-08-01-preview
  - tag: schema-search-2020-08-01
  - tag: schema-search-2020-03-13
  - tag: schema-search-2019-10-01-preview
  - tag: schema-search-2015-08-19
  - tag: schema-search-2015-02-28

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-search-2020-08-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-search-2020-08-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Search/preview/2020-08-01-preview/search.json

```

### Tag: schema-search-2020-08-01 and azureresourceschema

``` yaml $(tag) == 'schema-search-2020-08-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Search/stable/2020-08-01/search.json

```

### Tag: schema-search-2020-03-13 and azureresourceschema

``` yaml $(tag) == 'schema-search-2020-03-13' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Search/stable/2020-03-13/search.json

```

### Tag: schema-search-2019-10-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-search-2019-10-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Search/preview/2019-10-01-preview/search.json

```

### Tag: schema-search-2015-08-19 and azureresourceschema

``` yaml $(tag) == 'schema-search-2015-08-19' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Search/stable/2015-08-19/search.json

```

### Tag: schema-search-2015-02-28 and azureresourceschema

``` yaml $(tag) == 'schema-search-2015-02-28' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Search/stable/2015-02-28/search.json

```
