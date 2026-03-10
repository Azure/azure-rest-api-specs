# vsonline

> see https://aka.ms/autorest

This is the AutoRest configuration file for Azure Communication Services.

---

## Getting Started

To build the SDKs for Azure Communication Services, simply [Install AutoRest](https://aka.ms/autorest/install) or via `npm` (`npm install -g autorest`) and in this folder run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the Azure Communication Services API.

```yaml
title: CommunicationServiceManagementClient
openapi-type: arm
openapi-subtype: rpaas
tag: package-2026-03-18
```

### Tag: package-2026-03-18

These settings apply only when `--tag=package-2026-03-18` is specified on the command line.

```yaml $(tag) == 'package-2026-03-18'
input-file:
  - Microsoft.Communication/stable/2026-03-18/openapi.json
```

### Tag: package-preview-2025-09-01-preview

These settings apply only when `--tag=package-preview-2025-09-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-09-01-preview'
input-file:
  - Microsoft.Communication/preview/2025-09-01-preview/CommunicationServices.json
  - Microsoft.Communication/preview/2025-09-01-preview/Domains.json
  - Microsoft.Communication/preview/2025-09-01-preview/EmailServices.json
  - Microsoft.Communication/preview/2025-09-01-preview/Locations.json
  - Microsoft.Communication/preview/2025-09-01-preview/SenderUsernames.json
  - Microsoft.Communication/preview/2025-09-01-preview/SmtpUsernames.json
```

### Tag: package-2025-09-01

These settings apply only when `--tag=package-2025-09-01` is specified on the command line.

```yaml $(tag) == 'package-2025-09-01'
input-file:
  - Microsoft.Communication/stable/2025-09-01/openapi.json
```

### Tag: package-preview-2025-05-01-preview

These settings apply only when `--tag=package-preview-2025-05-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-05-01'
input-file:
  - Microsoft.Communication/preview/2025-05-01-preview/CommunicationServices.json
  - Microsoft.Communication/preview/2025-05-01-preview/Domains.json
  - Microsoft.Communication/preview/2025-05-01-preview/EmailServices.json
  - Microsoft.Communication/preview/2025-05-01-preview/Locations.json
  - Microsoft.Communication/preview/2025-05-01-preview/SenderUsernames.json
  - Microsoft.Communication/preview/2025-05-01-preview/SmtpUsernames.json
```

### Tag: package-2025-05-01

These settings apply only when `--tag=package-2025-05-01` is specified on the command line.

```yaml $(tag) == 'package-2025-05-01'
input-file:
  - Microsoft.Communication/stable/2025-05-01/CommunicationServices.json
  - Microsoft.Communication/stable/2025-05-01/Domains.json
  - Microsoft.Communication/stable/2025-05-01/EmailServices.json
  - Microsoft.Communication/stable/2025-05-01/SenderUsernames.json
```

### Tag: package-2023-04

These settings apply only when `--tag=package-2023-04` is specified on the command line.

``` yaml $(tag) == 'package-2023-04'
input-file:
  - Microsoft.Communication/stable/2023-04-01/CommunicationServices.json
  - Microsoft.Communication/stable/2023-04-01/Domains.json
  - Microsoft.Communication/stable/2023-04-01/EmailServices.json
  - Microsoft.Communication/stable/2023-04-01/SenderUsernames.json
```

### Tag: package-preview-2025-01-25

These settings apply only when `--tag=package-preview-2025-01-25-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-01-25'
input-file:
  - Microsoft.Communication/preview/2025-01-25-preview/CommunicationServices.json
  - Microsoft.Communication/preview/2025-01-25-preview/Locations.json
  - Microsoft.Communication/preview/2025-01-25-preview/Domains.json
  - Microsoft.Communication/preview/2025-01-25-preview/EmailServices.json
  - Microsoft.Communication/preview/2025-01-25-preview/SenderUsernames.json
  - Microsoft.Communication/preview/2025-01-25-preview/SmtpUsernames.json
```

### Tag: package-preview-2024-11-01

These settings apply only when `--tag=package-preview-2024-11-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-11-01'
input-file:
  - Microsoft.Communication/preview/2024-11-01-preview/CommunicationServices.json
  - Microsoft.Communication/preview/2024-11-01-preview/Domains.json
  - Microsoft.Communication/preview/2024-11-01-preview/EmailServices.json
  - Microsoft.Communication/preview/2024-11-01-preview/SenderUsernames.json
  - Microsoft.Communication/preview/2024-11-01-preview/SmtpUsernames.json
```

### Tag: package-preview-2024-09-01

These settings apply only when `--tag=package-preview-2024-09-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-09-01'
input-file:
  - Microsoft.Communication/preview/2024-09-01-preview/CommunicationServices.json
  - Microsoft.Communication/preview/2024-09-01-preview/Domains.json
  - Microsoft.Communication/preview/2024-09-01-preview/EmailServices.json
  - Microsoft.Communication/preview/2024-09-01-preview/SenderUsernames.json
  - Microsoft.Communication/preview/2024-09-01-preview/SmtpUsernames.json
```

### Tag: package-preview-2023-12

These settings apply only when `--tag=package-preview-2023-12` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-12'
input-file:
  - Microsoft.Communication/preview/2023-12-25-preview/CommunicationServices.json
  - Microsoft.Communication/preview/2023-12-25-preview/Domains.json
  - Microsoft.Communication/preview/2023-12-25-preview/EmailServices.json
  - Microsoft.Communication/preview/2023-12-25-preview/SenderUsernames.json
```

### Tag: package-preview-2024-01

These settings apply only when `--tag=package-preview-2024-01` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-01'
input-file:
  - Microsoft.Communication/preview/2024-01-01-preview/CommunicationServicesGccm.json
```

### Tag: package-preview-2024-01-private

These settings apply only when `--tag=package-preview-2024-01-private` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-01-private'
input-file:
  - Microsoft.Communication/preview/2024-01-01-preview/CommunicationServicesGccm-private.json
```

### Tag: package-preview-2023-11-21

These settings apply only when `--tag=package-preview-2023-11-21` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-11-21'
input-file:
  - Microsoft.Communication/preview/2023-11-21-preview/CommunicationServices.json
  - Microsoft.Communication/preview/2023-11-21-preview/Domains.json
  - Microsoft.Communication/preview/2023-11-21-preview/EmailServices.json
  - Microsoft.Communication/preview/2023-11-21-preview/SenderUsernames.json
```

### Tag: package-preview-2023-11

These settings apply only when `--tag=package-preview-2023-11` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-11'
input-file:
  - Microsoft.Communication/preview/2023-11-06-preview/CommunicationServices.json
  - Microsoft.Communication/preview/2023-11-06-preview/Domains.json
  - Microsoft.Communication/preview/2023-11-06-preview/EmailServices.json
  - Microsoft.Communication/preview/2023-11-06-preview/SenderUsernames.json
```

### Tag: package-preview-2023-06

These settings apply only when `--tag=package-preview-2023-06` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-06'
input-file:
  - Microsoft.Communication/preview/2023-06-01-preview/CommunicationServices.json
  - Microsoft.Communication/preview/2023-06-01-preview/Domains.json
  - Microsoft.Communication/preview/2023-06-01-preview/EmailServices.json
  - Microsoft.Communication/preview/2023-06-01-preview/SenderUsernames.json
  - Microsoft.Communication/preview/2023-06-01-preview/SuppressionLists.json
```

### Tag: package-preview-2023-04

These settings apply only when `--tag=package-preview-2023-04` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-04'
input-file:
  - Microsoft.Communication/preview/2023-04-01-preview/CommunicationServices.json
  - Microsoft.Communication/preview/2023-04-01-preview/Domains.json
  - Microsoft.Communication/preview/2023-04-01-preview/EmailServices.json
  - Microsoft.Communication/preview/2023-04-01-preview/SenderUsernames.json
```

### Tag: package-2023-03

These settings apply only when `--tag=package-2023-03` is specified on the command line.

```yaml $(tag) == 'package-2023-03'
input-file:
  - Microsoft.Communication/stable/2023-03-31/CommunicationServices.json
  - Microsoft.Communication/stable/2023-03-31/Domains.json
  - Microsoft.Communication/stable/2023-03-31/EmailServices.json
  - Microsoft.Communication/stable/2023-03-31/SenderUsernames.json
```

### Tag: package-preview-2023-03

These settings apply only when `--tag=package-preview-2023-03` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-03'
input-file:
  - Microsoft.Communication/preview/2023-03-01-preview/CommunicationServices.json
  - Microsoft.Communication/preview/2023-03-01-preview/Domains.json
  - Microsoft.Communication/preview/2023-03-01-preview/EmailServices.json
  - Microsoft.Communication/preview/2023-03-01-preview/SenderUsernames.json
```

### Tag: package-preview-2022-10

These settings apply only when `--tag=package-preview-2022-10` is specified on the command line.

```yaml $(tag) == 'package-preview-2022-10'
input-file:
  - Microsoft.Communication/preview/2022-10-01-preview/CommunicationServices.json
  - Microsoft.Communication/preview/2022-10-01-preview/Domains.json
  - Microsoft.Communication/preview/2022-10-01-preview/EmailServices.json
```

### Tag: package-preview-2022-07

These settings apply only when `--tag=package-preview-2022-07` is specified on the command line.

```yaml $(tag) == 'package-preview-2022-07'
input-file:
  - Microsoft.Communication/preview/2022-07-01-preview/CommunicationServices.json
  - Microsoft.Communication/preview/2022-07-01-preview/Domains.json
  - Microsoft.Communication/preview/2022-07-01-preview/EmailServices.json
```

### Tag: package-preview-2022-03-29

These settings apply only when `--tag=package-preview-2022-03-29` is specified on the command line.

```yaml $(tag) == 'package-preview-2022-03'
input-file:
  - Microsoft.Communication/preview/2022-03-29-preview/CommunicationServices.json
  - Microsoft.Communication/preview/2022-03-29-preview/Domains.json
  - Microsoft.Communication/preview/2022-03-29-preview/EmailServices.json
```

### Tag: package-preview-2021-10

These settings apply only when `--tag=package-preview-2021-10` is specified on the command line.

```yaml $(tag) == 'package-preview-2021-10'
input-file:
  - Microsoft.Communication/preview/2021-10-01-preview/CommunicationServices.json
  - Microsoft.Communication/preview/2021-10-01-preview/EmailServices.json
  - Microsoft.Communication/preview/2021-10-01-preview/Domains.json
```

### Tag: package-2020-08-20

These settings apply only when `--tag=package-2020-08-20` is specified on the command line.

```yaml $(tag) == 'package-2020-08-20'
input-file:
  - Microsoft.Communication/stable/2020-08-20/CommunicationService.json
  - Microsoft.Communication/stable/2020-08-20/CommunicationService-private.json
```

### Tag: package-2020-08-20-private

These settings apply only when `--tag=package-2020-08-20-private` is specified on the command line.

```yaml $(tag) == 'package-2020-08-20-private'
input-file:
  - Microsoft.Communication/stable/2020-08-20/CommunicationService-private.json
```

### Tag: package-2020-08-20-preview

These settings apply only when `--tag=package-2020-08-20-preview` is specified on the command line.

```yaml $(tag) == 'package-2020-08-20-preview'
input-file:
  - Microsoft.Communication/preview/2020-08-20-preview/CommunicationService.json
```

### Tag: package-2020-08-20-preview-private

These settings apply only when `--tag=package-2020-08-20-preview-private` is specified on the command line.

```yaml $(tag) == 'package-2020-08-20-preview-private'
input-file:
  - Microsoft.Communication/preview/2020-08-20-preview/CommunicationService-private.json
```

### Tag: package-2019-10-10-preview

These settings apply only when `--tag=package-2019-10-10-preview` is specified on the command line.

```yaml $(tag) == 'package-2019-10-10-preview'
input-file:
  - Microsoft.Communication/preview/2019-10-10-preview/CommunicationService.json
```

### Tag: package-2019-10-10-preview-private

These settings apply only when `--tag=package-2019-10-10-preview-private` is specified on the command line.

```yaml $(tag) == 'package-2019-10-10-preview-private'
input-file:
  - Microsoft.Communication/preview/2019-10-10-preview/CommunicationService-private.json
```

### Tag: package-2021-09-09-privatepreview

These settings apply only when `--tag=package-2021-09-09-privatepreview` is specified on the command line.

```yaml $(tag) == 'package-2021-09-09-privatepreview' && $(generate-private)
input-file:
  - Microsoft.Communication/preview/2021-09-09-privatepreview/EventGridFilters.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

```yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-go-track2
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-java
  - repo: azure-cli-extensions
  - repo: azure-powershell

    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_vsonline']
```

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Typescript

See configuration in [readme.typescript.md](./readme.typescript.md)

## Az

See configuration in [readme.az.md](./readme.az.md)

## Cli

See configuration in [readme.cli.md](./readme.cli.md)
