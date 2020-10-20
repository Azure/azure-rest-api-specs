## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
namespace: com.microsoft.azure.management.keyvault
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-keyvault
```

### Java multi-api

```yaml $(java) && $(multiapi)
batch:
  - tag: profile-hybrid-2020-09-01
  - tag: package-2018-02-14-preview
  - tag: package-2016-10
  - tag: package-2015-06
```

### Tag: profile-hybrid-2020-09-01 and java

These settings apply only when `--tag=profile-hybrid-2020-09-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'profile-hybrid-2020-09-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.keyvault.v2019_09_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/keyvault/mgmt-v2019_09_01
regenerate-manager: true
generate-interface: true
directive:
  from: keyvault.json
  where: $.paths["/subscriptions/{subscriptionId}/resources"].get
  transform: $['operationId'] = 'Vaults_ListResource'
```

### Tag: package-2018-02-14-preview and java

These settings apply only when `--tag=package-2018-02-14-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-02-14-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.keyvault.v2018_02_14_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/keyvault/mgmt-v2018_02_14_preview
regenerate-manager: true
generate-interface: true
directive:
  from: keyvault.json
  where: $.paths["/subscriptions/{subscriptionId}/resources"].get
  transform: $['operationId'] = 'Vaults_ListResource'
```

### Tag: package-2016-10 and java

These settings apply only when `--tag=package-2016-10 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2016-10' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.keyvault.v2016_10_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/keyvault/mgmt-v2016_10_01
regenerate-manager: true
generate-interface: true
directive:
  from: keyvault.json
  where: $.paths["/subscriptions/{subscriptionId}/resources"].get
  transform: $['operationId'] = 'Vaults_ListResource'
```

### Tag: package-2016-10 and java

These settings apply only when `--tag=package-2016-10 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2016-10' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.keyvault.v2016_10_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/keyvault/mgmt-v2016_10_01
regenerate-manager: true
generate-interface: true
directive:
  from: keyvault.json
  where: $.paths["/subscriptions/{subscriptionId}/resources"].get
  transform: $['operationId'] = 'Vaults_ListResource'
```

### Tag: package-2015-06 and java

These settings apply only when `--tag=package-2015-06 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2015-06' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.keyvault.v2015_06_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/keyvault/mgmt-v2015_06_01
regenerate-manager: true
generate-interface: true
```

### Tag: profile-hybrid-2019-03-01

These settings apply only when `--tag=profile-hybrid-2019-03-01` is specified on the command line.
Creating this tag to pick proper resources from the hybrid profile.

``` yaml $(tag) == 'profile-hybrid-2019-03-01'
input-file:
- Microsoft.KeyVault/stable/2016-10-01/providers.json
- Microsoft.KeyVault/stable/2016-10-01/keyvault.json
- Microsoft.KeyVault/stable/2016-10-01/secrets.json
```

### Tag: profile-hybrid-2020-09-01

These settings apply only when `--tag=profile-hybrid-2020-09-01` is specified on the command line.
Creating this tag to pick proper resources from the hybrid profile.

``` yaml $(tag) == 'profile-hybrid-2020-09-01'
input-file:
- Microsoft.KeyVault/stable/2019-09-01/providers.json
- Microsoft.KeyVault/stable/2019-09-01/keyvault.json
- Microsoft.KeyVault/stable/2019-09-01/secrets.json
```
