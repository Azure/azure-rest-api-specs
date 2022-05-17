# StreamAnalytics

> see https://aka.ms/autorest

This is the AutoRest configuration file for StreamAnalytics.

---

## Getting Started

To build the SDK for StreamAnalytics, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the StreamAnalytics API.

``` yaml
title: Stream Analytics Management Client
description: Stream Analytics Client
openapi-type: arm
tag: package-pure-2020-03
```

### Tag: package-2021-10-preview

These settings apply only when `--tag=package-2021-10-preview` is specified on the command line.

This section contains the composite set of APIs. Stream Analytics Cluster and Private Endpoint related APIs are under 2020-03-01-preview version. Streamingjobs related APIs are under 2021-10-01-preview version.

```yaml $(tag) == 'package-2021-10-preview'
input-file:
  - Microsoft.StreamAnalytics/preview/2021-10-01-preview/functions.json
  - Microsoft.StreamAnalytics/preview/2021-10-01-preview/inputs.json
  - Microsoft.StreamAnalytics/preview/2021-10-01-preview/outputs.json
  - Microsoft.StreamAnalytics/preview/2021-10-01-preview/streamingjobs.json
  - Microsoft.StreamAnalytics/preview/2021-10-01-preview/subscriptions.json
  - Microsoft.StreamAnalytics/preview/2021-10-01-preview/transformations.json
  - Microsoft.StreamAnalytics/preview/2020-03-01-preview/clusters.json
  - Microsoft.StreamAnalytics/preview/2020-03-01-preview/privateEndpoints.json
```

### Tag: package-2020-03-preview

These settings apply only when `--tag=package-2020-03-preview` is specified on the command line.

This section contains the composite set of APIs. Stream Analytics Cluster and Private Endpoint related APIs are under 2020-03-01-preview version. Streamingjobs related APIs are under 2017-04-01-preview version.

```yaml $(tag) == 'package-2020-03-preview'
input-file:
  - Microsoft.StreamAnalytics/preview/2017-04-01-preview/functions.json
  - Microsoft.StreamAnalytics/preview/2017-04-01-preview/inputs.json
  - Microsoft.StreamAnalytics/preview/2017-04-01-preview/outputs.json
  - Microsoft.StreamAnalytics/preview/2017-04-01-preview/streamingjobs.json
  - Microsoft.StreamAnalytics/preview/2017-04-01-preview/subscriptions.json
  - Microsoft.StreamAnalytics/preview/2017-04-01-preview/transformations.json
  - Microsoft.StreamAnalytics/preview/2017-04-01-preview/operations.json
  - Microsoft.StreamAnalytics/preview/2020-03-01-preview/clusters.json
  - Microsoft.StreamAnalytics/preview/2020-03-01-preview/privateEndpoints.json
```

### Tag: package-pure-2020-03

These settings apply only when `--tag=package-pure-2020-03` is specified on the command line.

``` yaml $(tag) == 'package-pure-2020-03'
input-file:
- Microsoft.StreamAnalytics/stable/2020-03-01/streamingjobs.json
- Microsoft.StreamAnalytics/stable/2020-03-01/inputs.json
- Microsoft.StreamAnalytics/stable/2020-03-01/outputs.json
- Microsoft.StreamAnalytics/stable/2020-03-01/transformations.json
- Microsoft.StreamAnalytics/stable/2020-03-01/functions.json
- Microsoft.StreamAnalytics/stable/2020-03-01/subscriptions.json
- Microsoft.StreamAnalytics/stable/2020-03-01/clusters.json
- Microsoft.StreamAnalytics/stable/2020-03-01/privateEndpoints.json
```

### Tag: package-pure-2020-03-preview

These settings apply only when `--tag=package-pure-2020-03-preview` is specified on the command line.

This section only contains input swagger files for version 2020-03-01-preview, including Stream Analytics Cluster and Private Endpoint related APIs.  

```yaml $(tag) == 'package-pure-2020-03-preview'
input-file:
  - Microsoft.StreamAnalytics/preview/2020-03-01-preview/clusters.json
  - Microsoft.StreamAnalytics/preview/2020-03-01-preview/privateEndpoints.json
```

### Tag: package-pure-2017-04-preview

These settings apply only when `--tag=package-pure-2017-04-preview` is specified on the command line.

This section only contains input swagger files for version 2017-04-01-preview, including streamingjobs related APIs. 

