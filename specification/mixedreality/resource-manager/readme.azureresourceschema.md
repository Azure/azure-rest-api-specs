## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-mixedreality-2020-05-01
  - tag: schema-mixedreality-2020-04-06-preview
  - tag: schema-mixedreality-2019-12-02-preview
  - tag: schema-mixedreality-2019-02-28-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-mixedreality-2020-05-01 and azureresourceschema

``` yaml $(tag) == 'schema-mixedreality-2020-05-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.MixedReality/stable/2020-05-01/proxy.json
  - Microsoft.MixedReality/stable/2020-05-01/spatial-anchors.json

```

### Tag: schema-mixedreality-2020-04-06-preview and azureresourceschema

``` yaml $(tag) == 'schema-mixedreality-2020-04-06-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.MixedReality/preview/2020-04-06-preview/remote-rendering.json
  - Microsoft.MixedReality/preview/2020-04-06-preview/proxy.json

```

### Tag: schema-mixedreality-2019-12-02-preview and azureresourceschema

``` yaml $(tag) == 'schema-mixedreality-2019-12-02-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.MixedReality/preview/2019-12-02-preview/proxy.json
  - Microsoft.MixedReality/preview/2019-12-02-preview/remote-rendering.json
  - Microsoft.MixedReality/preview/2019-12-02-preview/spatial-anchors.json

```

### Tag: schema-mixedreality-2019-02-28-preview and azureresourceschema

``` yaml $(tag) == 'schema-mixedreality-2019-02-28-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.MixedReality/preview/2019-02-28-preview/mixedreality.json

```
