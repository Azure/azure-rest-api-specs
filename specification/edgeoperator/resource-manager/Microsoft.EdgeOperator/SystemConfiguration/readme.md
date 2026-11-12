# edgeoperator - SystemConfiguration

> see https://aka.ms/autorest

This is the AutoRest configuration file for Microsoft.EdgeOperator SystemConfiguration.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for SystemConfiguration.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2026-06-01-preview
```

### Tag: package-2026-06-01-preview

These settings apply only when `--tag=package-2026-06-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-06-01-preview'
title: Microsoft.EdgeOperator - Azure Local Disconnected Operations system configuration
input-file:
  - preview/2026-06-01-preview/systemConfiguration.json
```

### Suppressions

```yaml
suppressions:
  - code: AllProxyResourcesShouldHaveDelete
    from: systemConfiguration.json
    where: $.definitions.SystemConfiguration
    reason: SystemConfiguration is a singleton proxy resource that intentionally does not support DELETE. The active configuration can only be replaced via PUT /systemConfiguration/default.
  - code: TopLevelResourcesListBySubscription
    from: systemConfiguration.json
    where: $.definitions.SystemConfiguration
    reason: SystemConfiguration is a singleton resource whose only accepted name is 'default'. A list-by-subscription operation would always return at most that single instance and is intentionally unsupported.
directive:
  - suppress: OperationsAPIImplementation
    from: systemConfiguration.json
    where: $
    reason: Microsoft.EdgeOperator is a shared RP namespace split across multiple TypeSpec projects owned by the ALDO team (BillingConfigurations, SystemReadiness, ObservabilityConfiguration, SystemConfiguration). The /providers/Microsoft.EdgeOperator/operations API is published once from the SystemReadiness project, so sibling projects intentionally do not redeclare it. This rule (arm-resource-validation.operationsAPIImplementation) runs at Global scope with root given path $ and yields an empty location at the document root, so a narrower target such as $.paths does not match and the suppression must stay at $.
  - suppress: OperationsAPIImplementation
    from: preview/2026-06-01-preview/systemConfiguration.json
    where: $
    reason: Microsoft.EdgeOperator is a shared RP namespace split across multiple TypeSpec projects owned by the ALDO team (BillingConfigurations, SystemReadiness, ObservabilityConfiguration, SystemConfiguration). The /providers/Microsoft.EdgeOperator/operations API is published once from the SystemReadiness project, so sibling projects intentionally do not redeclare it. This rule (arm-resource-validation.operationsAPIImplementation) runs at Global scope with root given path $ and yields an empty location at the document root, so a narrower target such as $.paths does not match and the suppression must stay at $.
```

---
