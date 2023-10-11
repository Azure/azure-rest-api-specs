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
  - tag: package-migrate-2020-01
  - tag: package-migrate-2020-07
  - tag: package-hubmigrate-2020-05
  - tag: package-hubmigrate-2023-01
  - tag: package-migrateengine-2022-05
```


### Tag: package-2023-06

These settings apply only when `--tag=package-2023-06` is specified on the command line.

```yaml $(tag) == 'package-2023-06'
input-file:
  - Microsoft.OffAzure/stable/2023-06-06/migrate.json
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

### Tag: package-migrate-2020-01 and java

These settings apply only when `--tag=package-migrate-2020-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-migrate-2020-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.azuremigrate.v2020_01_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/azuremigrate/mgmt-v2020_01_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-migrate-2020-07 and java

These settings apply only when `--tag=package-migrate-2020-07 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-migrate-2020-07' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.azuremigrate.v2020_07_07
  output-folder: $(azure-libraries-for-java-folder)/sdk/azuremigrate/mgmt-v2020_07_07
regenerate-manager: true
generate-interface: true
```

### Tag: package-hubmigrate-2020-05 and java

These settings apply only when `--tag=package-hubmigrate-2020-05 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-hubmigrate-2020-05' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.azuremigrate.v2020_05_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/azuremigrate/mgmt-v2020_05_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-hubmigrate-2023-01 and java

These settings apply only when `--tag=package-hubmigrate-2023-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-hubmigrate-2023-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.azuremigrate.v2023_01_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/azuremigrate/mgmt-v2023_01_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-migrateengine-2022-05 and java

These settings apply only when `--tag=package-migrateengine-2022-05 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-migrateengine-2022-05' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.azuremigrate.v2022_05_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/azuremigrate/mgmt-v2022_05_01
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
tag: package-migrate-2019-10
```

### Tag: package-migrate-2018-02

These settings apply only when `--tag=package-migrate-2018-02` is specified on the command line.

``` yaml $(tag) == 'package-migrate-2018-02'
input-file:
- Microsoft.Migrate/AssessmentProjects/stable/2018-02-02/migrate.json
```

### Tag: package-migrate-2019-10

These settings apply only when `--tag=package-migrate-2019-10` is specified on the command line.

``` yaml $(tag) == 'package-migrate-2019-10'
input-file:
- Microsoft.Migrate/AssessmentProjects/stable/2019-10-01/migrate.json
```

### Tag: package-migrate-2017-11

These settings apply only when `--tag=package-migrate-2017-11` is specified on the command line.

``` yaml $(tag) == 'package-migrate-2017-11'
input-file:
- Microsoft.Migrate/AssessmentProjects/preview/2017-11-11-preview/migrate.json
```

### Tag: package-migrate-2020-01

These settings apply only when `--tag=package-migrate-2020-01` is specified on the command line.

``` yaml $(tag) == 'package-migrate-2020-01'
input-file:
- Microsoft.OffAzure/stable/2020-01-01/migrate.json
```

### Tag: package-migrate-2020-07

These settings apply only when `--tag=package-migrate-2020-07` is specified on the command line.

``` yaml $(tag) == 'package-migrate-2020-07'
input-file:
- Microsoft.OffAzure/stable/2020-07-07/migrate.json
```

### Tag: package-hubmigrate-2020-05

These settings apply only when `--tag=package-hubmigrate-2020-05` is specified on the command line.

``` yaml $(tag) == 'package-hubmigrate-2020-05'
input-file:
- Microsoft.Migrate/MigrateProjects/stable/2020-05-01/hubmigrate.json
```

### Tag: package-hubmigrate-2023-01

These settings apply only when `--tag=package-hubmigrate-2023-01` is specified on the command line.

``` yaml $(tag) == 'package-hubmigrate-2023-01'
input-file:
- Microsoft.Migrate/MigrateProjects/stable/2023-01-01/hubmigrate.json
```

### Tag: package-migrateengine-2022-05

These settings apply only when `--tag=package-migrateengine-2022-05` is specified on the command line.

``` yaml $(tag) == 'package-migrateengine-2022-05'
input-file:
- Microsoft.Migrate/MordernizeProjects/preview/2022-05-01-preview/migrateEngine.json
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
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## Go

See configuration in [readme.go.md](./readme.go.md)
