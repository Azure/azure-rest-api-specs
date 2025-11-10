# CrossTenantPermissions

> see https://aka.ms/autorest

This is the AutoRest configuration file for CrossTenantPermissions.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the CrossTenantPermissions.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2025-06-03-preview
```

### Tag: package-2025-06-03-preview

These settings apply only when `--tag=package-2025-06-03-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-06-03-preview'
input-file:
  - preview/2025-06-03-preview/openapi.json
```

```yaml
directive:
  - suppress: OperationsAPIImplementation
    reason: Operations API was moved to its own service.
    from: openapi.json

  - suppress: TenantLevelAPIsNotAllowed
    reason: Cross tenant monitoring permissions scenarios are modelled around tenant level resources for controlling cross-tenant data flow.
    from: openapi.json

  - suppress: GuidUsage
    reason: The tenant ID in AllowedOutboundTenant must be a GUID for identifying Azure tenants.
    from: openapi.json
    where:
     - $.definitions["Azure.Core.uuid"].format
```
