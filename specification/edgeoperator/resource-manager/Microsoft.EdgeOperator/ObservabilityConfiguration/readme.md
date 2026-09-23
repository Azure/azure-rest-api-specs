# edgeoperator - ObservabilityConfiguration

> see https://aka.ms/autorest

This is the AutoRest configuration file for Microsoft.EdgeOperator ObservabilityConfiguration.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for ObservabilityConfiguration.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2026-06-01-preview
```

### Tag: package-2026-06-01-preview

These settings apply only when `--tag=package-2026-06-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-06-01-preview'
title: Microsoft.EdgeOperator - Azure Local Disconnected Operations observability configuration
input-file:
  - preview/2026-06-01-preview/observabilityConfiguration.json
```

### Suppressions

```yaml
directive:
  - suppress: AllProxyResourcesShouldHaveDelete
    from: preview/2026-06-01-preview/observabilityConfiguration.json
    where: $.definitions.ObservabilityConfiguration
    reason: ObservabilityConfiguration is a singleton proxy resource that intentionally does not support DELETE. The resource can only be retrieved via GET.
  - suppress: TopLevelResourcesListBySubscription
    from: preview/2026-06-01-preview/observabilityConfiguration.json
    where: $.definitions.ObservabilityConfiguration
    reason: ObservabilityConfiguration is a singleton resource whose only accepted name is 'default'. A list-by-subscription operation would always return at most that single instance and is intentionally omitted when not exposed by the service surface.
  - suppress: RepeatedPathInfo
    from: observabilityConfiguration.json
    where: $.definitions.ObservabilityConfigurationProperties.properties.subscriptionId
    reason: The request URI subscriptionId is the ALDO operator subscription context. The body properties.subscriptionId is a required customer Azure subscription value for observability onboarding and targets a different subscription domain.
  - suppress: RepeatedPathInfo
    from: preview/2026-06-01-preview/observabilityConfiguration.json
    where: $.definitions.ObservabilityConfigurationProperties.properties.subscriptionId
    reason: The request URI subscriptionId is the ALDO operator subscription context. The body properties.subscriptionId is a required customer Azure subscription value for observability onboarding and targets a different subscription domain.
  - suppress: OperationsAPIImplementation
    from: observabilityConfiguration.json
    where: $
    reason: Microsoft.EdgeOperator is a shared RP namespace split across multiple TypeSpec projects owned by the ALDO team (BillingConfigurations, SystemReadiness, ObservabilityConfiguration). The /providers/Microsoft.EdgeOperator/operations API is published once from the SystemReadiness project, so sibling projects intentionally do not redeclare it. This rule (arm-resource-validation.operationsAPIImplementation) runs at Global scope with root given path $ and yields an empty location at the document root, so a narrower target such as $.paths does not match and the suppression must stay at $.
  - suppress: OperationsAPIImplementation
    from: preview/2026-06-01-preview/observabilityConfiguration.json
    where: $
    reason: Microsoft.EdgeOperator is a shared RP namespace split across multiple TypeSpec projects owned by the ALDO team (BillingConfigurations, SystemReadiness, ObservabilityConfiguration). The /providers/Microsoft.EdgeOperator/operations API is published once from the SystemReadiness project, so sibling projects intentionally do not redeclare it. This rule (arm-resource-validation.operationsAPIImplementation) runs at Global scope with root given path $ and yields an empty location at the document root, so a narrower target such as $.paths does not match and the suppression must stay at $.
```

---