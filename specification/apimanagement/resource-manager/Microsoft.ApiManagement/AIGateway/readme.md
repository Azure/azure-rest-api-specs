# AI Gateway

> see https://aka.ms/autorest

This is the AutoRest configuration file for AI Gateway.

---

## Getting Started

To build the SDK for AI Gateway, install [AutoRest](https://aka.ms/autorest/install) and run `autorest` in this folder.

---

## Configuration

### Basic Information

```yaml
title: AIGatewayClient
description: AI Gateway Client
openapi-type: arm
tag: package-2026-11-01
```

### Tag: package-2026-11-01

These settings apply only when `--tag=package-2026-11-01` is specified on the command line.

```yaml $(tag) == 'package-2026-11-01'
input-file:
  - stable/2026-11-01/openapi.json
```

### Tag: package-preview-2026-09-01-preview

These settings apply only when `--tag=package-preview-2026-09-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2026-09-01-preview'
input-file:
  - preview/2026-09-01-preview/openapi.json
```

## Suppression

```yaml $(tag) == 'package-2026-11-01'
suppressions:
  - code: EnumInsteadOfBoolean
    from: openapi.json
    where:
      - $.definitions.AiGatewayToolServerProperties.properties.subscriptionRequired
      - $.definitions.AiGatewayToolServerUpdateProperties.properties.subscriptionRequired
      - $.definitions.AiGatewayTelemetryExporterProperties.properties.payloadCapture
      - $.definitions.AiGatewayTelemetryExporterUpdateProperties.properties.payloadCapture
      - $.definitions.AiGatewayPolicy.properties.preInvocation
      - $.definitions.AiGatewayPolicy.properties.postInvocation
      - $.definitions.AiGatewayPolicy.properties.allowCredentials
      - $.definitions.AiGatewayPolicy.properties.terminateUnmatchedRequest
      - $.definitions.AiGatewayPolicyUpdate.properties.preInvocation
      - $.definitions.AiGatewayPolicyUpdate.properties.postInvocation
      - $.definitions.AiGatewayPolicyUpdate.properties.allowCredentials
      - $.definitions.AiGatewayPolicyUpdate.properties.terminateUnmatchedRequest
    reason: These implemented fields are binary enable-or-disable and required-or-optional switches, not extensible states.
  - code: ValidFormats
    from: openapi.json
    where:
      - $.definitions.AiGatewayCostLimitOverride.properties.amount.format
      - $.definitions.AiGatewayCostLimitOverrideUpdate.properties.amount.format
      - $.definitions.AiGatewayPolicy.properties.amount.format
      - $.definitions.AiGatewayPolicyUpdate.properties.amount.format
    reason: Cost-limit amounts are monetary JSON numbers bound to System.Decimal by the RP. The contract explicitly excludes double to preserve decimal precision. TypeSpec decimal128 emits the decimal format; retain that format rather than changing the monetary API and SDK types to binary floating point.
  - code: XMSSecretInResponse
    from: openapi.json
    where:
      - $.definitions.AiGatewayPolicy.properties.counterKey
      - $.definitions.AiGatewayPolicyUpdate.properties.counterKey
      - $.definitions.AiGatewaySessionBackendPreference.properties.key
      - $.definitions.AiGatewaySessionBackendPreferenceUpdate.properties.key
    reason: False positive - counterKey contains public dimension selectors such as identity and ipAddress, and sessionBackendPreference.key is a CEL expression that extracts a non-secret caller session identifier for routing affinity. Neither contains credentials or secret values.
  - code: MissingXmsIdentifiers
    from: openapi.json
    where:
      - $.definitions.AiGatewayAliasProperties.properties.failures
      - $.definitions.AiGatewayAliasUpdateProperties.properties.failures
    reason: Alias failure rules are evaluated in order and do not have a unique identifier property; x-ms-identifiers is intentionally empty.
```
