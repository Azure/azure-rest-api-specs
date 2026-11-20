# edgeoperator - SystemReadiness

> see https://aka.ms/autorest

This is the AutoRest configuration file for Microsoft.EdgeOperator SystemReadiness.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for SystemReadiness.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2026-06-01-preview
```

### Tag: package-2026-06-01-preview

These settings apply only when `--tag=package-2026-06-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-06-01-preview'
title: Microsoft.EdgeOperator - Azure Local Disconnected Operations system readiness
input-file:
  - preview/2026-06-01-preview/systemReadiness.json
```

### Suppressions

```yaml
suppressions:
  - code: AllProxyResourcesShouldHaveDelete
    from: systemReadiness.json
    where: $.definitions.SystemReadiness
    reason: SystemReadiness is a read-only, provider-computed singleton resource that intentionally supports GET only and does not support DELETE.
  - code: TopLevelResourcesListBySubscription
    from: systemReadiness.json
    where: $.definitions.SystemReadiness
    reason: SystemReadiness is a read-only, provider-computed singleton whose only accepted resource name is 'default'. A list-by-subscription operation would always return the single 'default' instance and carries no additional meaning, so it is intentionally not implemented.
```

---
