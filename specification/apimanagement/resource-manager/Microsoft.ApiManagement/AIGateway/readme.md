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
tag: package-preview-2026-10-01-preview
```

### Tag: package-preview-2026-10-01-preview

These settings apply only when `--tag=package-preview-2026-10-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2026-10-01-preview'
input-file:
  - preview/2026-10-01-preview/openapi.json
```

### Tag: package-preview-2026-09-01-preview

These settings apply only when `--tag=package-preview-2026-09-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2026-09-01-preview'
input-file:
  - preview/2026-09-01-preview/openapi.json
```

## Suppression

```yaml $(tag) == 'package-preview-2026-10-01-preview'
suppressions:
  - code: ArmResourcePropertiesBag
    from: openapi.json
    where:
      - $.definitions.AiGatewayModelProviderResource
      - $.definitions.AiGatewayModelResource
      - $.definitions.AiGatewayToolServerResource
      - $.definitions.AiGatewayWorkspaceResource
    reason: The current AI Gateway service contract uses name as the display-name wire property and type as the tool-server-kind wire property inside the resource properties bag. Renaming these fields would diverge from the implemented contract.
  - code: EnumInsteadOfBoolean
    from: openapi.json
    where:
      - $.definitions.AiGatewayToolServerEndpoint.properties.required
      - $.definitions.AiGatewayToolServerEndpointUpdate.properties.required
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
  - code: AvoidAdditionalProperties
    from: openapi.json
    where:
      - $.definitions.AiGatewayTelemetryCredentials.properties.headers
      - $.definitions.AiGatewayOpenTelemetryConfiguration.properties.headers
      - $.definitions.AiGatewayCostLimitOverride.properties.claims
      - $.definitions.AiGatewayCostLimitOverrideUpdate.properties.claims
      - $.definitions.AiGatewayAgentHook.properties.headers
      - $.definitions.AiGatewayAgentHookUpdate.properties.headers
      - $.definitions.AiGatewayPolicy.properties.headers
      - $.definitions.AiGatewayPolicyUpdate.properties.headers
    reason: OTLP and agent-hook HTTP header names and authenticated-token claim selectors are arbitrary keys in the implemented wire contract. These maps are retained for wire compatibility; tool-server credential and OAuth parameter collections remain typed arrays.
  - code: XMSSecretInResponse
    from: openapi.json
    where:
      - $.definitions.AiGatewayPolicy.properties.counterKey
      - $.definitions.AiGatewayPolicyUpdate.properties.counterKey
    reason: counterKey selects the public request attribute used to partition a rate limit counter; it is not a credential or secret value.
```
