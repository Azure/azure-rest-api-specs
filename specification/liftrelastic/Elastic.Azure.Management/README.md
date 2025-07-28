# Liftr - Elastic Azure Integration

This directory contains the TypeSpec specification for the Liftr - Elastic Azure Integration SaaS offer on Marketplace.

## Overview

The Elastic Azure Integration service provides monitoring and observability capabilities through Elastic's powerful search and analytics platform, integrated seamlessly with Azure services.

## API Version

- **Current Version**: 2025-06-30-preview (Beta)

## Resource Types

### OrganizationResource

The primary resource type representing an Elastic monitoring organization with the following capabilities:

- **Elastic Monitoring Properties**: Configure Elastic stack version, endpoints, and deployment settings
- **Deployment Settings**: Manage deployment size, data retention, and feature enablement
- **Single Sign-On Integration**: Enterprise SSO configuration
- **Marketplace Integration**: Full Azure Marketplace billing and subscription management

## SDK Support

This specification generates SDKs for the following languages:

- **Go**: `github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/elasticazure/armelasticazure`
- **Java**: `com.azure.resourcemanager.elasticazure`
- **JavaScript**: `@azure/arm-elasticazure`
- **Python**: `azure-mgmt-elasticazure`

## Examples

See the `examples/` directory for sample requests and responses.

## Release Information

- **Release Plan**: [501](https://web.powerapps.com/apps/3a732482-e479-4ec1-99c8-359f2c2d3f53?release-plan-id=08774471-e16b-f011-bec3-000d3a5a7d0d)
- **Work Item**: 28197
- **Release Type**: Beta
- **Contact**: prmarott

## TypeSpec Compilation

To compile this specification:

```bash
npx tsp compile .
```

The compiled OpenAPI specification will be generated in the `../resource-manager/Elastic/preview/2025-06-30-preview/` directory.