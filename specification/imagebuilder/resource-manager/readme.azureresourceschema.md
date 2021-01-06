## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-virtualmachineimages-2020-02-14
  - tag: schema-virtualmachineimages-2019-05-01-preview
  - tag: schema-virtualmachineimages-2019-02-01-preview
  - tag: schema-virtualmachineimages-2018-02-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-virtualmachineimages-2020-02-14 and azureresourceschema

``` yaml $(tag) == 'schema-virtualmachineimages-2020-02-14' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.VirtualMachineImages/stable/2020-02-14/imagebuilder.json

```

### Tag: schema-virtualmachineimages-2019-05-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-virtualmachineimages-2019-05-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.VirtualMachineImages/preview/2019-05-01-preview/imagebuilder.json

```

### Tag: schema-virtualmachineimages-2019-02-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-virtualmachineimages-2019-02-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.VirtualMachineImages/preview/2019-02-01-preview/imagebuilder.json

```

### Tag: schema-virtualmachineimages-2018-02-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-virtualmachineimages-2018-02-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.VirtualMachineImages/preview/2018-02-01-preview/imagebuilder.json

```
