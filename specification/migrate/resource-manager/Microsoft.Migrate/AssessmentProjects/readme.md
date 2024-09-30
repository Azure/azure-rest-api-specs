# Azure Migrate

> see https://aka.ms/autorest

This is the AutoRest configuration file for Azure Migrate.

---

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-migrate-2018-02
  - tag: package-migrate-2019-10
  - tag: package-migrate-2017-11
```

### Tag: package-preview-2023-05

These settings apply only when `--tag=package-preview-2023-05` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-05'
input-file:
  - Microsoft.Migrate/AssessmentProjects/preview/2023-05-01-preview/migrate.json
suppressions:
  - code: AvoidAdditionalProperties
    reason: Migrate feature is widely adopted and requires additionalProperties for these swagger properties.
  - code: ProvisioningStateMustBeReadOnly
    reason: The current swagger version only modifies the resources which do not have Provisioning states as readOnly and not introducing any new Resources, These are incorrectly flagged for previous versions.
  - code: UnSupportedPatchProperties
    reason: There is no patch operation that is introduced in this swagger version where it is not readOnly. This is incorrectly flagged for previous versions. 
```

### Tag: package-migrate-2023-04

These settings apply only when `--tag=package-migrate-2023-04` is specified on the command line.

```yaml $(tag) == 'package-migrate-2023-04'
input-file:
  - preview/2023-04-01-preview/migrate.json
suppressions:
  - code: AvoidAdditionalProperties
    reason: Migrate feature is widely adopted and requires additionalProperties for these swagger properties.
```

### Tag: package-migrate-2023-03

These settings apply only when `--tag=package-migrate-2023-03` is specified on the command line.

```yaml $(tag) == 'package-migrate-2023-03'
input-file:
  - stable/2023-03-15/migrate.json
```

### Tag: package-migrate-2018-02 and java

These settings apply only when `--tag=package-migrate-2018-02 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-migrate-2018-02' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.azuremigrate.v2018_02_02
  output-folder: $(azure-libraries-for-java-folder)/sdk/azuremigrate/mgmt-v2018_02_02
regenerate-manager: true
generate-interface: true
```

### Tag: package-migrate-2019-10 and java

These settings apply only when `--tag=package-migrate-2019-10 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-migrate-2019-10' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.azuremigrate.v2019_10_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/azuremigrate/mgmt-v2019_10_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-migrate-2017-11 and java

These settings apply only when `--tag=package-migrate-2017-11 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-migrate-2017-11' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.azuremigrate.v2017_11_11
  output-folder: $(azure-libraries-for-java-folder)/sdk/azuremigrate/mgmt-v2017_11_11
regenerate-manager: true
generate-interface: true
```

## Getting Started

To build the SDK for Migrate, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the API.

``` yaml
openapi-type: arm
tag: package-migrate-2023-04
```

### Tag: package-preview-2023-05

These settings apply only when `--tag=package-preview-2023-05` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-05'
input-file:
  - Microsoft.Migrate/AssessmentProjects/preview/2023-05-01-preview/migrate.json
suppressions:
  - code: AvoidAdditionalProperties
    reason: Migrate feature is widely adopted and requires additionalProperties for these swagger properties.
  - code: ProvisioningStateMustBeReadOnly
    reason: The current swagger version only modifies the resources which do not have Provisioning states as readOnly and not introducing any new Resources, These are incorrectly flagged for previous versions.
  - code: UnSupportedPatchProperties
    reason: There is no patch operation that is introduced in this swagger version where it is not readOnly. This is incorrectly flagged for previous versions. 
```

### Tag: package-migrate-2023-03

These settings apply only when `--tag=package-migrate-2023-03` is specified on the command line.

```yaml $(tag) == 'package-migrate-2023-03'
input-file:
  - stable/2023-03-15/migrate.json
```

### Tag: package-migrate-2023-04

These settings apply only when `--tag=package-migrate-2023-04` is specified on the command line.

```yaml $(tag) == 'package-migrate-2023-04'
input-file:
  - preview/2023-04-01-preview/migrate.json
```

### Tag: package-migrate-2018-02

These settings apply only when `--tag=package-migrate-2018-02` is specified on the command line.

``` yaml $(tag) == 'package-migrate-2018-02'
input-file:
- stable/2018-02-02/migrate.json
```

### Tag: package-migrate-2019-10

These settings apply only when `--tag=package-migrate-2019-10` is specified on the command line.

``` yaml $(tag) == 'package-migrate-2019-10'
input-file:
- stable/2019-10-01/migrate.json
```

### Tag: package-migrate-2017-11

These settings apply only when `--tag=package-migrate-2017-11` is specified on the command line.

``` yaml $(tag) == 'package-migrate-2017-11'
input-file:
- preview/2017-11-11-preview/migrate.json
```

## Suppression

``` yaml
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: migrate.json
    where: $.definitions.AssessedMachineProperties.properties.monthlyStandardSSDStorageCost
    reason: SSD is short form.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: migrate.json
    where: $.definitions.AssessmentProperties.properties.monthlyStandardSSDStorageCost
    reason: SSD is short form.
```

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net-track2
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)
