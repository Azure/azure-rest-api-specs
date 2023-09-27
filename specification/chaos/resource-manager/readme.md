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
title: ChaosManagementClient
description: Chaos Management Client
openapi-type: arm
tag: package-preview-2023-09
```

### Tag: package-preview-2023-09

These settings apply only when `--tag=package-preview-2023-09` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-09'
input-file:
  - Microsoft.Chaos/preview/2023-09-01-preview/capabilities.json
  - Microsoft.Chaos/preview/2023-09-01-preview/capabilityTypes.json
  - Microsoft.Chaos/preview/2023-09-01-preview/experiments.json
  - Microsoft.Chaos/preview/2023-09-01-preview/operations.json
  - Microsoft.Chaos/preview/2023-09-01-preview/targetTypes.json
  - Microsoft.Chaos/preview/2023-09-01-preview/targets.json
  - Microsoft.Chaos/preview/2023-09-01-preview/operationStatuses.json
directive:
  - from: swagger-document
    where: "$.definitions.action"
    transform: >
      $["x-ms-client-name"] = "ChaosExperimentAction";
  - from: swagger-document
    where: "$.definitions.branch"
    transform: >
      $["x-ms-client-name"] = "ChaosExperimentBranch";
  - from: swagger-document
    where: "$.definitions.step"
    transform: >
      $["x-ms-client-name"] = "ChaosExperimentStep";
  - from: swagger-document
    where: "$.definitions.filter"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetFilter";
  - from: swagger-document
    where: "$.definitions.simpleFilter"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetSimpleFilter";
  - from: swagger-document
    where: "$.definitions.simpleFilterParameters"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetSimpleFilterParameters";
  - from: swagger-document
    where: "$.definitions.selector"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetSelector";
  - from: swagger-document
    where: "$.definitions.listSelector"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetListSelector";
  - from: swagger-document
    where: "$.definitions.querySelector"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetQuerySelector";
```

### Tag: package-2023-04-15-preview

These settings apply only when `--tag=package-2023-04-15-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-04-15-preview'
input-file:
  - Microsoft.Chaos/preview/2023-04-15-preview/capabilities.json
  - Microsoft.Chaos/preview/2023-04-15-preview/capabilityTypes.json
  - Microsoft.Chaos/preview/2023-04-15-preview/experiments.json
  - Microsoft.Chaos/preview/2023-04-15-preview/operations.json
  - Microsoft.Chaos/preview/2023-04-15-preview/targetTypes.json
  - Microsoft.Chaos/preview/2023-04-15-preview/targets.json
```

### Tag: package-2023-04-01-preview

These settings apply only when `--tag=package-2023-04-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-04-01-preview'
input-file:
  - Microsoft.Chaos/preview/2023-04-01-preview/capabilities.json
  - Microsoft.Chaos/preview/2023-04-01-preview/capabilityTypes.json
  - Microsoft.Chaos/preview/2023-04-01-preview/experiments.json
  - Microsoft.Chaos/preview/2023-04-01-preview/operations.json
  - Microsoft.Chaos/preview/2023-04-01-preview/targetTypes.json
  - Microsoft.Chaos/preview/2023-04-01-preview/targets.json
```

### Tag: package-2022-10-01-preview

These settings apply only when `--tag=package-2022-10-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2022-10-01-preview'
directive:
  - suppress: R3026
    reason: Patch is not implemented in this version.
    where:
      - $.definitions.experiment

input-file:
  - Microsoft.Chaos/preview/2022-10-01-preview/capabilities.json
  - Microsoft.Chaos/preview/2022-10-01-preview/capabilityTypes.json
  - Microsoft.Chaos/preview/2022-10-01-preview/experiments.json
  - Microsoft.Chaos/preview/2022-10-01-preview/operations.json
  - Microsoft.Chaos/preview/2022-10-01-preview/targetTypes.json
  - Microsoft.Chaos/preview/2022-10-01-preview/targets.json
```

### Tag: package-2022-07-01-preview

These settings apply only when `--tag=package-2022-07-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2022-07-01-preview'
directive:
  - suppress: R3026
    reason: Patch is not implemented in this version.
    where:
      - $.definitions.experiment

input-file:
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

input-file:
  - Microsoft.Chaos/preview/2021-09-15-preview/capabilities.json
  - Microsoft.Chaos/preview/2021-09-15-preview/experiments.json
  - Microsoft.Chaos/preview/2021-09-15-preview/operations.json
  - Microsoft.Chaos/preview/2021-09-15-preview/targets.json
  - Microsoft.Chaos/preview/2021-09-15-preview/targetTypes.json
  - Microsoft.Chaos/preview/2021-09-15-preview/capabilityTypes.json
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
  - repo: azure-powershell
```

## Az

See configuration in [readme.az.md](./readme.az.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)

## Suppression

```yaml
directive:
  - suppress: TopLevelResourcesListBySubscription
    where: $.definitions.target
    from: targets.json
    reason: |-
      We have the top level resource list by subscription operation here: https://github.com/mariohdez/azure-rest-api-specs/blob/5a870f3163ae6e9cc5ed33d40cfff61764050213/specification/chaos/resource-manager/Microsoft.Chaos/preview/2021-09-15-preview/targets.json#L37

      this is a false positive I believe.
  - suppress: TopLevelResourcesListBySubscription
    where: $.definitions.target
    from: targets.json
    reason: |-
      we defined the toplevelresourcelistbysubscription here:

      https://github.com/mariohdez/azure-rest-api-specs/blob/5a870f3163ae6e9cc5ed33d40cfff61764050213/specification/chaos/resource-manager/Microsoft.Chaos/preview/2021-09-15-preview/targets.json#L37
  - suppress: EnumInsteadOfBoolean
    where: $.definitions.Operation.properties.isDataAction
    from: types.json
    reason: We are consuming the type model declaration from "common". I don't think our service is responsible for updating this error... Plz push back otherwise.
```
