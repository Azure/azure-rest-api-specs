## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-hybridcompute-2020-08-15-preview
  - tag: schema-hybridcompute-2020-08-02
  - tag: schema-hybridcompute-2020-07-30-preview
  - tag: schema-hybridcompute-2019-12-12
  - tag: schema-hybridcompute-2019-08-02
  - tag: schema-hybridcompute-2019-03-18

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-hybridcompute-2020-08-15-preview and azureresourceschema

``` yaml $(tag) == 'schema-hybridcompute-2020-08-15-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.HybridCompute/preview/2020-08-15-preview/HybridCompute.json
  - Microsoft.HybridCompute/preview/2020-08-15-preview/privateLinkScopes.json

```

### Tag: schema-hybridcompute-2020-08-02 and azureresourceschema

``` yaml $(tag) == 'schema-hybridcompute-2020-08-02' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.HybridCompute/stable/2020-08-02/HybridCompute.json

```

### Tag: schema-hybridcompute-2020-07-30-preview and azureresourceschema

``` yaml $(tag) == 'schema-hybridcompute-2020-07-30-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.HybridCompute/preview/2020-07-30-preview/HybridCompute.json

```

### Tag: schema-hybridcompute-2019-12-12 and azureresourceschema

``` yaml $(tag) == 'schema-hybridcompute-2019-12-12' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.HybridCompute/stable/2019-12-12/HybridCompute.json

```

### Tag: schema-hybridcompute-2019-08-02 and azureresourceschema

``` yaml $(tag) == 'schema-hybridcompute-2019-08-02' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.HybridCompute/preview/2019-08-02/HybridCompute.json

```

### Tag: schema-hybridcompute-2019-03-18 and azureresourceschema

``` yaml $(tag) == 'schema-hybridcompute-2019-03-18' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.HybridCompute/preview/2019-03-18/HybridCompute.json

```
