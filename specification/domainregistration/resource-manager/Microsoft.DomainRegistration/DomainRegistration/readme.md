# DomainRegistration

> see https://aka.ms/autorest

This is the AutoRest configuration file for DomainRegistration.

The App service RP comprises of services where each service has its own tag.
Hence, each sub-service has its own swagger spec.

All of them are tied together using this configuration and are packaged together into one compute client library.
This makes it easier for customers to download one (NuGet/npm/pip/maven/gem) compute client library package rather than installing individual packages for each sub service.

---

## Getting Started

To build the SDK for DomainRegistration, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the DomainRegistration API.

```yaml
title: DomainRegistrationClient
description: Domain Registration Client
openapi-type: arm
tag: package-2024-11
```

### Tag: package-2024-11

These settings apply only when `--tag=package-2024-11` is specified on the command line.

```yaml $(tag) == 'package-2024-11'
input-file:
  - stable/2024-11-01/openapi.json
```

### Tag: package-2024-04

These settings apply only when `--tag=package-2024-04` is specified on the command line.

```yaml $(tag) == 'package-2024-04'
input-file:
  - stable/2024-04-01/DomainRegistrationProvider.json
  - stable/2024-04-01/Domains.json
  - stable/2024-04-01/TopLevelDomains.json
  - stable/2024-04-01/CommonDefinitions.json
```

### Tag: package-2023-12

These settings apply only when `--tag=package-2023-12` is specified on the command line.

```yaml $(tag) == 'package-2023-12'
input-file:
  - stable/2023-12-01/Domains.json
  - stable/2023-12-01/TopLevelDomains.json
  - stable/2023-12-01/DomainRegistrationProvider.json
  - stable/2023-12-01/CommonDefinitions.json
directive:
  # suppress each RPC 3016 error
  - suppress: R4009
    from: Domains.json
    reason: SystemData will implement in next version.
  - suppress: R4009
    from: TopLevelDomains.json
    reason: SystemData will implement in next version.
  - suppress: R4009
    from: DomainRegistrationProvider.json
    reason: SystemData will implement in next version.
  - suppress: R4009
    from: CommonDefinitions.json
    reason: SystemData will implement in next version.
```

### Tag: package-2023-01

These settings apply only when `--tag=package-2023-01` is specified on the command line.

```yaml $(tag) == 'package-2023-01'
input-file:
  - stable/2023-01-01/Domains.json
  - stable/2023-01-01/TopLevelDomains.json
  - stable/2023-01-01/DomainRegistrationProvider.json
  - stable/2023-01-01/CommonDefinitions.json
directive:
  # suppress each RPC 3016 error
  - suppress: R4009
    from: Domains.json
    reason: SystemData will implement in next version.
  - suppress: R4009
    from: TopLevelDomains.json
    reason: SystemData will implement in next version.
  - suppress: R4009
    from: DomainRegistrationProvider.json
    reason: SystemData will implement in next version.
  - suppress: R4009
    from: CommonDefinitions.json
    reason: SystemData will implement in next version.
```

### Tag: package-2022-09

These settings apply only when `--tag=package-2022-09` is specified on the command line.

```yaml $(tag) == 'package-2022-09'
input-file:
  - stable/2022-09-01/Domains.json
  - stable/2022-09-01/TopLevelDomains.json
  - stable/2022-09-01/DomainRegistrationProvider.json
  - stable/2022-09-01/CommonDefinitions.json
directive:
  # suppress each RPC 3016 error
  - suppress: R4009
    from: Domains.json
    reason: SystemData will implement in next version.
  - suppress: R4009
    from: TopLevelDomains.json
    reason: SystemData will implement in next version.
  - suppress: R4009
    from: DomainRegistrationProvider.json
    reason: SystemData will implement in next version.
  - suppress: R4009
    from: CommonDefinitions.json
    reason: SystemData will implement in next version.
```

### Tag: package-2022-03

These settings apply only when `--tag=package-2022-03` is specified on the command line.

```yaml $(tag) == 'package-2022-03' || $(tag) == 'package-2022-03-only'
input-file:
    - stable/2022-03-01/Domains.json
    - stable/2022-03-01/TopLevelDomains.json
    - stable/2022-03-01/DomainRegistrationProvider.json
    - stable/2022-03-01/CommonDefinitions.json
directive:
  # suppress each RPC 3016 error
  - suppress: R4009
    from: Domains.json
    reason: SystemData will implement in next version.
  - suppress: R4009
    from: TopLevelDomains.json
    reason: SystemData will implement in next version.
  - suppress: R4009
    from: DomainRegistrationProvider.json
    reason: SystemData will implement in next version.
  - suppress: R4009
    from: CommonDefinitions.json
    reason: SystemData will implement in next version.
```

### Tag: package-2021-03

These settings apply only when `--tag=package-2021-03` is specified on the command line.

