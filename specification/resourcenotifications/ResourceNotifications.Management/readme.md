# Azure Resource Notifications

> see https://aka.ms/autorest

This is the AutoRest configuration file for Azure Resource Notifications.

## Getting Started

To build the SDK for Azure Resource Notifications, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

## Configuration

### Basic Information

These are the global settings for the Azure Resource Notifications API.

``` yaml
openapi-type: arm
tag: package-2025-11-11-preview
```

### Tag: package-2025-11-11-preview

These settings apply only when `--tag=package-2025-11-11-preview` is specified on the command line.

``` yaml $(tag) == 'package-2025-11-11-preview'
input-file:
- ../resource-manager/Microsoft.ResourceNotifications/preview/2025-11-11-preview/resourcenotifications.json
```

## Code Generation

### C#

See configuration in [readme.csharp.md](./readme.csharp.md)

### Python

See configuration in [readme.python.md](./readme.python.md)

### Java

See configuration in [readme.java.md](./readme.java.md)

### JavaScript

See configuration in [readme.nodejs.md](./readme.nodejs.md)

### Go

See configuration in [readme.go.md](./readme.go.md)