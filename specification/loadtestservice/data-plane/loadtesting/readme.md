# loadtestservice

> see https://aka.ms/autorest
This is the AutoRest configuration file for loadtestservice.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`
To see additional help and options, run:

> `autorest --help`
For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the loadtestservice.

```yaml
openapi-type: data-plane
tag: package-2022-11-01
title: LoadTestingClient
```

### Tag: package-2025-03-01-preview

These settings apply only when `--tag=package-2025-03-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-03-01-preview'
input-file:
  - preview/2025-03-01-preview/loadtestservice.json
suppressions:
  - code: AvoidAnonymousTypes
    from: loadtestservice.json
    reason: This is an incorrect failure due to a bug in the tool(https://github.com/Azure/typespec-azure/issues/2290)
```

### Tag: package-2024-12-01-preview

These settings apply only when `--tag=package-2024-12-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-12-01-preview'
input-file:
  - preview/2024-12-01-preview/loadtestservice.json
```

### Tag: package-2024-07-01-preview

These settings apply only when `--tag=package-2024-07-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-07-01-preview'
input-file:
  - preview/2024-07-01-preview/loadtestservice.json
```

### Tag: package-2024-05-01-preview

These settings apply only when `--tag=package-2024-05-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-05-01-preview'
input-file:
  - preview/2024-05-01-preview/loadtestservice.json
```


### Tag: package-2024-03-01-preview

These settings apply only when `--tag=package-2024-03-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-03-01-preview'
input-file:
  - preview/2024-03-01-preview/loadtestservice.json
```

### Tag: package-2023-04-01-preview

These settings apply only when `--tag=package-2023-04-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-04-01-preview'
input-file:
  - preview/2023-04-01-preview/loadtestservice.json
```

### Tag: package-2022-11-01

These settings apply only when `--tag=package-2022-11-01` is specified on the command line.

```yaml $(tag) == 'package-2022-11-01'
input-file:
  - stable/2022-11-01/loadtestservice.json
```
---