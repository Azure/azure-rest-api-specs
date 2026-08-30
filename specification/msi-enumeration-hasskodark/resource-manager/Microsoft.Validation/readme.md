# Azure SDK MSI Enumeration Validation

## Basic Information
``` yaml
openapi-type: arm
tag: package-2024-01-01
```

### Tag: package-2024-01-01
``` yaml $(tag) == 'package-2024-01-01'
input-file:
  - stable/2024-01-01/openapi.json
```

## swagger-to-sdk
``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
```

## Python
``` yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  package-name: azure-mgmt-msi-enum-clean
  package-version: 1.0.0b1
  no-namespace-folders: true
  output-folder: sdk/msienumeration/azure-mgmt-msi-enum-clean
  clear-output-folder: true
```
