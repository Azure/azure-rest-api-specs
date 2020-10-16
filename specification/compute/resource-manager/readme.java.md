## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.compute
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-compute
```

### Java multi-api

```yaml $(java) && $(multiapi)
batch:
  - tag: package-2020-06-01
  - tag: package-2019-07  
  - tag: package-disks-2018-04
  - tag: package-compute-only-2017-12
  - tag: package-skus-2017-09
  - tag: package-compute-2017-03
```

### Tag: package-2020-06-01 and java

These settings apply only when `--tag=package-2020-06-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-06-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.compute.v2020_06_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/compute/mgmt-v2020_06_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-07 and java

These settings apply only when `--tag=package-2019-07 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-07' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.compute.v2019_07_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/compute/mgmt-v2019_07_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-disks-2018-04 and java

These settings apply only when `--tag=package-disks-2018-04 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-disks-2018-04' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.compute.v2018_04_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/compute/mgmt-v2018_04_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-compute-only-2017-12 and java

These settings apply only when `--tag=package-compute-only-2017-12 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-compute-only-2017-12' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.compute.v2017_12_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/compute/mgmt-v2017_12_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-skus-2017-09 and java

These settings apply only when `--tag=package-skus-2017-09 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-skus-2017-09' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.compute.v2017_09_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/compute/mgmt-v2017_09_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-compute-2017-03 and java

These settings apply only when `--tag=package-compute-2017-03 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-compute-2017-03' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.compute.v2017_03_30
  output-folder: $(azure-libraries-for-java-folder)/sdk/compute/mgmt-v2017_03_30
regenerate-manager: true
generate-interface: true
```

### Tag: profile-hybrid-2019-03-01

These settings apply only when `--tag=profile-hybrid-2019-03-01` is specified on the command line.
Creating this tag to pick proper resources from the hybrid profile.

``` yaml $(tag) == 'profile-hybrid-2019-03-01'
input-file:
- Microsoft.Compute/stable/2017-12-01/compute.json
- Microsoft.Compute/stable/2017-03-30/disk.json
```