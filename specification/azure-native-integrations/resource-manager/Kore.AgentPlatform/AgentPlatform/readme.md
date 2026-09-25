# Kore.AgentPlatform

> see https://aka.ms/autorest

This is the AutoRest configuration file for AgentPlatform service.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the AgentPlatform service.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2026-07-01-preview
```

```yaml
modelerfour:
  flatten-models: false
```

### Suppressions

```yaml
suppressions:
  - code: EnumInsteadOfBoolean
    reason: These properties are intentional binary flags in the existing ARM and Kore partner contracts; changing them to enums would alter the wire contract.
    where:
      - $.definitions.DiscoveredWorkspace.properties.isDefault
      - $.definitions.DiscoveredWorkspace.properties.isManagedByLiftr
      - $.definitions.WorkspaceLinkedSaaSItem.properties.isHiddenSaaS
      - $.definitions.WorkspaceProperties.properties.isDefault
      - $.definitions.WorkspaceDetailPartnerProperties.properties.default
  - code: PostOperationIdContainsUrlVerb
    reason: SaaSOperationGroup_ActivateResource is an existing shipped operation ID; renaming it would break generated clients.
    where: $.paths["/subscriptions/{subscriptionId}/providers/Kore.AgentPlatform/activateSaaS"].post.operationId
```

### Tag: package-2026-07-01-preview

These settings apply only when `--tag=package-2026-07-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-07-01-preview'
input-file:
  - preview/2026-07-01-preview/openapi.json
```
