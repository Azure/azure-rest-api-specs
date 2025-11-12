# ResourceNotifications

> see https://aka.ms/autorest

This is the AutoRest configuration file for Resource Notifications.

## Getting Started

To build the SDKs for Resource Notifications API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for Resource Notifications.

``` yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-preview-2025-11
```

### Tag: package-preview-2025-11

These settings apply only when `--tag=package-preview-2025-11` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-11'
input-file:
  - Microsoft.ResourceNotifications/preview/2025-11-11-preview/resourcenotifications.json
```

## Suppressions

```yaml
suppressions: []
```