# quantum

> see https://aka.ms/autorest

This is the AutoRest configuration file for quantum.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the quantum.

```yaml
openapi-type: data-plane
tag: package-2022-09-12-preview
```

### Tag: package-2019-11-04-preview

These settings apply only when `--tag=package-2019-11-04-preview` is specified on the command line.

```yaml $(tag) == 'package-2019-11-04-preview'
input-file:
  - Microsoft.Quantum/preview/2019-11-04-preview/quantum.json
```

### Tag: package-2021-05-06-preview

These settings apply only when `--tag=package-2021-05-06-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-05-06-preview'
input-file:
  - Microsoft.Quantum/preview/2021-05-06-preview/quantum.json
```

### Tag: package-2021-11-01-preview

These settings apply only when `--tag=package-2021-11-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-11-01-preview'
input-file:
  - Microsoft.Quantum/preview/2021-11-01-preview/quantum.json
```

### Tag: package-2022-09-12-preview

These settings apply only when `--tag=package-2022-09-12-preview` is specified on the command line.

```yaml $(tag) == 'package-2022-09-12-preview'
input-file:
  - Microsoft.Quantum/preview/2022-09-12-preview/quantum.json
```

---

# Code Generation

## Python

See configuration in [readme.python.md](./readme.python.md)

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)

