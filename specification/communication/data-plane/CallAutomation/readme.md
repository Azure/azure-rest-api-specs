# communicationservices

> see https://aka.ms/autorest

This is the AutoRest configuration file for communicationservices.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the communicationservices.

```yaml
openapi-type: data-plane
tag: package-2025-08-15-preview
```

### Tag: package-2022-04-07-preview

These settings apply only when `--tag=package-2022-04-07-preview` is specified on the command line.

```yaml $(tag) == 'package-2022-04-07-preview'
input-file:
  - preview/2022-04-07-preview/communicationservicescallautomation.json
title: Azure Communication Services
```

### Tag: package-2023-03-06

These settings apply only when `--tag=package-2023-03-06` is specified on the command line.

```yaml $(tag) == 'package-2023-03-06'
input-file:
  - stable/2023-03-06/communicationservicescallautomation.json
title:
  Azure Communication Services
```

### Tag: package-2023-06-15-preview

These settings apply only when `--tag=package-2023-06-15-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-06-15-preview'
input-file:
  - preview/2023-06-15-preview/communicationservicescallautomation.json
title:
  Azure Communication Services
```

### Tag: package-2023-10-15

These settings apply only when `--tag=package-2023-10-15` is specified on the command line.

```yaml $(tag) == 'package-2023-10-15'
input-file:
  - stable/2023-10-15/communicationservicescallautomation.json
title:
  Azure Communication Services
```

### Tag: package-2024-04-15

These settings apply only when `--tag=package-2024-04-15` is specified on the command line.

```yaml $(tag) == 'package-2024-04-15'
input-file:
  - stable/2024-04-15/communicationservicescallautomation.json
title:
  Azure Communication Services
```

### Tag: package-2024-06-15-preview

These settings apply only when `--tag=package-2024-06-15-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-06-15-preview'
input-file:
  - preview/2024-06-15-preview/communicationservicescallautomation.json
title:
  Azure Communication Services
suppressions:
  - code: LroExtension
    from: communicationservicescallautomation.json
    reason: Our LRO behavior does not fit the default behavior
```

### Tag: package-2024-09-15

These settings apply only when `--tag=package-2024-09-15` is specified on the command line.

```yaml $(tag) == 'package-2024-09-15'
input-file:
  - stable/2024-09-15/communicationservicescallautomation.json
title:
  Azure Communication Services
suppressions:
  - code: LroExtension
    from: communicationservicescallautomation.json
    reason: Our LRO behavior does not fit the default behavior
```

### Tag: package-2024-11-15-preview

These settings apply only when `--tag=package-2024-11-15-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-11-15-preview'
input-file:
  - preview/2024-11-15-preview/communicationservicescallautomation.json
title:
  Azure Communication Services
suppressions:
  - code: LroExtension
    from: communicationservicescallautomation.json
    reason: Our LRO behavior does not fit the default behavior
```

### Tag: package-2025-05-15

These settings apply only when `--tag=package-2025-05-15` is specified on the command line.

```yaml $(tag) == 'package-2025-05-15'
input-file:
  - stable/2025-05-15/communicationservicescallautomation.json
title:
  Azure Communication Services
suppressions:
  - code: LroExtension
    from: communicationservicescallautomation.json
    reason: Our LRO behavior does not fit the default behavior
```

### Tag: package-2025-03-30-preview

These settings apply only when `--tag=package-2025-03-30-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-03-30-preview'
input-file:
  - preview/2025-03-30-preview/communicationservicescallautomation.json
title:
  Azure Communication Services
suppressions:
  - code: LroExtension
    from: communicationservicescallautomation.json
    reason: Our LRO behavior does not fit the default behavior
```

### Tag: package-2025-06-15

These settings apply only when `--tag=package-2025-06-15` is specified on the command line.

```yaml $(tag) == 'package-2025-06-15'
input-file:
  - stable/2025-06-15/communicationservicescallautomation.json
title:
  Azure Communication Services
suppressions:
  - code: LroExtension
    from: communicationservicescallautomation.json
    reason: Our LRO behavior does not fit the default behavior
```

### Tag: package-2025-08-15-preview

These settings apply only when `--tag=package-2025-08-15-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-08-15-preview'
input-file:
  - preview/2025-08-15-preview/communicationservicescallautomation.json
title:
  Azure Communication Services
suppressions:
  - code: LroExtension
    from: communicationservicescallautomation.json
    reason: Our LRO behavior does not fit the default behavior
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)
