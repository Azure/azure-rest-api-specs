# LiftrBasic.SampleRP RP

> see https://aka.ms/autorest

This is the AutoRest configuration file for liftrpinecone service.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the liftrpinecone service.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2024-10-22-preview
suppressions:
    - code: AvoidAnonymousTypes
      where: 
        - $.definitions["ManagedServiceIdentityUpdate"].properties["userAssignedIdentities"].additionalProperties
      reason: 
        Issue with common-types
```
### Tag:  package-2024-10-22-preview

These settings apply only when `--tag=package-2024-10-22-preview` is specified on the command line. 

```yaml $(tag) == 'package-2024-10-22-preview'
input-file:
  - Pinecone.VectorDb/preview/2024-10-22-preview/openapi.json
```