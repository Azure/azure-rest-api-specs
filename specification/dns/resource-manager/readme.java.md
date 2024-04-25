## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.dns
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-dns
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2017-10
  - tag: package-2016-04
```

### Tag: package-2017-10 and java

These settings apply only when `--tag=package-2017-10 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-10' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.dns.v2017_10_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/dns/mgmt-v2017_10_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2016-04 and java

These settings apply only when `--tag=package-2016-04 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2016-04' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.dns.v2016_04_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/dns/mgmt-v2016_04_01
regenerate-manager: true
generate-interface: true
```

### Tag: profile-hybrid-2019-03-01

These settings apply only when `--tag=profile-hybrid-2019-03-01` is specified on the command line.
Creating this tag to pick proper resources from the hybrid profile.

``` yaml $(tag) == 'profile-hybrid-2019-03-01'
input-file:
- Microsoft.Network/stable/2016-04-01/dns.json
```
