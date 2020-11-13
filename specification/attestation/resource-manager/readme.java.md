## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
namespace: com.microsoft.azure.management.attestation
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-attestation
```

### Java multi-api

```yaml $(java) && $(multiapi)
batch:
  - tag: profile-2020-10-01
```

### Tag: profile-2020-09-01 and java

These settings apply only when `--tag=profile-2020-10-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'profile--2020-10-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.attestation.v2019_09_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/attestation/mgmt-v2020_10_01
regenerate-manager: true
generate-interface: true
```

### Tag: profile-2020-10-01

These settings apply only when `--tag=profile-2020-10-01` is specified on the command line.
Creating this tag to pick proper resources from the hybrid profile.

``` yaml $(tag) == 'profile-20-10-01'
input-file:
- Microsoft.Attestation/stable/2020-10-01/attestation.json
```
