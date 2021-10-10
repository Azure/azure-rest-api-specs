# Consumption

> see https://aka.ms/autorest

This is the AutoRest configuration file for Consumption.

---

## Getting Started

To build the SDK for Consumption, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the Consumption API.

``` yaml
openapi-type: arm
tag: package-2021-10
```


### Tag: package-2021-10

These settings apply only when `--tag=package-2021-10` is specified on the command line.

```yaml $(tag) == 'package-2021-10'
input-file:
  - Microsoft.Consumption/stable/2021-10-01/consumption.json
```
### Tag: package-2021-05

These settings apply only when `--tag=package-2021-05` is specified on the command line.

``` yaml $(tag) == 'package-2021-05'
input-file:
  - Microsoft.Consumption/stable/2021-05-01/consumption.json
```

### Tag: package-2019-11

These settings apply only when `--tag=package-2019-11` is specified on the command line.

``` yaml $(tag) == 'package-2019-11'
input-file:
  - Microsoft.Consumption/stable/2019-11-01/consumption.json
```

### Tag: package-2019-10

These settings apply only when `--tag=package-2019-10` is specified on the command line.

``` yaml $(tag) == 'package-2019-10'
input-file:
  - Microsoft.Consumption/stable/2019-10-01/consumption.json
```

### Tag: package-2019-06

These settings apply only when `--tag=package-2019-06` is specified on the command line.

``` yaml $(tag) == 'package-2019-06'
input-file:
  - Microsoft.Consumption/stable/2019-06-01/consumption.json
```

### Tag: package-2019-05

These settings apply only when `--tag=package-2019-05` is specified on the command line.

``` yaml $(tag) == 'package-2019-05'
input-file:
  - Microsoft.Consumption/stable/2019-05-01/consumption.json
```

### Tag: package-preview-2019-05

These settings apply only when `--tag=package-preview-2019-05` is specified on the command line.

``` yaml $(tag) == 'package-preview-2019-05'
input-file:
  - Microsoft.Consumption/preview/2019-05-01-preview/consumption.json
```

### Tag: package-preview-2019-04

These settings apply only when `--tag=package-preview-2019-04` is specified on the command line.

``` yaml $(tag) == 'package-preview-2019-04'
input-file:
  - Microsoft.Consumption/preview/2019-04-01-preview/consumption.json
```

### Tag: package-preview-2018-11

These settings apply only when `--tag=package-preview-2018-11` is specified on the command line.

``` yaml $(tag) == 'package-preview-2018-11'
input-file:
  - Microsoft.Consumption/preview/2018-11-01-preview/consumption.json
```

### Tag: package-2019-01

These settings apply only when `--tag=package-2019-01` is specified on the command line.

``` yaml $(tag) == 'package-2019-01'
input-file:
  - Microsoft.Consumption/stable/2019-01-01/consumption.json
```

### Tag: package-2017-11

These settings apply only when `--tag=package-2017-11` is specified on the command line.

``` yaml $(tag) == 'package-2017-11'
input-file:
- Microsoft.Consumption/stable/2017-11-30/consumption.json
```

---

### Tag: package-2018-01

These settings apply only when `--tag=package-2018-01` is specified on the command line.

``` yaml $(tag) == 'package-2018-01'
input-file:
- Microsoft.Consumption/stable/2018-01-31/consumption.json
```

---

### Tag: package-2018-03

These settings apply only when `--tag=package-2018-03` is specified on the command line.

``` yaml $(tag) == 'package-2018-03'
input-file:
- Microsoft.Consumption/stable/2018-03-31/consumption.json
```

---

### Tag: package-2018-05

These settings apply only when `--tag=package-2018-05` is specified on the command line.

``` yaml $(tag) == 'package-2018-05'
input-file:
- Microsoft.Consumption/stable/2018-05-31/consumption.json
```

---

### Tag: package-2018-06

These settings apply only when `--tag=package-2018-06` is specified on the command line.

``` yaml $(tag) == 'package-2018-06'
input-file:
- Microsoft.Consumption/stable/2018-06-30/consumption.json
```

---

### Tag: package-2018-08

These settings apply only when `--tag=package-2018-08` is specified on the command line.

