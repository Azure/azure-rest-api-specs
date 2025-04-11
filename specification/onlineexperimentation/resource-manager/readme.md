# OnlineExperimentWorkspace

> see https://aka.ms/autorest

This is the AutoRest configuration file for OnlineExperimentWorkspace.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the OnlineExperimentWorkspace.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2025-05-31-preview
suppressions:
    - code: AvoidAnonymousTypes
      where: 
        - $.definitions["Azure.ResourceManager.CommonTypes.ManagedServiceIdentityUpdate"].properties["userAssignedIdentities"].additionalProperties
      reason: 
        Issue with common-types
    - code: GuidUsage
      where: 
        - $.definitions["Azure.Core.uuid"].format
      reason: 
        federatedClientId and delegatedIdentityClientId are common types and defined as guid.
```

### Tag: package-2025-05-31-preview

These settings apply only when `--tag=package-2025-05-31-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-05-31-preview'
input-file:
  - Microsoft.OnlineExperimentation/preview/2025-05-31-preview/OnlineExperimentWorkspace.json
```

---
