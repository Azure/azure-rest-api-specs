# chaos

> see https://aka.ms/autorest

This is the AutoRest configuration file for chaos.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the chaos.

```yaml
openapi-type: arm
tag: package-2022-07-01-preview
```

### Tag: package-2022-07-01-preview

These settings apply only when `--tag=package-2022-07-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2022-07-01-preview'
directive:
  - suppress: R3026
    reason: Patch is not implemented in this version.
    where:
      - $.definitions.experiment
  - suppress: R4017
    reason: Proxy resource is not discoverable at the subscription level.
    where:
      - $.definitions.target
      - $.definitions.artifactSetDefinition
      - $.definitions.artifactSetSnapshot

input-file:
  - Microsoft.Chaos/preview/2022-07-01-preview/artifacts.json
  - Microsoft.Chaos/preview/2022-07-01-preview/capabilities.json
  - Microsoft.Chaos/preview/2022-07-01-preview/experiments.json
  - Microsoft.Chaos/preview/2022-07-01-preview/operations.json
  - Microsoft.Chaos/preview/2022-07-01-preview/targets.json
  - Microsoft.Chaos/preview/2022-07-01-preview/targetTypes.json
  - Microsoft.Chaos/preview/2022-07-01-preview/capabilityTypes.json
```

### Tag: package-2021-09-15-preview

These settings apply only when `--tag=package-2021-09-15-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-09-15-preview'
directive:
  - suppress: R3026
    reason: Patch is not implemented in this version.
    where:
      - $.definitions.experiment
  - suppress: R4017
    reason: Proxy resource is not discoverable at the subscription level.
    where:
      - $.definitions.target
      - $.definitions.artifactSetDefinition
      - $.definitions.artifactSetSnapshot

input-file:
  - Microsoft.Chaos/preview/2021-09-15-preview/artifacts.json
  - Microsoft.Chaos/preview/2021-09-15-preview/capabilities.json
  - Microsoft.Chaos/preview/2021-09-15-preview/experiments.json
  - Microsoft.Chaos/preview/2021-09-15-preview/operations.json
  - Microsoft.Chaos/preview/2021-09-15-preview/targets.json
  - Microsoft.Chaos/preview/2021-09-15-preview/targetTypes.json
  - Microsoft.Chaos/preview/2021-09-15-preview/capabilityTypes.json
```

### Tag: package-2021-08-11-preview

These settings apply only when `--tag=package-2021-08-11-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-08-11-preview'
directive:
  - suppress: R3026
    reason: Patch is not implemented in this version.
    where:
      - $.definitions.experiment
  - suppress: R4017
    reason: Proxy resource is not discoverable at the subscription level.
    where:
      - $.definitions.target
      - $.definitions.artifactSetDefinition
      - $.definitions.artifactSetSnapshot

input-file:
  - Microsoft.Chaos/preview/2021-08-11-preview/artifacts.json
  - Microsoft.Chaos/preview/2021-08-11-preview/capabilities.json
  - Microsoft.Chaos/preview/2021-08-11-preview/experiments.json
  - Microsoft.Chaos/preview/2021-08-11-preview/operations.json
  - Microsoft.Chaos/preview/2021-08-11-preview/targets.json
```

### Tag: package-2021-07-05-preview

These settings apply only when `--tag=package-2021-07-05-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-07-05-preview'
directive:
  - suppress: R3026
    reason: Patch is not implemented in this version.
    where:
      - $.definitions.experiment
  - suppress: R4017
    reason: Proxy resource is not discoverable at the subscription level.
    where:
      - $.definitions.target
      - $.definitions.artifactSetDefinition
      - $.definitions.artifactSetSnapshot

input-file:
  - Microsoft.Chaos/preview/2021-07-05-preview/artifacts.json
  - Microsoft.Chaos/preview/2021-07-05-preview/capabilities.json
  - Microsoft.Chaos/preview/2021-07-05-preview/experiments.json
  - Microsoft.Chaos/preview/2021-07-05-preview/operations.json
  - Microsoft.Chaos/preview/2021-07-05-preview/targets.json
```

### Tag: package-2021-07-01-preview

These settings apply only when `--tag=package-2021-07-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-07-01-preview'
directive:
  - suppress: R3026
    reason: Patch is not implemented in this version.
    where:
      - $.definitions.experiment
  - suppress: R4017
    reason: Proxy resource is not discoverable at the subscription level.
    where:
      - $.definitions.target

input-file:
  - Microsoft.Chaos/preview/2021-07-01-preview/capabilities.json
  - Microsoft.Chaos/preview/2021-07-01-preview/experiments.json
  - Microsoft.Chaos/preview/2021-07-01-preview/operations.json
  - Microsoft.Chaos/preview/2021-07-01-preview/targets.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

```yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-resource-manager-schemas
  - repo: azure-cli-extensions
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)