``` yaml $(tag) == 'package-2018-08'
input-file:
- Microsoft.Consumption/stable/2018-08-31/consumption.json
```

---

### Tag: package-2018-10

These settings apply only when `--tag=package-2018-10` is specified on the command line.

``` yaml $(tag) == 'package-2018-10'
input-file:
- Microsoft.Consumption/stable/2018-10-01/consumption.json
```

## Suppression

``` yaml
directive:
  - suppress: R2059
    from: consumption.json
    reason: it's not actually a resource path; the validator is confused because the Billing namespace is in the URI path.
    approved-by: "@fearthecowboy"
```

---

### Tag: package-2017-04-preview

These settings apply only when `--tag=package-2017-04-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-04-preview'
input-file:
- Microsoft.Consumption/preview/2017-04-24-preview/consumption.json
```

---

### Tag: package-2017-12-preview

These settings apply only when `--tag=package-2017-12-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-12-preview'
input-file:
- Microsoft.Consumption/preview/2017-12-30-preview/consumption.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_consumption']
  - repo: azure-resource-manager-schemas
```

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.Consumption
  output-folder: $(csharp-sdks-folder)/consumption/Microsoft.Azure.Management.Consumption/src/Generated
  clear-output-folder: true
```

## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.consumption
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-consumption
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2017-04-preview
  - tag: package-2017-11
  - tag: package-2018-01
  - tag: package-2018-03
  - tag: package-2018-05
  - tag: package-2018-06
  - tag: package-2018-08
  - tag: package-2018-10
  - tag: package-2019-01
```

### Tag: package-2017-04-preview and java

These settings apply only when `--tag=package-2017-04-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-04-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.consumption.v2017_04_24_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/consumption/mgmt-v2017_04_24_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-11 and java

These settings apply only when `--tag=package-2017-11 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-11' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.consumption.v2017_11_30
  output-folder: $(azure-libraries-for-java-folder)/sdk/consumption/mgmt-v2017_11_30
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-01 and java

These settings apply only when `--tag=package-2018-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.consumption.v2018_01_31
  output-folder: $(azure-libraries-for-java-folder)/sdk/consumption/mgmt-v2018_01_31
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-03 and java

These settings apply only when `--tag=package-2018-03 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-03' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.consumption.v2018_03_31
  output-folder: $(azure-libraries-for-java-folder)/sdk/consumption/mgmt-v2018_03_31
regenerate-manager: true
generate-interface: true
directive:
 - rename-model:
     from: CostTags
     to: CostTagsModel
 - rename-model:
     from: Tags
     to: TagsModel
 - rename-model:
     from: ReservationRecommendations
     to: ReservationRecommendationsModel
```

### Tag: package-2017-12-preview and java

These settings apply only when `--tag=package-2017-12-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-12-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.consumption.v2017_12_30_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/consumption/mgmt-v2017_12_30_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-05 and java

These settings apply only when `--tag=package-2018-05 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-05' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.consumption.v2018_05_31
  output-folder: $(azure-libraries-for-java-folder)/sdk/consumption/mgmt-v2018_05_31
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-06 and java

These settings apply only when `--tag=package-2018-06 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-06' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.consumption.v2018_06_30
  output-folder: $(azure-libraries-for-java-folder)/sdk/consumption/mgmt-v2018_06_30
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-08 and java

These settings apply only when `--tag=package-2018-08 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-08' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.consumption.v2018_08_31
  output-folder: $(azure-libraries-for-java-folder)/sdk/consumption/mgmt-v2018_08_31
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-10 and java

These settings apply only when `--tag=package-2018-10 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-10' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.consumption.v2018_10_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/consumption/mgmt-v2018_10_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-01 and java

These settings apply only when `--tag=package-2019-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.consumption.v2019_01_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/consumption/mgmt-v2019_01_01
regenerate-manager: true
generate-interface: true
```

## Suppression

``` yaml
directive:
  - suppress: R4009
    from: consumption.json
    reason: SystemData properties does not fit into the consumption RP APIs as they dont really create any actual resources.  
```

## AzureResourceSchema

See configuration in [readme.azureresourceschema.md](./readme.azureresourceschema.md)

## Python

See configuration in [readme.python.md](./readme.python.md)
