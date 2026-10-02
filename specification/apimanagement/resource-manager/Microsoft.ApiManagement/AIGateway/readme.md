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
tag: package-preview-2026-09-01-preview
```

### Tag: package-preview-2026-09-01-preview

These settings apply only when `--tag=package-preview-2026-09-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2026-09-01-preview'
input-file:
  - preview/2026-09-01-preview/openapi.json
```

## Suppression

```yaml
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
    reason: These fields represent binary required-or-optional behavior in the implemented tool-server contract and are intentionally boolean.
  - code: XMSSecretInResponse
    from: openapi.json
    where:
      - $.definitions.AiGatewayPolicy.properties.counterKey
      - $.definitions.AiGatewayPolicyUpdate.properties.counterKey
    reason: counterKey selects the public request attribute used to partition a rate limit counter; it is not a credential or secret value.
```
