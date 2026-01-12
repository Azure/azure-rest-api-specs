# edge

> see https://aka.ms/autorest

This is the AutoRest configuration file for edge.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the edge.

```yaml
openapi-type: arm
openapi-subtype: providerHub
tag: package-2025-06-01
```

### Tag: package-2025-06-01

These settings apply only when `--tag=package-2025-06-01` is specified on the command line.

```yaml $(tag) == 'package-2025-06-01'
input-file:
  - stable/2025-06-01/operations.json
```

### Tag: package-2025-03-01-preview

These settings apply only when `--tag=package-2025-03-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-03-01-preview'
input-file:
  - preview/2025-03-01-preview/operations.json
```

### Tag: package-2024-02-01-preview

These settings apply only when `--tag=package-2024-02-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-02-01-preview'
input-file:
  - preview/2024-02-01-preview/operations.json
```
---

# Code Generation

## Az

See configuration in [readme.az.md](./readme.az.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

