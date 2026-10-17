# Foundry AgentServer SDK Contracts

This folder contains SDK-specific TypeSpec contracts for the AgentServer Responses package.

The contracts are consumed by Azure SDK generation and are not a standalone public REST API surface.

> see https://aka.ms/autorest

This is the AutoRest configuration file for Foundry AgentServer SDK contracts.

## Configuration

```yaml
title: Azure AI AgentServer Responses SDK Contracts
openapi-type: data-plane
tag: package-virtual-public-preview
```

### Tag: package-virtual-public-preview

```yaml $(tag) == 'package-virtual-public-preview'
input-file:
  - ../../openapi3/virtual-public-preview/microsoft-foundry-openapi3.json
```
