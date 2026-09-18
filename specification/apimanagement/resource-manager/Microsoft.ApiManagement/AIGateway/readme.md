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
  - code: AvoidAdditionalProperties
    from: openapi.json
    where:
      - $.definitions.AiGatewayToolServerCredentials.properties.headers
      - $.definitions.AiGatewayToolServerCredentialsUpdate.properties.headers
      - $.definitions.AiGatewayToolServerOauth2Authentication.properties.authorizationParameters
      - $.definitions.AiGatewayToolServerOauth2Authentication.properties.tokenParameters
    reason: The current AI Gateway tool-server contract supports arbitrary HTTP header names and provider-specific OAuth parameters, so these maps cannot be represented by a fixed property model.
  - code: EnumInsteadOfBoolean
    from: openapi.json
    where:
      - $.definitions.AiGatewayToolServerEndpoint.properties.required
      - $.definitions.AiGatewayToolServerEndpointUpdate.properties.required
      - $.definitions.AiGatewayToolServerProperties.properties.subscriptionRequired
      - $.definitions.AiGatewayToolServerUpdateProperties.properties.subscriptionRequired
    reason: These fields represent binary required-or-optional behavior in the implemented tool-server contract and are intentionally boolean.
  - code: ProvisioningStateMustBeReadOnly
    from: openapi.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/aigateways/{aiGatewayName}"].get.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/aigateways/{aiGatewayName}"].put.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/aigateways/{aiGatewayName}"].put.responses["201"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/aigateways/{aiGatewayName}"].patch.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/aigateways/{aiGatewayName}/apiKeys/{apiKeyName}"].get.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/aigateways/{aiGatewayName}/apiKeys/{apiKeyName}"].put.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/aigateways/{aiGatewayName}/apiKeys/{apiKeyName}"].put.responses["201"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/aigateways/{aiGatewayName}/apiKeys/{apiKeyName}"].patch.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/aigateways/{aiGatewayName}/workspaces/{workspaceName}"].get.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/aigateways/{aiGatewayName}/workspaces/{workspaceName}"].put.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/aigateways/{aiGatewayName}/workspaces/{workspaceName}"].put.responses["201"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/aigateways/{aiGatewayName}/workspaces/{workspaceName}"].patch.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/aigateways/{aiGatewayName}/workspaces/{workspaceName}/modelProviders/{modelProviderName}"].get.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/aigateways/{aiGatewayName}/workspaces/{workspaceName}/modelProviders/{modelProviderName}"].put.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/aigateways/{aiGatewayName}/workspaces/{workspaceName}/modelProviders/{modelProviderName}"].put.responses["201"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/aigateways/{aiGatewayName}/workspaces/{workspaceName}/modelProviders/{modelProviderName}"].patch.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/aigateways/{aiGatewayName}/workspaces/{workspaceName}/modelProviders/{modelProviderName}/models/{modelName}"].get.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/aigateways/{aiGatewayName}/workspaces/{workspaceName}/modelProviders/{modelProviderName}/models/{modelName}"].put.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/aigateways/{aiGatewayName}/workspaces/{workspaceName}/modelProviders/{modelProviderName}/models/{modelName}"].put.responses["201"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/aigateways/{aiGatewayName}/workspaces/{workspaceName}/modelProviders/{modelProviderName}/models/{modelName}"].patch.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/aigateways/{aiGatewayName}/workspaces/{workspaceName}/toolServers/{toolServerName}"].get.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/aigateways/{aiGatewayName}/workspaces/{workspaceName}/toolServers/{toolServerName}"].put.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/aigateways/{aiGatewayName}/workspaces/{workspaceName}/toolServers/{toolServerName}"].put.responses["201"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/aigateways/{aiGatewayName}/workspaces/{workspaceName}/toolServers/{toolServerName}"].patch.responses["200"].schema
    reason: The referenced AI Gateway response schemas mark provisioningState readOnly, but the validator does not preserve the sibling readOnly annotation when resolving the enum reference.
  - code: XMSSecretInResponse
    from: openapi.json
    where:
      - $.definitions.AiGatewayPolicy.properties.counterKey
      - $.definitions.AiGatewayPolicyUpdate.properties.counterKey
    reason: counterKey selects the public request attribute used to partition a rate limit counter; it is not a credential or secret value.
```