```yaml $(tag) == 'package-pure-2017-04-preview'
input-file:
  - Microsoft.StreamAnalytics/preview/2017-04-01-preview/functions.json
  - Microsoft.StreamAnalytics/preview/2017-04-01-preview/inputs.json
  - Microsoft.StreamAnalytics/preview/2017-04-01-preview/outputs.json
  - Microsoft.StreamAnalytics/preview/2017-04-01-preview/streamingjobs.json
  - Microsoft.StreamAnalytics/preview/2017-04-01-preview/subscriptions.json
  - Microsoft.StreamAnalytics/preview/2017-04-01-preview/transformations.json
  - Microsoft.StreamAnalytics/preview/2017-04-01-preview/operations.json
```

### Tag: package-pure-2016-03

These settings apply only when `--tag=package-pure-2016-03` is specified on the command line.

``` yaml $(tag) == 'package-pure-2016-03'
input-file:
- Microsoft.StreamAnalytics/stable/2016-03-01/streamingjobs.json
- Microsoft.StreamAnalytics/stable/2016-03-01/inputs.json
- Microsoft.StreamAnalytics/stable/2016-03-01/outputs.json
- Microsoft.StreamAnalytics/stable/2016-03-01/transformations.json
- Microsoft.StreamAnalytics/stable/2016-03-01/functions.json
- Microsoft.StreamAnalytics/stable/2016-03-01/subscriptions.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-go-track2
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_stream_analytics']
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.StreamAnalytics
  output-folder: $(csharp-sdks-folder)/streamanalytics/Microsoft.Azure.Management.StreamAnalytics/src/Generated
  clear-output-folder: true
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.streamanalytics
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-streamanalytics
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2020-03-preview
```

### Tag: package-pure-2016-03 and java

These settings apply only when `--tag=package-pure-2016-03 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-pure-2016-03' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.streamanalytics.v2016_03_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/streamanalytics/mgmt-v2016_03_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-pure-2017-04-preview and java

These settings apply only when `--tag=package-pure-2017-04-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-pure-2017-04-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.streamanalytics.v2017_04_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/streamanalytics/mgmt-v2017_04_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-03-preview and java

These settings apply only when `--tag=package-2020-03-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-03-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.streamanalytics.v2020_03_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/streamanalytics/mgmt-v2020_03_01_preview
regenerate-manager: true
generate-interface: true
```

# Suppression

``` yaml
directive:
  - suppress: R2020  # Model definition 'XXX' must have the properties 'name', 'id' and 'type' in its hierarchy and these properties must be marked as readonly.
    where: $.definitions.Input
    from: inputs.json
    reason: Need the “name” property to be writable on nested resources so that our RP can support a DEEP PUT scenario which at the time, ARM did not have a native way to support.

  - suppress: R2020  # Model definition 'XXX' must have the properties 'name', 'id' and 'type' in its hierarchy and these properties must be marked as readonly.
    where: $.definitions.Output
    from: outputs.json
    reason: Need the “name” property to be writable on nested resources so that our RP can support a DEEP PUT scenario which at the time, ARM did not have a native way to support.

  - suppress: R2020  # Model definition 'XXX' must have the properties 'name', 'id' and 'type' in its hierarchy and these properties must be marked as readonly.
    where: $.definitions.Transformation
    from: transformations.json
    reason: Need the “name” property to be writable on nested resources so that our RP can support a DEEP PUT scenario which at the time, ARM did not have a native way to support.

  - suppress: R2020  # Model definition 'XXX' must have the properties 'name', 'id' and 'type' in its hierarchy and these properties must be marked as readonly.
    where: $.definitions.Function
    from: functions.json
    reason: Need the “name” property to be writable on nested resources so that our RP can support a DEEP PUT scenario which at the time, ARM did not have a native way to support.

  - suppress: R2020  # Model definition 'XXX' must have the properties 'name', 'id' and 'type' in its hierarchy and these properties must be marked as readonly.
    where: $.definitions.SubscriptionQuota
    from: subscriptions.json
    reason: Need the “name” property to be writable on nested resources so that our RP can support a DEEP PUT scenario which at the time, ARM did not have a native way to support.

  - suppress: R3023 # Operations API must be implemented for '/providers/Microsoft.StreamAnalytics/operations'.
    reason:  Operations API under 2017-04-01-preview is the super-set of all RPs operations (across all API-versions).
```



