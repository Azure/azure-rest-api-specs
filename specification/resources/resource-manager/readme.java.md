## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.resources
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-resources

directive:
  - rename-operation:
      from: Tags_DeleteValue
      to: TagOperations_DeleteValue
  - rename-operation:
      from: Tags_CreateOrUpdateValue
      to: TagOperations_CreateOrUpdateValue
  - rename-operation:
      from: Tags_CreateOrUpdate
      to: TagOperations_CreateOrUpdate
  - rename-operation:
      from: Tags_Delete
      to: TagOperations_Delete
  - rename-operation:
      from: Tags_DeleteValue
      to: TagOperations_DeleteValue
  - rename-operation:
      from: Tags_List
      to: TagOperations_List
  - rename-operation:
      from: Tags_CreateOrUpdateAtScope
      to: TagOperations_CreateOrUpdateAtScope
  - rename-operation:
      from: Tags_UpdateAtScope
      to: TagOperations_UpdateAtScope
  - rename-operation:
      from: Tags_GetAtScope
      to: TagOperations_GetAtScope
  - rename-operation:
      from: Tags_DeleteAtScope
      to: TagOperations_DeleteAtScope
```

### Java multi-api

Generate all API versions currently shipped for this package

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-features-2015-12
  - tag: package-features-2021-07
  - tag: package-locks-2016-09
  - tag: package-managedapplications-2019-07
  - tag: package-policy-2021-06
  - tag: package-policy-2020-09
  - tag: package-policy-2019-09
  - tag: package-policy-2019-06
  - tag: package-policy-2019-01
  - tag: package-policy-2018-05
  - tag: package-policy-2018-03
  - tag: package-policy-2016-12
  - tag: package-resources-2020-10
  - tag: package-resources-2020-06
  - tag: package-resources-2019-10
  - tag: package-resources-2019-08
  - tag: package-resources-2019-07
  - tag: package-resources-2019-0510
  - tag: package-resources-2019-05
  - tag: package-resources-2019-03
  - tag: package-resources-2018-02
  - tag: package-resources-2016-09
  - tag: package-subscriptions-2019-06
  - tag: package-subscriptions-2018-06
  - tag: package-subscriptions-2016-06
```

### Tag: package-features-2021-07 and java

These settings apply only when `--tag=package-features-2021-07 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-features-2021-07' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.features.v2021_07_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/features/mgmt-v2021_07_01
regenerate-manager: true
generate-interface: true
fconfig: '{"moduleName": "Features"}'
```

### Tag: package-features-2015-12 and java

These settings apply only when `--tag=package-features-2015-12 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-features-2015-12' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.features.v2015_12_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/features/mgmt-v2015_12_01
regenerate-manager: true
generate-interface: true
fconfig: '{"moduleName": "Features"}'
```

### Tag: package-locks-2016-09 and java

These settings apply only when `--tag=package-locks-2016-09 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-locks-2016-09' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.locks.v2016_09_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/locks/mgmt-v2016_09_01
regenerate-manager: true
generate-interface: true
fconfig: '{"moduleName": "Locks"}'
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

### Tag: package-policy-2021-06 and java

These settings apply only when `--tag=package-policy-2021-06 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-policy-2021-06' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.policy.v2021_06_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/policy/mgmt-v2021_06_01
regenerate-manager: true
generate-interface: true
fconfig: '{"moduleName": "Policy"}'
directive:
  from: policyAssignments.json
  where: $.definitions.PolicyAssignmentProperties.properties.scope
  transform: $['x-ms-client-name'] = 'scopeProperty'
```

### Tag: package-policy-2020-09 and java

These settings apply only when `--tag=package-policy-2020-09 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-policy-2020-09' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.policy.v2020_09_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/policy/mgmt-v2020_09_01
regenerate-manager: true
generate-interface: true
fconfig: '{"moduleName": "Policy"}'
directive:
  from: policyAssignments.json
  where: $.definitions.PolicyAssignmentProperties.properties.scope
  transform: $['x-ms-client-name'] = 'scopeProperty'
```

### Tag: package-policy-2019-09 and java

These settings apply only when `--tag=package-policy-2019-09 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-policy-2019-09' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.policy.v2019_09_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/policy/mgmt-v2019_09_01
regenerate-manager: true
generate-interface: true
fconfig: '{"moduleName": "Policy"}'
directive:
  from: policyAssignments.json
  where: $.definitions.PolicyAssignmentProperties.properties.scope
  transform: $['x-ms-client-name'] = 'scopeProperty'
```

### Tag: package-policy-2019-06 and java

These settings apply only when `--tag=package-policy-2019-06 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-policy-2019-06' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.policy.v2019_06_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/policy/mgmt-v2019_06_01
regenerate-manager: true
generate-interface: true
fconfig: '{"moduleName": "Policy"}'
directive:
  from: policyAssignments.json
  where: $.definitions.PolicyAssignmentProperties.properties.scope
  transform: $['x-ms-client-name'] = 'scopeProperty'
