
These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.managedapplication
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-managedapplication
title: ManagedApplicationManagementClient
description: "Managed Application Client"
```

### Java multi-api

Generate all API versions currently shipped for this package

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-managedapplications-2021-07
  - tag: package-managedapplications-2021-02
  - tag: package-managedapplications-2020-08
  - tag: package-managedapplications-2019-07
  - tag: package-managedapplications-2018-09
  - tag: package-managedapplications-2018-06
  - tag: package-managedapplications-2018-03
  - tag: package-managedapplications-2018-02
  - tag: package-managedapplications-2017-12
  - tag: package-managedapplications-2017-09
```

### Tag: package-managedapplications-2021-07 and java

These settings apply only when `--tag=package-managedapplications-2021-07 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-managedapplications-2021-07' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.managedapplications.v2021_07_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/managedapplications/mgmt-v2021_07_01
regenerate-manager: true
generate-interface: true
fconfig: '{"moduleName": "ManagedApplications"}'
```

### Tag: package-managedapplications-2021-02 and java

These settings apply only when `--tag=package-managedapplications-2021-02 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-managedapplications-2021-02' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.managedapplications.v2021_02_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/managedapplications/mgmt-v2021_07_01_preview
regenerate-manager: true
generate-interface: true
fconfig: '{"moduleName": "ManagedApplications"}'
```

### Tag: package-managedapplications-2020-08 and java

These settings apply only when `--tag=package-managedapplications-2020-08 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-managedapplications-2020-08' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.managedapplications.v2020_08_21_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/managedapplications/mgmt-v2020_08_21_preview
regenerate-manager: true
generate-interface: true
fconfig: '{"moduleName": "ManagedApplications"}'
```

### Tag: package-managedapplications-2019-07 and java

These settings apply only when `--tag=package-managedapplications-2019-07 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-managedapplications-2019-07' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.managedapplications.v2019_07_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/managedapplications/mgmt-v2019_07_01
regenerate-manager: true
generate-interface: true
fconfig: '{"moduleName": "ManagedApplications"}'
```

### Tag: package-managedapplications-2018-09 and java

These settings apply only when `--tag=package-managedapplications-2018-09 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-managedapplications-2018-09' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.managedapplications.v2018_09_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/managedapplications/mgmt-v2018_09_01_preview
regenerate-manager: true
generate-interface: true
fconfig: '{"moduleName": "ManagedApplications"}'
```

### Tag: package-managedapplications-2018-06 and java

These settings apply only when `--tag=package-managedapplications-2018-06 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-managedapplications-2018-06' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.managedapplications.v2018_06_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/managedapplications/mgmt-v2018_06_01
regenerate-manager: true
generate-interface: true
fconfig: '{"moduleName": "ManagedApplications"}'
```

### Tag: package-managedapplications-2018-03 and java

These settings apply only when `--tag=package-managedapplications-2018-03 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-managedapplications-2018-03' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.managedapplications.v2018_03_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/managedapplications/mgmt-v2018_03_01
regenerate-manager: true
generate-interface: true
fconfig: '{"moduleName": "ManagedApplications"}'
```

### Tag: package-managedapplications-2018-02 and java

These settings apply only when `--tag=package-managedapplications-2018-02 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-managedapplications-2018-02' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.managedapplications.v2018_02_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/managedapplications/mgmt-v2018_02_01
regenerate-manager: true
generate-interface: true
fconfig: '{"moduleName": "ManagedApplications"}'
```

### Tag: package-managedapplications-2017-12 and java

These settings apply only when `--tag=package-managedapplications-2017-12 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-managedapplications-2017-12' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.managedapplications.v2017_12_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/managedapplications/mgmt-v2017_12_01
regenerate-manager: true
generate-interface: true
fconfig: '{"moduleName": "ManagedApplications"}'
```

### Tag: package-managedapplications-2017-09 and java

These settings apply only when `--tag=package-managedapplications-2017-09 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-managedapplications-2017-09' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.managedapplications.v2017_09_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/managedapplications/mgmt-v2017_09_01
regenerate-manager: true
generate-interface: true
fconfig: '{"moduleName": "ManagedApplications"}'
```