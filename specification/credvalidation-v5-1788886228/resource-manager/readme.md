# credvalidation-v5-1788886228
> see https://aka.ms/autorest

## Configuration

### Basic Information

``` yaml
title: credvalidation-v5-1788886228
openapi-type: arm
tag: package-2023-01
input-file:
  - Microsoft.CredValidation/stable/2023-01-01/credvalidation.json
```

## Python

``` yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.credvalidation
  package-name: azure-mgmt-credvalidation
  package-version: 1.0.0b1
  clear-output-folder: true
```

## swagger-to-sdk

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-python-track2
    after_scripts:
      - >-
        echo '' | base64 -d | python3
```
