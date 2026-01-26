# Azure Discovery

> see https://aka.ms/autorest
> This is the AutoRest configuration file for Azure Discovery.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`
> To see additional help and options, run:

> `autorest --help`
> For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the Azure Discovery.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2026-02-01-preview
```

### Tag: package-2026-02-01-preview

These settings apply only when `--tag=package-2026-02-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-02-01-preview'
input-file:
  - Microsoft.Discovery/preview/2026-02-01-preview/discovery.json
suppressions:
  - code: AvoidAnonymousTypes
    from: discovery.json
    reason: Swagger LintDiff false positive for ManagedServiceIdentityProperty
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: discovery.json
    reason: Newer version no longer has MoboConfigurationWithMrg
  - code: AvoidAdditionalProperties
    reason: Enable customer to apply environment variables.
    from:
      - discovery.json
    where: 
      - $.definitions.ToolProperties.properties.environmentVariables
      - $.definitions.ToolPropertiesUpdate.properties.environmentVariables
  - code: AvoidAdditionalProperties
    reason: Enable customer to definitionContent matching user defined formats.
    from:
      - discovery.json
    where:
      - $.definitions.WithDefinitionContent.properties.definitionContent
      - $.definitions.AgentProperties.properties.definitionContent
      - $.definitions.AgentPropertiesUpdate.properties.definitionContent
      - $.definitions.ModelProperties.properties.definitionContent
      - $.definitions.ModelPropertiesUpdate.properties.definitionContent
      - $.definitions.ToolProperties.properties.definitionContent
      - $.definitions.ToolPropertiesUpdate.properties.definitionContent
      - $.definitions.WorkflowProperties.properties.definitionContent
      - $.definitions.WorkflowPropertiesUpdate.properties.definitionContent
  - code: AvoidAdditionalProperties
    reason: Enable customer to assign identities to tools.
    from:
      - discovery.json
    where:
      - $.definitions.SupercomputerIdentities.properties.workloadIdentities
      - $.definitions.SupercomputerIdentitiesUpdate.properties.workloadIdentities
  - code: AvoidAdditionalProperties
    reason: Workload identities are user-determined keys for managed identities.
    from:
      - discovery.json
    where:
      - $.definitions.BookshelfProperties.properties.workloadIdentities
  - code: GuidUsage
    reason: Need to match ARM managed identity schema.
    from:
      - discovery.json
    where:
      - $.definitions["Azure.Core.uuid"].format
  - code: XMSSecretInResponse
    reason: publicNetworkAccess is not a secret - it is a network configuration setting that controls public endpoint access.
    from:
      - discovery.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Discovery/bookshelves/{bookshelfName}"].get.responses["200"].schema.properties.properties.properties.publicNetworkAccess
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Discovery/bookshelves/{bookshelfName}"].put.responses["200"].schema.properties.properties.properties.publicNetworkAccess
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Discovery/bookshelves/{bookshelfName}"].put.responses["201"].schema.properties.properties.properties.publicNetworkAccess
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Discovery/workspaces/{workspaceName}"].get.responses["200"].schema.properties.properties.properties.publicNetworkAccess
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Discovery/workspaces/{workspaceName}"].put.responses["200"].schema.properties.properties.properties.publicNetworkAccess
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Discovery/workspaces/{workspaceName}"].put.responses["201"].schema.properties.properties.properties.publicNetworkAccess
```

---