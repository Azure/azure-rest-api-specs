## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.containerregistry
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-containerregistry
```

These settings apply only when `--multiapi` is not specified on the command line.

``` yaml $(java) && !$(multiapi)
directive:
  - rename-model:
      from: DockerBuildStep
      to: DockerTaskStep
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2022-02-preview
  - tag: package-2021-12-preview
  - tag: package-2021-09
  - tag: package-2021-08-preview
  - tag: package-2021-06-preview
  - tag: package-2020-11-preview
  - tag: package-2019-12-preview
  - tag: package-2019-06-preview-only
  - tag: package-2019-04-only
  - tag: package-2019-04
  - tag: package-2018-09
  - tag: package-2018-02-preview
  - tag: package-2017-10
  - tag: package-2017-06-preview
  - tag: package-2017-03
  - tag: package-2016-06-preview
```

### Tag: package-2022-02-preview and java

These settings apply only when `--tag=package-2022-02-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2022-02-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerregistry.v2022_02_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerregistry/mgmt-v2022_02_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-12-preview and java

These settings apply only when `--tag=package-2021-12-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-12-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerregistry.v2021_12_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerregistry/mgmt-v2021_12_01_preview
regenerate-manager: true
generate-interface: true
```


### Tag: package-2021-09 and java

These settings apply only when `--tag=package-2021-09 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-09' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerregistry.v2021_09_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerregistry/mgmt-v2021_09_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-08-preview and java

These settings apply only when `--tag=package-2021-08-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-08-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerregistry.v2021_08_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerregistry/mgmt-v2021_08_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-06-preview and java

These settings apply only when `--tag=package-2021-06-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-06-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerregistry.v2021_06_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerregistry/mgmt-v2021_06_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-11-preview and java

These settings apply only when `--tag=package-2020-11-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-11-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerregistry.v2020_11_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerregistry/mgmt-v2020_11_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-12-preview and java

These settings apply only when `--tag=package-2019-12-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-12-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerregistry.v2019_12_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerregistry/mgmt-v2019_12_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-06-preview-only and java

These settings apply only when `--tag=package-2019-06-preview-only --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-06-preview-only' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerregistry.v2019_06_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerregistry/mgmt-v2019_06_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-04-only and java

These settings apply only when `--tag=package-2019-04-only --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-04-only' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerregistry.v2019_04_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerregistry/mgmt-v2019_04_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-04 and java

These settings apply only when `--tag=package-2019-04 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-04' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerregistry.v2019_04_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerregistry/mgmt-v2019_04_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-09 and java

These settings apply only when `--tag=package-2018-09 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-09' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerregistry.v2018_09_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerregistry/mgmt-v2018_09_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-02-preview and java

These settings apply only when `--tag=package-2018-02-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-02-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerregistry.v2018_02_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerregistry/mgmt-v2018_02_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-10 and java

These settings apply only when `--tag=package-2017-10 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-10' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerregistry.v2017_10_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerregistry/mgmt-v2017_10_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-06-preview and java

These settings apply only when `--tag=package-2017-06-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-06-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerregistry.v2017_06_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerregistry/mgmt-v2017_06_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-03 and java

These settings apply only when `--tag=package-2017-03 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-03' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerregistry.v2017_03_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerregistry/mgmt-v2017_03_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2016-06-preview and java

These settings apply only when `--tag=package-2016-06-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2016-06-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.containerregistry.v2016_06_27_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/containerregistry/mgmt-v2016_06_27_preview
regenerate-manager: true
generate-interface: true
```