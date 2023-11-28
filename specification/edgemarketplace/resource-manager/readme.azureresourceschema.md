## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
<<<<<<< HEAD
  - tag: package-2023-04-01-preview
  - tag: package-2023-08-01
=======
  - tag: package-2023-08-01-preview
>>>>>>> 784f4a4080974c9270fedf1dd24d81223a70a8f4

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

<<<<<<< HEAD
### Tag: package-2023-04-01-preview and azureresourceschema

``` yaml $(tag) == '2023-04-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas```

### Tag: package-2023-08-01 and azureresourceschema

``` yaml $(tag) == '2023-08-01' && $(azureresourceschema)
=======
### Tag: package-2023-08-01-preview and azureresourceschema

``` yaml $(tag) == '2023-08-01-preview' && $(azureresourceschema)
>>>>>>> 784f4a4080974c9270fedf1dd24d81223a70a8f4
output-folder: $(azureresourceschema-folder)/schemas