# Cdn

> see https://aka.ms/autorest

This is the AutoRest configuration file for Cdn.

---

## Getting Started

To build the SDK for Cdn, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the Cdn API.


``` yaml
title: CdnManagementClient
description: Cdn Management Client
openapi-type: arm
tag: package-2025-06
```

### Tag: package-2025-04
These settings apply only when `--tag=package-2025-06` is specified on the command line.

```yaml $(tag) == 'package-2025-06'
input-file:
  - Microsoft.Cdn/stable/2025-06-01/afdx.json
  - Microsoft.Cdn/stable/2025-06-01/cdn.json
  - Microsoft.Cdn/stable/2025-06-01/cdnwebapplicationfirewall.json
```

### Tag: package-preview-2025-05
These settings apply only when `--tag=package-preview-2025-05` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-05'
input-file:
  - Microsoft.Cdn/preview/2025-05-01-preview/afdwebapplicationfirewalldefinition.json
  - Microsoft.Cdn/preview/2025-05-01-preview/afdx.json
  - Microsoft.Cdn/preview/2025-05-01-preview/cdn.json
  - Microsoft.Cdn/preview/2025-05-01-preview/cdnwebapplicationfirewall.json
```

### Tag: package-2025-04
These settings apply only when `--tag=package-2025-04` is specified on the command line.

```yaml $(tag) == 'package-2025-04'
input-file:
  - Microsoft.Cdn/stable/2025-04-15/afdx.json
  - Microsoft.Cdn/stable/2025-04-15/cdn.json
  - Microsoft.Cdn/stable/2025-04-15/cdnwebapplicationfirewall.json
```

### Tag: package-preview-2025-01

These settings apply only when `--tag=package-preview-2025-01` is specified on the command line.
This version only contains managed identity origin authentication preview version.

```yaml $(tag) == 'package-preview-2025-01'
input-file:
  - Microsoft.Cdn/preview/2025-01-01-preview/afdx.json
  - Microsoft.Cdn/preview/2025-01-01-preview/cdn.json
  - Microsoft.Cdn/preview/2025-01-01-preview/cdnwebapplicationfirewall.json
```

### Tag: package-preview-2024-07

These settings apply only when `--tag=package-preview-2024-07` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-07'
input-file:
  - Microsoft.Cdn/preview/2024-07-22-preview/edgeaction.json
suppressions:
  - code: OperationsAPIImplementation
    reason: Operation APIs for Microsoft.Cdn are to be defined in cdn swagger
```

### Tag: package-2024-09

These settings apply only when `--tag=package-2024-09` is specified on the command line.

```yaml $(tag) == 'package-2024-09'
input-file:
  - Microsoft.Cdn/stable/2024-09-01/afdx.json
  - Microsoft.Cdn/stable/2024-09-01/cdn.json
  - Microsoft.Cdn/stable/2024-09-01/cdnwebapplicationfirewall.json
suppressions:
  - code: MISSING_RESOURCE_ID
    reason: Keeping it for legacy tooling
```

### Tag: package-preview-2024-06

These settings apply only when `--tag=package-preview-2024-06` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-06'
input-file:
  - Microsoft.Cdn/preview/2024-06-01-preview/afdx.json
  - Microsoft.Cdn/preview/2024-06-01-preview/cdn.json
  - Microsoft.Cdn/preview/2024-06-01-preview/cdnwebapplicationfirewall.json
```

### Tag: package-preview-2024-05

These settings apply only when `--tag=package-preview-2024-05` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-05'
input-file:
  - Microsoft.Cdn/preview/2024-05-01-preview/afdx.json
  - Microsoft.Cdn/preview/2024-05-01-preview/cdn.json
  - Microsoft.Cdn/preview/2024-05-01-preview/cdnwebapplicationfirewall.json
```

### Tag: package-2024-02

These settings apply only when `--tag=package-2024-02` is specified on the command line.

```yaml $(tag) == 'package-2024-02'
input-file:
  - Microsoft.Cdn/stable/2024-02-01/afdx.json
  - Microsoft.Cdn/stable/2024-02-01/cdn.json
  - Microsoft.Cdn/stable/2024-02-01/cdnwebapplicationfirewall.json
```
### Tag: package-preview-2023-07

These settings apply only when `--tag=package-preview-2023-07` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-07'
input-file:
  - Microsoft.Cdn/preview/2023-07-01-preview/afdx.json
  - Microsoft.Cdn/preview/2023-07-01-preview/cdn.json
  - Microsoft.Cdn/preview/2023-07-01-preview/cdnwebapplicationfirewall.json

suppressions:
  - code: PutRequestResponseSchemeArm
    reason: False alarm. PUT request body is not superset of GET response body. We also do not support PATCH on keyGroups resource by design.  
