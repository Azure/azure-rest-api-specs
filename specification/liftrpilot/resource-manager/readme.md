# Microsoft.LiftrPilot RP

> see https://aka.ms/autorest

This is the AutoRest configuration file for Liftrpilot service.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the pilot service.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2024-10-03-preview
```
### Tag:  package-2024-10-03-preview

These settings apply only when `--tag=package-2024-10-03-preview` is specified on the command line. 

```yaml $(tag) == 'package-2024-10-03-preview'
input-file:
  - Microsoft.LiftrPilot/preview/2024-10-03-preview/pilot.json
suppressions:
  - code: AvoidAnonymousTypes
    where: $.definitions["Azure.ResourceManager.CommonTypes.ManagedServiceIdentityUpdate"].properties.userAssignedIdentities.additionalProperties
    reason: User Assigned Managed Identity Type inline definition is automtaically added to json.
```