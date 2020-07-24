## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.netapp
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-netapp
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-netapp-2020-02-01
  - tag: package-netapp-2019-11-01
  - tag: package-netapp-2019-10-01
  - tag: package-netapp-2019-08-01
  - tag: package-netapp-2019-07-01
  - tag: package-netapp-2019-06-01
  - tag: package-netapp-2019-05-01
  - tag: package-2017-08-15
```
### Tag: package-netapp-2020-02-01 and java

These settings apply only when `--tag=package-netapp-2020-02-01 --java` is specified on the command line.
Please also specify the `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-netapp-2020-02-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.netapp.v2020_02_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/netapp/mgmt-v2020_02_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-netapp-2019-11-01 and java

These settings apply only when `--tag=package-netapp-2019-11-01 --java` is specified on the command line.
Please also specify the `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-netapp-2019-11-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.netapp.v2019_11_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/netapp/mgmt-v2019_11_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-netapp-2019-10-01 and java

These settings apply only when `--tag=package-netapp-2019-10-01 --java` is specified on the command line.
Please also specify the `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-netapp-2019-10-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.netapp.v2019_10_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/netapp/mgmt-v2019_10_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-netapp-2019-08-01 and java

These settings apply only when `--tag=package-netapp-2019-08-01 --java` is specified on the command line.
Please also specify the `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-netapp-2019-08-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.netapp.v2019_08_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/netapp/mgmt-v2019_08_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-netapp-2019-07-01 and java

These settings apply only when `--tag=package-netapp-2019-07-01 --java` is specified on the command line.
Please also specify the `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-netapp-2019-07-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.netapp.v2019_07_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/netapp/mgmt-v2019_07_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-netapp-2019-06-01 and java

These settings apply only when `--tag=package-netapp-2019-06-01 --java` is specified on the command line.
Please also specify the `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-netapp-2019-06-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.netapp.v2019_06_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/netapp/mgmt-v2019_06_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-netapp-2019-05-01 and java

These settings apply only when `--tag=package-netapp-2019-05-01 --java` is specified on the command line.
Please also specify the `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-netapp-2019-05-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.netapp.v2019_05_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/netapp/mgmt-v2019_05_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-08-15 and java

These settings apply only when `--tag=package-2017-08-15 --java` is specified on the command line.
Please also specify the `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-08-15' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.netapp.v2017_08_15
  output-folder: $(azure-libraries-for-java-folder)/sdk/netapp/mgmt-v2017_08_15
regenerate-manager: true
generate-interface: true
```