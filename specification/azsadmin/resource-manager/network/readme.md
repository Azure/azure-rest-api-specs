# Network Admin

> see https://aka.ms/autorest

This is the AutoRest configuration file for Network Admin.

---
## Getting Started
To build the SDK for Network Admin, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information
These are the global settings for the Network API.

``` yaml
title: NetworkAdminClient
description: Network Admin Client
openapi-type: arm
tag: package-2015-06-15
```

### Tag: package-2015-06-15

These settings apply only when `--tag=package-2015-06-15` is specified on the command line.

``` yaml $(tag) == 'package-2015-06-15'
input-file:
    - "Microsoft.Network.Admin/preview/2015-06-15/Network.json"
    - "Microsoft.Network.Admin/preview/2015-06-15/LoadBalancers.json"
    - "Microsoft.Network.Admin/preview/2015-06-15/PublicIpAddresses.json"
    - "Microsoft.Network.Admin/preview/2015-06-15/Quotas.json"
    - "Microsoft.Network.Admin/preview/2015-06-15/VirtualNetworks.json"
```

---
# Code Generation

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.AzureStack.Management.Network.Admin
  payload-flattening-threshold: 1
  output-folder: $(csharp-sdks-folder)/Generated
  clear-output-folder: true
```
