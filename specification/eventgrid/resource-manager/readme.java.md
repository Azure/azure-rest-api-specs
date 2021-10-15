## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.eventgrid
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-eventgrid
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2021-12
  - tag: package-2021-06-preview
  - tag: package-2020-10-preview
  - tag: package-2020-06
  - tag: package-2020-04-preview
  - tag: package-2020-01-preview
  - tag: package-2019-06
  - tag: package-2019-02-preview
  - tag: package-2019-01
  - tag: package-2018-09-preview
  - tag: package-2018-05-preview
  - tag: package-2018-01
```

### Tag: package-2021-12 and java

These settings apply only when `--tag=package-2021-12 --java` is specified on the command line.

Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-12' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.eventgrid.v2021_12_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/eventgrid/mgmt-v2021_12_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-06-preview and java

These settings apply only when `--tag=package-2021-06-preview --java` is specified on the command line.

Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-06-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.eventgrid.v2021_06_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/eventgrid/mgmt-v2021_06_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-10-preview and java

These settings apply only when `--tag=package-2020-10-preview --java` is specified on the command line.

Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-10-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.eventgrid.v2020_10_15_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/eventgrid/mgmt-v2020_10_15_preview
regenerate-manager: true
generate-interface: true
```



### Tag: package-2020-06 and java

These settings apply only when `--tag=package-2020-06 --java` is specified on the command line.

Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-06' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.eventgrid.v2020_06_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/eventgrid/mgmt-v2020_06_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-04-preview and java

These settings apply only when `--tag=package-2020-04-preview --java` is specified on the command line.

Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-04-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.eventgrid.v2020_04_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/eventgrid/mgmt-v2020_04_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-01-preview and java

These settings apply only when `--tag=package-2020-01-preview --java` is specified on the command line.

Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-01-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.eventgrid.v2020_01_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/eventgrid/mgmt-v2020_01_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-06 and java

These settings apply only when `--tag=package-2019-06 --java` is specified on the command line.

Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-06' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.eventgrid.v2019_06_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/eventgrid/mgmt-v2019_06_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-02-preview and java

These settings apply only when `--tag=package-2019-02-preview --java` is specified on the command line.

Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-02-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.eventgrid.v2019_02_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/eventgrid/mgmt-v2019_02_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-01 and java

These settings apply only when `--tag=package-2019-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.eventgrid.v2019_01_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/eventgrid/mgmt-v2019_01_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-09-preview and java

These settings apply only when `--tag=package-2018-09-preview --java` is specified on the command line.

Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-09-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.eventgrid.v2018_09_15_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/eventgrid/mgmt-v2018_09_15_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-05-preview and java

These settings apply only when `--tag=package-2018-05-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-05-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.eventgrid.v2018_05_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/eventgrid/mgmt-v2018_05_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-01 and java

These settings apply only when `--tag=package-2018-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.eventgrid.v2018_01_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/eventgrid/mgmt-v2018_01_01
regenerate-manager: true
generate-interface: true
```