```yaml $(tag) == 'package-2021-03'  || $(tag) == 'package-2021-03-only'
input-file:
    - stable/2021-03-01/Domains.json
    - stable/2021-03-01/TopLevelDomains.json
    - stable/2021-03-01/DomainRegistrationProvider.json
    - stable/2021-03-01/CommonDefinitions.json
directive:
  # suppress each RPC 3016 error
  - suppress: R4009
    from: Domains.json
    reason: SystemData will implement in next version.
  - suppress: R4009
    from: TopLevelDomains.json
    reason: SystemData will implement in next version.
  - suppress: R4009
    from: DomainRegistrationProvider.json
    reason: SystemData will implement in next version.
  - suppress: R4009
    from: CommonDefinitions.json
    reason: SystemData will implement in next version.
```

### Tag: package-2021-02

These settings apply only when `--tag=package-2021-02` is specified on the command line.

```yaml $(tag) == 'package-2021-02' || $(tag) == 'package-2021-02-only'
input-file:
- stable/2021-02-01/Domains.json
- stable/2021-02-01/TopLevelDomains.json
- stable/2021-02-01/DomainRegistrationProvider.json
- stable/2021-02-01/CommonDefinitions.json
directive:
  # suppress each RPC 3016 error
  - suppress: R4009
    from: Domains.json
    reason: SystemData will implement in next version.
  - suppress: R4009
    from: TopLevelDomains.json
    reason: SystemData will implement in next version.
  - suppress: R4009
    from: DomainRegistrationProvider.json
    reason: SystemData will implement in next version.
  - suppress: R4009
    from: CommonDefinitions.json
    reason: SystemData will implement in next version.
```

### Tag: package-2021-01-15

These settings apply only when `--tag=package-2021-01-15` is specified on the command line.

```yaml $(tag) == 'package-2021-01-15' || $(tag) == 'package-2021-01-15-only'
input-file:
    - stable/2021-01-15/Domains.json
    - stable/2021-01-15/TopLevelDomains.json
    - stable/2021-01-15/DomainRegistrationProvider.json
    - stable/2021-01-15/CommonDefinitions.json
directive:
  # suppress each RPC 3016 error
  - suppress: R4009
    from: Domains.json
    reason: SystemData will implement in next version.
  - suppress: R4009
    from: TopLevelDomains.json
    reason: SystemData will implement in next version.
  - suppress: R4009
    from: DomainRegistrationProvider.json
    reason: SystemData will implement in next version.
  - suppress: R4009
    from: CommonDefinitions.json
    reason: SystemData will implement in next version.
```

### Tag: package-2021-01

These settings apply only when `--tag=package-2021-01` is specified on the command line.

```yaml $(tag) == 'package-2021-01' || $(tag) == 'package-2021-01-only'
input-file:
    - stable/2021-01-01/Domains.json
    - stable/2021-01-01/TopLevelDomains.json
    - stable/2021-01-01/DomainRegistrationProvider.json
    - stable/2021-01-01/CommonDefinitions.json
directive:
  # suppress each RPC 3016 error
  - suppress: R4009
    from: Domains.json
    reason: SystemData will implement in next version.
  - suppress: R4009
    from: TopLevelDomains.json
    reason: SystemData will implement in next version.
  - suppress: R4009
    from: DomainRegistrationProvider.json
    reason: SystemData will implement in next version.
  - suppress: R4009
    from: CommonDefinitions.json
    reason: SystemData will implement in next version.
```

### Tag: package-2020-12

These settings apply only when `--tag=package-2020-12` or `--tag=package-2020-12-only` is specified on the command line.
NOTE: Currently these tags are the same, but it will need to be split if any files from folders other than 2020-06-01 are included.

```yaml $(tag) == 'package-2020-12' || $(tag) == 'package-2020-12-only'
input-file:
    - stable/2020-12-01/Domains.json
    - stable/2020-12-01/TopLevelDomains.json
    - stable/2020-12-01/DomainRegistrationProvider.json
    - stable/2020-12-01/CommonDefinitions.json
directive:
  # suppress each RPC 3016 error
  - suppress: R4009
    from: Domains.json
    reason: SystemData will implement in next version.
  - suppress: R4009
    from: TopLevelDomains.json
    reason: SystemData will implement in next version.
  - suppress: R4009
    from: DomainRegistrationProvider.json
    reason: SystemData will implement in next version.
  - suppress: R4009
    from: CommonDefinitions.json
    reason: SystemData will implement in next version.
```

### Tag: package-2020-10

These settings apply only when `--tag=package-2020-10` or `--tag=package-2020-10-only` is specified on the command line.
NOTE: Currently these tags are the same, but it will need to be split if any files from folders other than 2020-06-01 are included.

```yaml $(tag) == 'package-2020-10' || $(tag) == 'package-2020-10-only'
input-file:
    - stable/2020-10-01/Domains.json
    - stable/2020-10-01/TopLevelDomains.json
    - stable/2020-10-01/DomainRegistrationProvider.json
    - stable/2020-10-01/CommonDefinitions.json
```

