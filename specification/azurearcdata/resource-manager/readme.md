# azurearcdata

> see https://aka.ms/autorest

This is the AutoRest configuration file for azurearcdata.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the azurearcdata.

``` yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-preview-2025-03
```

``` yaml
directive:
  - suppress: ResourceNameRestriction
    from: azurearcdata.json
    reason: No Unicode support for attribute pattern regex on sqlServerInstanceName and others. This should be fixed by tooling.
```

``` yaml
directive:
  - suppress: ResourceNameRestriction
    from: sqlServerAvailabilityGroups.json
    reason: No Unicode support for attribute pattern regex on sqlServerInstanceName and others. This should be fixed by tooling.
```

### Tag: package-preview-2025-03

These settings apply only when `--tag=package-preview-2025-03-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-03'
input-file:
  - Microsoft.AzureArcData/preview/2025-03-01-preview/activeDirectoryConnectors.json
  - Microsoft.AzureArcData/preview/2025-03-01-preview/azurearcdata.json
  - Microsoft.AzureArcData/preview/2025-03-01-preview/common.json
  - Microsoft.AzureArcData/preview/2025-03-01-preview/dataControllers.json
  - Microsoft.AzureArcData/preview/2025-03-01-preview/failoverGroups.json
  - Microsoft.AzureArcData/preview/2025-03-01-preview/operations.json
  - Microsoft.AzureArcData/preview/2025-03-01-preview/postgresInstances.json
  - Microsoft.AzureArcData/preview/2025-03-01-preview/sqlManagedInstances.json
  - Microsoft.AzureArcData/preview/2025-03-01-preview/sqlServerAvailabilityGroups.json
  - Microsoft.AzureArcData/preview/2025-03-01-preview/sqlServerDatabases.json
  - Microsoft.AzureArcData/preview/2025-03-01-preview/sqlServerEsuLicenses.json
  - Microsoft.AzureArcData/preview/2025-03-01-preview/sqlServerInstances.json
  - Microsoft.AzureArcData/preview/2025-03-01-preview/sqlServerLicenses.json
```

### Tag: package-preview-2024-05

These settings apply only when `--tag=package-preview-2024-05` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-05'
input-file:
  - Microsoft.AzureArcData/preview/2024-05-01-preview/activeDirectoryConnectors.json
  - Microsoft.AzureArcData/preview/2024-05-01-preview/azurearcdata.json
  - Microsoft.AzureArcData/preview/2024-05-01-preview/common.json
  - Microsoft.AzureArcData/preview/2024-05-01-preview/dataControllers.json
  - Microsoft.AzureArcData/preview/2024-05-01-preview/failoverGroups.json
  - Microsoft.AzureArcData/preview/2024-05-01-preview/operations.json
  - Microsoft.AzureArcData/preview/2024-05-01-preview/postgresInstances.json
  - Microsoft.AzureArcData/preview/2024-05-01-preview/sqlManagedInstances.json
  - Microsoft.AzureArcData/preview/2024-05-01-preview/sqlServerAvailabilityGroups.json
  - Microsoft.AzureArcData/preview/2024-05-01-preview/sqlServerDatabases.json
  - Microsoft.AzureArcData/preview/2024-05-01-preview/sqlServerEsuLicenses.json
  - Microsoft.AzureArcData/preview/2024-05-01-preview/sqlServerInstances.json
  - Microsoft.AzureArcData/preview/2024-05-01-preview/sqlServerLicenses.json
```

### Tag: package-2024-01

These settings apply only when `--tag=package-2024-01` is specified on the command line.

```yaml $(tag) == 'package-2024-01'
input-file:
  - Microsoft.AzureArcData/stable/2024-01-01/activeDirectoryConnectors.json
  - Microsoft.AzureArcData/stable/2024-01-01/azurearcdata.json
  - Microsoft.AzureArcData/stable/2024-01-01/common.json
  - Microsoft.AzureArcData/stable/2024-01-01/dataControllers.json
  - Microsoft.AzureArcData/stable/2024-01-01/failoverGroups.json
  - Microsoft.AzureArcData/stable/2024-01-01/operations.json
  - Microsoft.AzureArcData/stable/2024-01-01/postgresInstances.json
  - Microsoft.AzureArcData/stable/2024-01-01/sqlManagedInstances.json
  - Microsoft.AzureArcData/stable/2024-01-01/sqlServerAvailabilityGroups.json
  - Microsoft.AzureArcData/stable/2024-01-01/sqlServerDatabases.json
  - Microsoft.AzureArcData/stable/2024-01-01/sqlServerInstances.json  
