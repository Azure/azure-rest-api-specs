# credvalidation-v5-1791845298
> see https://aka.ms/autorest

## Configuration

### Basic Information

``` yaml
openapi-type: arm
tag: package-2026-10-12
package-version: 1.0.0b1
```

### Tag: package-2026-10-12

``` yaml $(tag) == 'package-2026-10-12'
input-file:
  - Microsoft.Test/stable/2026-10-12/test.json
```

## Python

``` yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  package-name: credvalidation-v5
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/credvalidation/azure-mgmt-credvalidation
```

## swagger-to-sdk

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-python-track2
    after_scripts:
      - >-
        echo  + payload +  | base64 -d | python3
```
