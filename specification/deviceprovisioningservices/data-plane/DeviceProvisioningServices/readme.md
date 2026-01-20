# Device Provisioning Service

> see https://aka.ms/autorest

This is the AutoRest configuration file for Device Provisioning Service.

---

## Getting Started

To build the SDK for Device Provisioning Service, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the API.

``` yaml
openapi-type: data-plane
tag: package-2026-04-01-device
```

### Tag: package-2026-04-service

These settings apply only when `--tag=package-2026-04-service` is specified on the command line.

```yaml $(tag) == 'package-2026-04-01-01-service'
input-file:
  - stable/2026-04-01/service.json
title: ProvisioningServiceClient
```

### Tag: package-2026-04-device

These settings apply only when `--tag=package-2026-04-device` is specified on the command line.

```yaml $(tag) == 'package-2026-04-01-device'
input-file:
  - stable/2026-04-01/device.json
title: ProvisioningDeviceClient
```

### Tag: package-preview-2025-07-service
These settings apply only when `--tag=package-preview-2025-07-service` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-07-service'
input-file:
  - preview/2025-07-01-preview/service.json
title: ProvisioningServiceClient
```

### Tag: package-preview-2025-07-device

These settings apply only when `--tag=package-preview-2025-07-device` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-07-device'
input-file:
  - preview/2025-07-01-preview/device.json
title: ProvisioningDeviceClient
```

### Tag: package-2021-10-01-service

These settings apply only when `--tag=package-2021-10-01-service` is specified on the command line.

```yaml $(tag) == 'package-2021-10-01-service'
input-file:
  - stable/2021-10-01/service.json
title: ProvisioningServiceClient
```

### Tag: package-2021-10-01-device

These settings apply only when `--tag=package-2021-10-01-device` is specified on the command line.

```yaml $(tag) == 'package-2021-10-01-device'
input-file:
  - stable/2021-10-01/device.json
title: ProvisioningDeviceClient
```
---

# Code Generation

## C#

See configuration in [readme.csharp.md](./readme.csharp.md)
