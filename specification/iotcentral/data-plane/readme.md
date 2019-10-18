# IoT Central - API client generation

> see https://aka.ms/autorest

This is the AutoRest configuration file for MonitorClient.



---
## Getting Started
To build the SDK for MonitorClient, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration
These are the global settings for the IoT Central API.

```yaml
version: latest
clear-output-folder: true

# azure-validator: true
semantic-validator: true

azure-arm: true
add-credentials: true
generate-metadata: true
license-header: MICROSOFT_MIT_NO_VERSION

csharp:
    namespace: Microsoft.Azure.IotCentral
    output-folder: client/csharp/Microsoft.Azure.IotCentral

nodejs:
    package-name: azure-iotcentral
    package-version: 1.0.0
    output-folder: client/nodejs
```
