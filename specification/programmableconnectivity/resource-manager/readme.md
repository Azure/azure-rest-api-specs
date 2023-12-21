# ProgrammableConnectivity

> see https://aka.ms/autorest

This is the AutoRest configuration file for Azure Programmable Connectivity.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for Azure Programmable Connectivity.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2024-01-01-preview
```

### Tag: package-2024-01-01-preview

These settings apply only when `--tag=package-2024-01-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-01-01-preview'
input-file:
  - Microsoft.ProgrammableConnectivity/preview/2024-01-01-preview/Gateways.json
  - Microsoft.ProgrammableConnectivity/preview/2024-01-01-preview/OpenApiGatewayOfferings.json
  - Microsoft.ProgrammableConnectivity/preview/2024-01-01-preview/OpenApiGateways.json
  - Microsoft.ProgrammableConnectivity/preview/2024-01-01-preview/OperatorConnections.json
  - Microsoft.ProgrammableConnectivity/preview/2024-01-01-preview/OperatorOfferings.json
  - Microsoft.ProgrammableConnectivity/preview/2024-01-01-preview/Operations.json
  - Microsoft.ProgrammableConnectivity/preview/2024-01-01-preview/common.json
```

### Tag: package-2023-12-15-preview

These settings apply only when `--tag=package-2023-12-15-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-12-15-preview'
input-file:
  - Microsoft.ProgrammableConnectivity/preview/2023-12-15-preview/Gateways.json
  - Microsoft.ProgrammableConnectivity/preview/2023-12-15-preview/OpenApiGatewayOfferings.json
  - Microsoft.ProgrammableConnectivity/preview/2023-12-15-preview/OpenApiGateways.json
  - Microsoft.ProgrammableConnectivity/preview/2023-12-15-preview/OperatorConnections.json
  - Microsoft.ProgrammableConnectivity/preview/2023-12-15-preview/OperatorOfferings.json
  - Microsoft.ProgrammableConnectivity/preview/2023-12-15-preview/Operations.json
  - Microsoft.ProgrammableConnectivity/preview/2023-12-15-preview/common.json
```

### Tag: package-2023-11-01-preview

These settings apply only when `--tag=package-2023-11-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-11-01-preview'
input-file:
  - Microsoft.ProgrammableConnectivity/preview/2023-11-01-preview/common.json
  - Microsoft.ProgrammableConnectivity/preview/2023-11-01-preview/Gateways.json
  - Microsoft.ProgrammableConnectivity/preview/2023-11-01-preview/OpenApiGateways.json
  - Microsoft.ProgrammableConnectivity/preview/2023-11-01-preview/OpenApiGatewayOfferings.json
  - Microsoft.ProgrammableConnectivity/preview/2023-11-01-preview/Operations.json
```

---
