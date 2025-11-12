# containerstorage

> see https://aka.ms/autorest
> This is the AutoRest configuration file for ContainerServiceNodeCustomization.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`
> To see additional help and options, run:

> `autorest --help`
> For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the ContainerServices API.

```yaml
openapi-type: arm
tag: package-2025-09-02-preview
```

### Tag: package-2025-09-02-preview

These settings apply only when `--tag=package-2025-09-02-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-09-02-preview'
input-file:
  - preview/2025-09-02-preview/nodecustomization.json
```

### Tag: package-2025-08-02-preview

These settings apply only when `--tag=package-2025-08-02-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-08-02-preview'
input-file:
  - preview/2025-08-02-preview/nodecustomization.json
```

---

## C#

See configuration in [readme.csharp.md](./readme.csharp.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

## Suppression