```

### Tag: package-preview-2023-01

These settings apply only when `--tag=package-preview-2023-01` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-01'
input-file:
  - Microsoft.AzureArcData/preview/2023-01-15-preview/activeDirectoryConnectors.json
  - Microsoft.AzureArcData/preview/2023-01-15-preview/azurearcdata.json
  - Microsoft.AzureArcData/preview/2023-01-15-preview/common.json
  - Microsoft.AzureArcData/preview/2023-01-15-preview/dataControllers.json
  - Microsoft.AzureArcData/preview/2023-01-15-preview/failoverGroups.json
  - Microsoft.AzureArcData/preview/2023-01-15-preview/operations.json
  - Microsoft.AzureArcData/preview/2023-01-15-preview/postgresInstances.json
  - Microsoft.AzureArcData/preview/2023-01-15-preview/sqlManagedInstances.json
  - Microsoft.AzureArcData/preview/2023-01-15-preview/sqlServerInstances.json
  - Microsoft.AzureArcData/preview/2023-01-15-preview/sqlServerDatabases.json
```

### Tag: package-preview-2022-06

These settings apply only when `--tag=package-preview-2022-06` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-06'
input-file:
  - Microsoft.AzureArcData/preview/2022-06-15-preview/activeDirectoryConnectors.json
  - Microsoft.AzureArcData/preview/2022-06-15-preview/azurearcdata.json
  - Microsoft.AzureArcData/preview/2022-06-15-preview/common.json
  - Microsoft.AzureArcData/preview/2022-06-15-preview/dataControllers.json
  - Microsoft.AzureArcData/preview/2022-06-15-preview/operations.json
  - Microsoft.AzureArcData/preview/2022-06-15-preview/postgresInstances.json
  - Microsoft.AzureArcData/preview/2022-06-15-preview/sqlManagedInstances.json
  - Microsoft.AzureArcData/preview/2022-06-15-preview/sqlServerInstances.json
  - Microsoft.AzureArcData/preview/2022-06-15-preview/sqlServerDatabases.json
```

### Tag: package-preview-2022-03

These settings apply only when `--tag=package-preview-2022-03` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-03'
input-file:
  - Microsoft.AzureArcData/preview/2022-03-01-preview/azurearcdata.json
  - Microsoft.AzureArcData/preview/2022-03-01-preview/common.json
  - Microsoft.AzureArcData/preview/2022-03-01-preview/dataControllers.json
  - Microsoft.AzureArcData/preview/2022-03-01-preview/operations.json
  - Microsoft.AzureArcData/preview/2022-03-01-preview/postgresInstances.json
  - Microsoft.AzureArcData/preview/2022-03-01-preview/sqlManagedInstances.json
  - Microsoft.AzureArcData/preview/2022-03-01-preview/sqlServerInstances.json
```

### Tag: package-2021-11-01

These settings apply only when `--tag=package-2021-11-01` is specified on the command line.

``` yaml $(tag) == 'package-2021-11-01'
input-file:
  - Microsoft.AzureArcData/stable/2021-11-01/azurearcdata.json
```

### Tag: package-2021-08-01

These settings apply only when `--tag=package-2021-08-01` is specified on the command line.

``` yaml $(tag) == 'package-2021-08-01'
input-file:
  - Microsoft.AzureArcData/stable/2021-08-01/azurearcdata.json
```

### Tag: package-preview-2021-07-01

These settings apply only when `--tag=package-preview-2021-07-01` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-07-01'
input-file:
  - Microsoft.AzureArcData/preview/2021-07-01-preview/azurearcdata.json
```

### Tag: package-preview-2021-06-01

These settings apply only when `--tag=package-preview-2021-06-01` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-06-01'
input-file:
  - Microsoft.AzureArcData/preview/2021-06-01-preview/azurearcdata.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_azurearcdata']
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## Ruby

See configuration in [readme.ruby.md](./readme.ruby.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)