### Tag: package-2020-09

These settings apply only when `--tag=package-2020-09` or `--tag=package-2020-09-only` is specified on the command line.
NOTE: Currently these tags are the same, but it will need to be split if any files from folders other than 2020-06-01 are included.

```yaml $(tag) == 'package-2020-09' || $(tag) == 'package-2020-09-only'
input-file:
    - stable/2020-09-01/Domains.json
    - stable/2020-09-01/TopLevelDomains.json
    - stable/2020-09-01/DomainRegistrationProvider.json
    - stable/2020-09-01/CommonDefinitions.json
```

### Tag: package-2020-06

These settings apply only when `--tag=package-2020-06` or `--tag=package-2020-06-only` is specified on the command line.
NOTE: Currently these tags are the same, but it will need to be split if any files from folders other than 2019-08-01 are included.

```yaml $(tag) == 'package-2020-06' || $(tag) == 'package-2020-06-only'
input-file:
    - stable/2020-06-01/Domains.json
    - stable/2020-06-01/TopLevelDomains.json
    - stable/2020-06-01/DomainRegistrationProvider.json
    - stable/2020-06-01/CommonDefinitions.json
```

### Tag: package-2019-08

These settings apply only when `--tag=package-2019-08` or `--tag=package-2019-08-only` is specified on the command line.
NOTE: Currently these tags are the same, but it will need to be split if any files from folders other than 2019-08-01 are included.

```yaml $(tag) == 'package-2019-08' || $(tag) == 'package-2019-08-only'
input-file:
    - stable/2019-08-01/Domains.json
    - stable/2019-08-01/TopLevelDomains.json
    - stable/2019-08-01/DomainRegistrationProvider.json
    - stable/2019-08-01/CommonDefinitions.json
```

### Tag: package-2018-12

These settings apply only when `--tag=package-2018-12` is specified on the command line.

```yaml $(tag) == 'package-2018-12'
input-file:
    - stable/2018-02-01/Domains.json
    - stable/2018-02-01/TopLevelDomains.json
    - stable/2018-02-01/DomainRegistrationProvider.json
    - stable/2018-02-01/CommonDefinitions.json
```

### Tag: package-2018-11

These settings apply only when `--tag=package-2018-11` is specified on the command line.

```yaml $(tag) == 'package-2018-11'
input-file:
    - stable/2018-02-01/Domains.json
    - stable/2018-02-01/TopLevelDomains.json
    - stable/2018-02-01/DomainRegistrationProvider.json
    - stable/2018-02-01/CommonDefinitions.json
```

### Tag: package-2018-02

These settings apply only when `--tag=package-2018-02` is specified on the command line.

```yaml $(tag) == 'package-2018-02'
input-file:
    - stable/2018-02-01/Domains.json
    - stable/2018-02-01/TopLevelDomains.json
    - stable/2018-02-01/DomainRegistrationProvider.json
    - stable/2018-02-01/CommonDefinitions.json
```

### Tag: package-2018-02-only

These settings apply only when `--tag=package-2018-02` is specified on the command line.

```yaml $(tag) == 'package-2018-02-only'
input-file:
    - stable/2018-02-01/Domains.json
    - stable/2018-02-01/TopLevelDomains.json
    - stable/2018-02-01/DomainRegistrationProvider.json
    - stable/2018-02-01/CommonDefinitions.json
```

### Tag: package-2016-09

These settings apply only when `--tag=package-2016-09` is specified on the command line.

```yaml $(tag) == 'package-2016-09'
input-file:
    - stable/2015-04-01/Domains.json
    - stable/2015-04-01/TopLevelDomains.json
    - stable/2015-04-01/DomainRegistrationProvider.json
directive:
  # suppress each RPC 3019 error
  - where: $.definitions.TopLevelDomain.properties
    suppress: R3019
    reason: It's an old API, will resolve in next API version
    approved-by: "@ravbhatnagar"
```

### Tag: package-2015-04-only

These settings apply only when `--tag=package-2015-04-only` is specified on the command line.

```yaml $(tag) == 'package-2015-04-only'
input-file:
  - stable/2015-04-01/Domains.json
  - stable/2015-04-01/TopLevelDomains.json
  - stable/2015-04-01/DomainRegistrationProvider.json
directive:
  # suppress each RPC 3019 error
  - where: $.definitions.TopLevelDomain.properties
    suppress: R3019
    reason: It's an old API, will resolve in next API version
    approved-by: "@ravbhatnagar"
```

### Tag: package-2015-04-domain-registration

These settings apply only when `--tag=package-2015-04-domain-registration` is specified on the command line.

```yaml $(tag) == 'package-2015-04-domain-registration'
input-file:
  - stable/2015-04-01/Domains.json
  - stable/2015-04-01/TopLevelDomains.json
  - stable/2015-04-01/DomainRegistrationProvider.json
```

---

## Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

```yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## Java

See configuration in [readme.java.md](./readme.java.md)
