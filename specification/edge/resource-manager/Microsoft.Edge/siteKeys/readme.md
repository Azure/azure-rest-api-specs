# edgesitekeys

> see https://aka.ms/autorest

This is the AutoRest configuration file for edgesitekeys.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Suppression

```yaml
directive:
  - suppress: OperationsAPIImplementation
    from: siteKeys.json
    reason: RP is in PrivatePreview and no SDK has been released yet. Microsoft.Edge RP consist of multiple resources which are owned/maintained by different teams, so we follow folder structure for Service Group. We do have operations api exposed from common-location/folder so every resource need not expose it separately. There has been open issue [Avocado] Support service group folder scenario azure-sdk-tools#6201 for the same.
```

## Configuration

### Basic Information

These are the global settings for the edgesitekeys.

```yaml
openapi-type: arm
openapi-subtype: providerHub
tag: package-2026-04-01-preview

```
### Tag: package-2026-04-01-preview

These settings apply only when `--tag=package-2026-04-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-04-01-preview'
input-file:
  - preview/2026-04-01-preview/siteKeys.json
```