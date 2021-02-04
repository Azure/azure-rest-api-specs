## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-kubernetes-2020-01-01-preview
  - tag: schema-kubernetes-2021-04-01-preview
  - tag: schema-kubernetes-2021-03-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-kubernetes-2020-01-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-kubernetes-2020-01-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Kubernetes/preview/2020-01-01-preview/connectedClusters.json

```
### Tag: schema-kubernetes-2021-04-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-kubernetes-2021-04-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Kubernetes/preview/2021-04-01-preview/connectedClusters.json

```
### Tag: schema-kubernetes-2021-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-kubernetes-2021-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Kubernetes/stable/2021-03-01/connectedClusters.json

```
