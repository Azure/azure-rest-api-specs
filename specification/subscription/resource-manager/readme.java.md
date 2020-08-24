## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.subscription
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-subscription
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2019-10-preview
  - tag: package-2017-11-preview
```

### Tag: package-2019-10-preview and java

These settings apply only when `--tag=package-2019-10-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-10-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.subscription.v2019_10_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/subscription/mgmt-v2019_10_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-11-preview and java

These settings apply only when `--tag=package-2017-11-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-11-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.subscription.v2017_11_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/subscription/mgmt-v2017_11_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2016-06-01

These settings apply only when `--tag=package-2016-06-01` is specified on the command line.

``` yaml $(tag) == 'package-2016-06-01'
input-file:
- Microsoft.Subscription/stable/2016-06-01/subscriptions.json
title: SubscriptionClient
description: The subscription client
```