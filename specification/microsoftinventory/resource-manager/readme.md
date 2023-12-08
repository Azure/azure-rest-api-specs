# microsoftinventory

> see https://aka.ms/autorest

This is the AutoRest configuration file for Microsoft.Inventory.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the microsoftinventory.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2024-01-01-preview
```

### Tag: package-preview-2024-01

These settings apply only when `--tag=package-preview-2024-01` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-01'
input-file:
  - Microsoft.Inventory/preview/2024-01-01-preview/microsoftinventory.json
  
suppressions:
  - code: OperationIdNounVerb
    reason: The operation id cannot be fixed as fixing it is resulting in typespec validation errors valid.
    where: $.paths["/providers/Microsoft.Inventory/locations/{location}/physicalAzureHosts/{azureHostName}"].get.operationId
  - code: OperationIdNounVerb
    reason: The operation id cannot be fixed as fixing it is resulting in typespec validation errors valid.
    where: $.paths["/providers/Microsoft.Inventory/locations/{location}/physicalClusters/{clusterName}"].get.operationId
  - code: OperationIdNounVerb
    reason: The operation id cannot be fixed as fixing it is resulting in typespec validation errors valid.
    where: $.paths["/providers/Microsoft.Inventory/locations/{location}/physicalDatacenters/{datacenterName}"].get.operationId    
```