```

### Tag: package-policy-2019-01 and java

These settings apply only when `--tag=package-policy-2019-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-policy-2019-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.policy.v2019_01_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/policy/mgmt-v2019_01_01
regenerate-manager: true
generate-interface: true
fconfig: '{"moduleName": "Policy"}'
directive:
  from: policyAssignments.json
  where: $.definitions.PolicyAssignmentProperties.properties.scope
  transform: $['x-ms-client-name'] = 'scopeProperty'
```

### Tag: package-policy-2018-05 and java

These settings apply only when `--tag=package-policy-2018-05 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-policy-2018-05' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.policy.v2018_05_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/policy/mgmt-v2018_05_01
regenerate-manager: true
generate-interface: true
fconfig: '{"moduleName": "Policy"}'
directive:
  from: policyAssignments.json
  where: $.definitions.PolicyAssignmentProperties.properties.scope
  transform: $['x-ms-client-name'] = 'scopeProperty'
```

### Tag: package-policy-2018-03 and java

These settings apply only when `--tag=package-policy-2018-03 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-policy-2018-03' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.policy.v2018_03_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/policy/mgmt-v2018_03_01
regenerate-manager: true
generate-interface: true
fconfig: '{"moduleName": "Policy"}'
directive:
  from: policyAssignments.json
  where: $.definitions.PolicyAssignmentProperties.properties.scope
  transform: $['x-ms-client-name'] = 'scopeProperty'
```

### Tag: package-policy-2016-12 and java

These settings apply only when `--tag=package-policy-2016-12 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-policy-2016-12' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.policy.v2016_12_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/policy/mgmt-v2016_12_01
regenerate-manager: true
generate-interface: true
fconfig: '{"moduleName": "Policy"}'
directive:
  from: policyAssignments.json
  where: $.definitions.PolicyAssignmentProperties.properties.scope
  transform: $['x-ms-client-name'] = 'scopeProperty'
```

### Tag: package-resources-2020-10 and java

These settings apply only when `--tag=package-resources-2020-10 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-resources-2020-10' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.resources.v2020_10_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/resources/mgmt-v2020_10_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-resources-2020-06 and java

These settings apply only when `--tag=package-resources-2020-06 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-resources-2020-06' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.resources.v2020_06_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/resources/mgmt-v2020_06_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-resources-2019-10 and java

These settings apply only when `--tag=package-resources-2019-10 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-resources-2019-10' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.resources.v2019_10_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/resources/mgmt-v2019_10_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-resources-2019-08 and java

These settings apply only when `--tag=package-resources-2019-08 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-resources-2019-08' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.resources.v2019_08_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/resources/mgmt-v2019_08_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-resources-2019-07 and java

These settings apply only when `--tag=package-resources-2019-07 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-resources-2019-07' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.resources.v2019_07_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/resources/mgmt-v2019_07_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-resources-2019-0510 and java

These settings apply only when `--tag=package-resources-2019-0510 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-resources-2019-0510' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.resources.v2019_05_10
  output-folder: $(azure-libraries-for-java-folder)/sdk/resources/mgmt-v2019_05_10
regenerate-manager: true
generate-interface: true
```

### Tag: package-resources-2019-05 and java

These settings apply only when `--tag=package-resources-2019-05 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-resources-2019-05' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.resources.v2019_05_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/resources/mgmt-v2019_05_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-resources-2019-03 and java

These settings apply only when `--tag=package-resources-2019-03 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-resources-2019-03' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.resources.v2019_03_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/resources/mgmt-v2019_03_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-resources-2018-02 and java

These settings apply only when `--tag=package-resources-2018-02 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-resources-2018-02' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.resources.v2018_02_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/resources/mgmt-v2018_02_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-resources-2016-09 and java

These settings apply only when `--tag=package-resources-2016-09 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-resources-2016-09' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.resources.v2016_09_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/resources/mgmt-v2016_09_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-subscriptions-2019-06 and java

These settings apply only when `--tag=package-subscriptions-2019-06 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-subscriptions-2019-06' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.resources.v2019_06_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/resources/mgmt-v2019_06_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-subscriptions-2018-06 and java

These settings apply only when `--tag=package-subscriptions-2018-06 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-subscriptions-2018-06' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.resources.v2018_06_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/resources/mgmt-v2018_06_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-subscriptions-2016-06 and java

These settings apply only when `--tag=package-subscriptions-2016-06 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-subscriptions-2016-06' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.resources.v2016_06_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/resources/mgmt-v2016_06_01
regenerate-manager: true
generate-interface: true
```
