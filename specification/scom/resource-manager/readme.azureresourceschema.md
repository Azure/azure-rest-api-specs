## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-scom-2021-06-30-preview
  - tag: schema-scom-2022-04-30-preview
  - tag: schema-scom-2022-09-13-preview
  - tag: schema-scom-2023-07-07-preview
  - tag: schema-scom-2023-10-30
  - tag: schema-scom-2024-01-01-preview
  - tag: schema-scom-2024-06-05-preview
  - tag: schema-scom-2024-07-15-preview
  - tag: schema-scom-2024-12-10-preview
  - tag: schema-scom-2025-02-03-preview
  
```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-scom-2021-06-30-preview and azureresourceschema

``` yaml $(tag) == 'schema-scom-2021-06-30-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Scom/preview/2021-06-30-preview/scom.json
  
```
### Tag: schema-scom-2022-04-30-preview and azureresourceschema

``` yaml $(tag) == 'schema-scom-2022-04-30-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Scom/preview/2022-04-30-preview/scom.json
  
```
### Tag: schema-scom-2022-09-13-preview and azureresourceschema

``` yaml $(tag) == 'schema-scom-2022-09-13-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Scom/preview/2022-09-13-preview/scom.json
  
```
### Tag: schema-scom-2023-07-07-preview and azureresourceschema

``` yaml $(tag) == 'schema-scom-2023-07-07-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Scom/preview/2023-07-07-preview/scom.json
  - Microsoft.Scom/preview/2023-07-07-preview/monitoredResources.json
  - Microsoft.Scom/preview/2023-07-07-preview/managedGateways.json
  - Microsoft.Scom/preview/2023-07-07-preview/commonTypes.json

```

``` yaml $(tag) == 'schema-scom-2023-10-30' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Scom/stable/2023-10-30/scom.json
  - Microsoft.Scom/stable/2023-10-30/monitoredResources.json
  - Microsoft.Scom/stable/2023-10-30/managedGateways.json
  - Microsoft.Scom/stable/2023-10-30/commonTypes.json

```

``` yaml $(tag) == 'schema-scom-2024-01-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Scom/preview/2024-01-01-preview/scom.json
  - Microsoft.Scom/preview/2024-01-01-preview/monitoredResources.json
  - Microsoft.Scom/preview/2024-01-01-preview/managedGateways.json
  - Microsoft.Scom/preview/2024-01-01-preview/commonTypes.json

```

``` yaml $(tag) == 'schema-scom-2024-06-05-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Scom/preview/2024-06-05-preview/scom.json
  - Microsoft.Scom/preview/2024-06-05-preview/monitoredResources.json
  - Microsoft.Scom/preview/2024-06-05-preview/managedGateways.json
  - Microsoft.Scom/preview/2024-06-05-preview/commonTypes.json

```

``` yaml $(tag) == 'schema-scom-2024-07-15-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Scom/preview/2024-07-15-preview/scom.json
  - Microsoft.Scom/preview/2024-07-15-preview/monitoredResources.json
  - Microsoft.Scom/preview/2024-07-15-preview/managedGateways.json
  - Microsoft.Scom/preview/2024-07-15-preview/commonTypes.json

```

``` yaml $(tag) == 'schema-scom-2024-12-10-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Scom/preview/2024-12-10-preview/scom.json
  - Microsoft.Scom/preview/2024-12-10-preview/monitoredResources.json
  - Microsoft.Scom/preview/2024-12-10-preview/managedGateways.json
  - Microsoft.Scom/preview/2024-12-10-preview/commonTypes.json

```

``` yaml $(tag) == 'schema-scom-2025-02-03-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Scom/preview/2025-02-03-preview/scom.json
  - Microsoft.Scom/preview/2025-02-03-preview/monitoredResources.json
  - Microsoft.Scom/preview/2025-02-03-preview/managedGateways.json
  - Microsoft.Scom/preview/2025-02-03-preview/commonTypes.json

```