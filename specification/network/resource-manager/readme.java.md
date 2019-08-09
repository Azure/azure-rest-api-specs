## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.network
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-network
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2019-06
  - tag: package-2019-04
  - tag: package-2019-02
  - tag: package-2018-12
  - tag: package-2018-08
  - tag: package-2018-07
  - tag: package-2018-06
  - tag: package-2018-04
  - tag: package-2017-10
```

### Tag: package-2019-06 and java

These settings apply only when `--tag=package-2019-06 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-06' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.network.v2019_06_01
  output-folder: $(azure-libraries-for-java-folder)/network/resource-manager/v2019_06_01
  regenerate-manager: true
  generate-interface: true
```

### Tag: package-2019-04 and java

These settings apply only when `--tag=package-2019-04 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-04' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.network.v2019_04_01
  output-folder: $(azure-libraries-for-java-folder)/network/resource-manager/v2019_04_01
  regenerate-manager: true
  generate-interface: true
```

### Tag: package-2019-02 and java

These settings apply only when `--tag=package-2019-02 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-02' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.network.v2019_02_01
  output-folder: $(azure-libraries-for-java-folder)/network/resource-manager/v2019_02_01
  regenerate-manager: true
  generate-interface: true
```

### Tag: package-2018-12 and java

These settings apply only when `--tag=package-2018-12 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-12' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.network.v2018_12_01
  output-folder: $(azure-libraries-for-java-folder)/network/resource-manager/v2018_12_01
  regenerate-manager: true
  generate-interface: true
```

### Tag: package-2018-08 and java

These settings apply only when `--tag=package-2018-08 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-08' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.network.v2018_08_01
  output-folder: $(azure-libraries-for-java-folder)/network/resource-manager/v2018_08_01
  regenerate-manager: true
  generate-interface: true
```

### Tag: package-2018-07 and java

These settings apply only when `--tag=package-2018-07 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-07' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.network.v2018_07_01
  output-folder: $(azure-libraries-for-java-folder)/network/resource-manager/v2018_07_01
  regenerate-manager: true
  generate-interface: true
```

### Tag: package-2018-06 and java

These settings apply only when `--tag=package-2018-06 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-06' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.network.v2018_06_01
  output-folder: $(azure-libraries-for-java-folder)/network/resource-manager/v2018_06_01
  regenerate-manager: true
  generate-interface: true
```

### Tag: package-2018-04 and java

These settings apply only when `--tag=package-2018-04 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-04' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.network.v2018_04_01
  output-folder: $(azure-libraries-for-java-folder)/network/resource-manager/v2018_04_01
  regenerate-manager: true
  generate-interface: true
```

### Tag: package-2017-10 and java

These settings apply only when `--tag=package-2017-10 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-10' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.network.v2017_10_01
  output-folder: $(azure-libraries-for-java-folder)/network/resource-manager/v2017_10_01
  regenerate-manager: true
  generate-interface: true
```

### Tag: profile-hybrid-2019-03-01

These settings apply only when `--tag=profile-hybrid-2019-03-01` is specified on the command line.
Creating this tag to pick proper resources from the hybrid profile.

``` yaml $(tag) == 'profile-hybrid-2019-03-01'
input-file:
- Microsoft.Network/stable/2017-10-01/loadBalancer.json
- Microsoft.Network/stable/2017-10-01/virtualNetworkGateway.json
- Microsoft.Network/stable/2017-10-01/network.json
- Microsoft.Network/stable/2017-10-01/networkInterface.json
- Microsoft.Network/stable/2017-10-01/networkSecurityGroup.json
- Microsoft.Network/stable/2017-10-01/operation.json
- Microsoft.Network/stable/2017-10-01/publicIpAddress.json
- Microsoft.Network/stable/2017-10-01/routeTable.json
- Microsoft.Network/stable/2017-10-01/virtualNetwork.json
```