```

### Tag: package-2023-05

These settings apply only when `--tag=package-2023-05` is specified on the command line.

```yaml $(tag) == 'package-2023-05'
input-file:
  - Microsoft.Cdn/stable/2023-05-01/afdx.json
  - Microsoft.Cdn/stable/2023-05-01/cdn.json
  - Microsoft.Cdn/stable/2023-05-01/cdnwebapplicationfirewall.json
```
### Tag: package-preview-2022-11

These settings apply only when `--tag=package-preview-2022-11` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-11'
input-file:
  - Microsoft.Cdn/preview/2022-11-01-preview/afdx.json
  - Microsoft.Cdn/preview/2022-11-01-preview/cdn.json
  - Microsoft.Cdn/preview/2022-11-01-preview/cdnwebapplicationfirewall.json
```

### Tag: package-preview-2022-05

These settings apply only when `--tag=package-preview-2022-05` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-05'
input-file:
  - Microsoft.Cdn/preview/2022-05-01-preview/afdx.json
  - Microsoft.Cdn/preview/2022-05-01-preview/cdn.json
  - Microsoft.Cdn/preview/2022-05-01-preview/cdnwebapplicationfirewall.json
```

### Tag: package-2021-06

These settings apply only when `--tag=package-2021-06` is specified on the command line.

``` yaml $(tag) == 'package-2021-06'
input-file:
  - Microsoft.Cdn/stable/2021-06-01/afdx.json
  - Microsoft.Cdn/stable/2021-06-01/cdn.json
  - Microsoft.Cdn/stable/2021-06-01/cdnwebapplicationfirewall.json
```

### Tag: package-2020-09

These settings apply only when `--tag=package-2020-09` is specified on the command line.

``` yaml $(tag) == 'package-2020-09'
input-file:
- Microsoft.Cdn/stable/2020-09-01/cdn.json
- Microsoft.Cdn/stable/2020-09-01/afdx.json
- Microsoft.Cdn/stable/2020-09-01/cdnwebapplicationfirewall.json
```

### Tag: package-2020-04

These settings apply only when `--tag=package-2020-04` is specified on the command line.

``` yaml $(tag) == 'package-2020-04'
input-file:
- Microsoft.Cdn/stable/2020-04-15/cdn.json
- Microsoft.Cdn/stable/2020-04-15/cdnwebapplicationfirewall.json
```

### Tag: package-2019-12

These settings apply only when `--tag=package-2019-12` is specified on the command line.

``` yaml $(tag) == 'package-2019-12'
input-file:
- Microsoft.Cdn/stable/2019-12-31/cdn.json
```

### Tag: package-2019-06-preview

These settings apply only when `--tag=package-2019-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2019-06-preview'
input-file:
- Microsoft.Cdn/preview/2019-06-15-preview/cdn.json
- Microsoft.Cdn/preview/2019-06-15-preview/cdnwebapplicationfirewall.json
directive:
  - where:
      - $.paths
    suppress:
      - OperationsAPIImplementation
```

### Tag: package-2019-06

These settings apply only when `--tag=package-2019-06` is specified on the command line.

``` yaml $(tag) == 'package-2019-06'
input-file:
- Microsoft.Cdn/stable/2019-06-15/cdn.json
- Microsoft.Cdn/stable/2019-06-15/cdnwebapplicationfirewall.json
```

### Tag: package-2019-04

These settings apply only when `--tag=package-2019-04` is specified on the command line.

``` yaml $(tag) == 'package-2019-04'
input-file:
- Microsoft.Cdn/stable/2019-04-15/cdn.json
```

### Tag: package-2017-10

These settings apply only when `--tag=package-2017-10` is specified on the command line.

``` yaml $(tag) == 'package-2017-10'
input-file:
- Microsoft.Cdn/stable/2017-10-12/cdn.json
```

### Tag: package-2017-04

These settings apply only when `--tag=package-2017-04` is specified on the command line.

``` yaml $(tag) == 'package-2017-04'
input-file:
- Microsoft.Cdn/stable/2017-04-02/cdn.json
```

### Tag: package-2016-10

These settings apply only when `--tag=package-2016-10` is specified on the command line.

``` yaml $(tag) == 'package-2016-10'
input-file:
- Microsoft.Cdn/stable/2016-10-02/cdn.json
```

### Tag: package-2016-04

These settings apply only when `--tag=package-2016-04` is specified on the command line.

``` yaml $(tag) == 'package-2016-04'
input-file:
- Microsoft.Cdn/stable/2016-04-02/cdn.json
```

### Tag: package-2015-06

These settings apply only when `--tag=package-2015-06` is specified on the command line.

``` yaml $(tag) == 'package-2015-06'
input-file:
- Microsoft.Cdn/stable/2015-06-01/cdn.json
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
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## C#

See configuration in [readme.csharp.md](./readme.csharp.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

## Node

See configuration in [readme.node.md](./readme.node.md)

## Ruby

See configuration in [readme.ruby.md](./readme.ruby.md)
