# RedisEnterprise

> see https://aka.ms/autorest

This is the AutoRest configuration file for redisenterprise.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the RedisEnterprise API.

``` yaml
openapi-type: arm
tag: package-preview-2025-05-01
```


### Tag: package-preview-2025-05-01

These settings apply only when `--tag=package-preview-2025-05-01` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-05-01'
input-file:
  - Microsoft.Cache/preview/2025-05-01-preview/redisenterprise.json
```

### Tag: package-2025-04-01

These settings apply only when `--tag=package-2025-04-01` is specified on the command line.

```yaml $(tag) == 'package-2025-04-01'
input-file:
  - Microsoft.Cache/stable/2025-04-01/redisenterprise.json
```

### Tag: package-2024-10

These settings apply only when `--tag=package-2024-10` is specified on the command line.

```yaml $(tag) == 'package-2024-10'
input-file:
  - Microsoft.Cache/stable/2024-10-01/redisenterprise.json
```

### Tag: package-2024-02

These settings apply only when `--tag=package-2024-02` is specified on the command line.

```yaml $(tag) == 'package-2024-02'
input-file:
  - Microsoft.Cache/stable/2024-02-01/redisenterprise.json
```

### Tag: package-preview-2024-09

These settings apply only when `--tag=package-preview-2024-09` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-09'
input-file:
  - Microsoft.Cache/preview/2024-09-01-preview/redisenterprise.json
```

### Tag: package-preview-2024-06

These settings apply only when `--tag=package-preview-2024-06` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-06'
input-file:
  - Microsoft.Cache/preview/2024-06-01-preview/redisenterprise.json
```

### Tag: package-preview-2024-03

These settings apply only when `--tag=package-preview-2024-03` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-03'
input-file:
  - Microsoft.Cache/preview/2024-03-01-preview/redisenterprise.json
```

### Tag: package-2023-11

These settings apply only when `--tag=package-2023-11` is specified on the command line.

``` yaml $(tag) == 'package-2023-11'
input-file:
  - Microsoft.Cache/stable/2023-11-01/redisenterprise.json
```

### Tag: package-preview-2023-10

These settings apply only when `--tag=package-preview-2023-10` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-10'
input-file:
  - Microsoft.Cache/preview/2023-10-01-preview/redisenterprise.json
```

### Tag: package-preview-2023-08

These settings apply only when `--tag=package-preview-2023-08` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-08'
input-file:
  - Microsoft.Cache/preview/2023-08-01-preview/redisenterprise.json
```

### Tag: package-2023-07

These settings apply only when `--tag=package-2023-07` is specified on the command line.

``` yaml $(tag) == 'package-2023-07'
input-file:
  - Microsoft.Cache/stable/2023-07-01/redisenterprise.json
```

### Tag: package-preview-2023-03

These settings apply only when `--tag=package-preview-2023-03` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-03'
input-file:
  - Microsoft.Cache/preview/2023-03-01-preview/redisenterprise.json
```

### Tag: package-preview-2022-11

These settings apply only when `--tag=package-preview-2022-11` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-11'
input-file:
  - Microsoft.Cache/preview/2022-11-01-preview/redisenterprise.json
```

### Tag: package-2022-01

These settings apply only when `--tag=package-2022-01` is specified on the command line.

``` yaml $(tag) == 'package-2022-01'
input-file:
  - Microsoft.Cache/stable/2022-01-01/redisenterprise.json
```

### Tag: package-2021-08

These settings apply only when `--tag=package-2021-08` is specified on the command line.

``` yaml $(tag) == 'package-2021-08'
input-file:
  - Microsoft.Cache/stable/2021-08-01/redisenterprise.json
```

### Tag: package-preview-2021-02

These settings apply only when `--tag=package-preview-2021-02` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-02'
input-file:
  - Microsoft.Cache/preview/2021-02-01-preview/redisenterprise.json
```

### Tag: package-2021-03

These settings apply only when `--tag=package-2021-03` is specified on the command line.

``` yaml $(tag) == 'package-2021-03'
input-file:
  - Microsoft.Cache/stable/2021-03-01/redisenterprise.json
```

### Tag: package-2020-10-01-preview

These settings apply only when `--tag=package-2020-10-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-10-01-preview'
input-file:
  - Microsoft.Cache/preview/2020-10-01-preview/redisenterprise.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_redisenterprise']
  - repo: azure-resource-manager-schemas
  - repo: azure-cli-extensions
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
