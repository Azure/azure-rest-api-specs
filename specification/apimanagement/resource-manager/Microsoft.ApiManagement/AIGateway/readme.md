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
  - code: ProvisioningStateMustBeReadOnly
    from: openapi.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/aigateways/{aiGatewayName}"].get.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/aigateways/{aiGatewayName}"].put.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/aigateways/{aiGatewayName}"].put.responses["201"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/aigateways/{aiGatewayName}"].patch.responses["200"].schema
    reason: The referenced AI Gateway response schemas mark provisioningState readOnly, but the validator does not preserve the sibling readOnly annotation when resolving the enum reference.
```
