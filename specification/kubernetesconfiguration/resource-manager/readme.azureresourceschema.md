## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-kubernetesconfiguration-2021-03-01
  - tag: schema-kubernetesconfiguration-2020-10-01-preview
  - tag: schema-kubernetesconfiguration-2020-07-01-preview
  - tag: schema-kubernetesconfiguration-2019-11-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-kubernetesconfiguration-2021-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-kubernetesconfiguration-2021-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.KubernetesConfiguration/stable/2021-03-01/kubernetesconfiguration.json

```

### Tag: schema-kubernetesconfiguration-2020-10-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-kubernetesconfiguration-2020-10-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.KubernetesConfiguration/preview/2020-10-01-preview/kubernetesconfiguration.json

```

### Tag: schema-kubernetesconfiguration-2020-07-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-kubernetesconfiguration-2020-07-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.KubernetesConfiguration/preview/2020-07-01-preview/kubernetesconfiguration.json
  - Microsoft.KubernetesConfiguration/preview/2020-07-01-preview/extensions.json

```

### Tag: schema-kubernetesconfiguration-2019-11-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-kubernetesconfiguration-2019-11-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.KubernetesConfiguration/preview/2019-11-01-preview/kubernetesconfiguration.json

```
