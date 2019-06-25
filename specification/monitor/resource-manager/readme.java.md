## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.monitor
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-monitor
service-name: Monitor
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2018-09-01-only
  - tag: package-2018-04-16-only
  - tag: package-2018-03-01-only
  - tag: package-2017-04-01-only
  - tag: package-2017-03-01-preview-only
  - tag: package-2016-03-01-only
  - tag: package-2015-07-01-only
```

## Suppression

``` yaml
directive:
  - suppress: R3016  # DefinitionsPropertiesNamesCamelCase (to suppress the error due to odata.type)
    reason: The feature (polymorphic types) is in the process of deprecation and fixing this will require changes in the backend.
```

### Tag: package-2018-09-01-only and java

These settings apply only when `--tag=package-2018-09-01-only --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-09-01-only' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.monitor.v2018_09_01
  output-folder: $(azure-libraries-for-java-folder)/monitor/resource-manager/v2018_09_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-04-16-only and java

These settings apply only when `--tag=package-2018-04-16-only --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-04-16-only' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.monitor.v2018_04_16
  output-folder: $(azure-libraries-for-java-folder)/monitor/resource-manager/v2018_04_16
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-03-01-only and java

These settings apply only when `--tag=package-2018-03-01-only --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-03-01-only' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.monitor.v2018_03_01
  output-folder: $(azure-libraries-for-java-folder)/monitor/resource-manager/v2018_03_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-01-01-only and java

These settings apply only when `--tag=package-2018-01-01-only --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-01-01-only' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.monitor.v2018_01_01
  output-folder: $(azure-libraries-for-java-folder)/monitor/resource-manager/v2018_01_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-05-01-preview-only and java

These settings apply only when `--tag=package-2017-05-01-preview-only --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-05-01-preview-only' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.monitor.v2017_05_01_preview
  output-folder: $(azure-libraries-for-java-folder)/monitor/resource-manager/v2017_05_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-04-01-only and java

These settings apply only when `--tag=package-2017-04-01-only --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-04-01-only' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.monitor.v2017_04_01
  output-folder: $(azure-libraries-for-java-folder)/monitor/resource-manager/v2017_04_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-03-01-preview-only and java

These settings apply only when `--tag=package-2017-03-01-preview-only --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-03-01-preview-only' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.monitor.v2017_03_01_preview
  output-folder: $(azure-libraries-for-java-folder)/monitor/resource-manager/v2017_03_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2016-03-01-only and java

These settings apply only when `--tag=package-2016-03-01-only --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2016-03-01-only' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.monitor.v2016_03_01
  output-folder: $(azure-libraries-for-java-folder)/monitor/resource-manager/v2016_03_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2015-07-01-only and java

These settings apply only when `--tag=package-2015-07-01-only --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2015-07-01-only' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.monitor.v2015_07_01
  output-folder: $(azure-libraries-for-java-folder)/monitor/resource-manager/v2015_07_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2015-04-01-only and java

These settings apply only when `--tag=package-2015-04-01-only --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2015-04-01-only' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.monitor.v2015_04_01
  output-folder: $(azure-libraries-for-java-folder)/monitor/resource-manager/v2015_04_01
regenerate-manager: true
generate-interface: true
```