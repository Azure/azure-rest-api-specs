## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.storagecache
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-storagecache
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2019-11-01
  - tag: package-2019-08
```

### Tag: package-2019-11-01 and java

These settings apply only when `--tag=package-2019-11-01 --java` is specified on the command line.
Please also specify the `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-11-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.storagecache.v2019_11_01
  output-folder: $(azure-libraries-for-java-folder)/storagecache/resource-manager/v2019_11_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-08 and java

These settings apply only when `--tag=package-2019-08 --java` is specified on the command line.
Please also specify the `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-08' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.storagecache.v2019_08_01
  output-folder: $(azure-libraries-for-java-folder)/storagecache/resource-manager/v2019_08_01
regenerate-manager: true
generate-interface: true
```
