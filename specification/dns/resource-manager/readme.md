# DNS

> see https://aka.ms/autorest

This is the AutoRest configuration file for DNS.



---
## Getting Started
To build the SDK for DNS, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information
These are the global settings for the DNS API.

``` yaml
openapi-type: arm
tag: package-2016-04
```


### Tag: package-2016-04

These settings apply only when `--tag=package-2016-04` is specified on the command line.

``` yaml $(tag) == 'package-2016-04'
input-file:
- Microsoft.Network/2016-04-01/dns.json
```

### Tag: package-2015-05-preview

These settings apply only when `--tag=package-2015-05-preview` is specified on the command line.

``` yaml $(tag) == 'package-2015-05-preview'
input-file:
- Microsoft.Network/2015-05-04-preview/dns.json
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
  namespace: Microsoft.Azure.Management.Dns
  payload-flattening-threshold: 2
  output-folder: $(csharp-sdks-folder)/Dns/Management.Dns/Generated
  clear-output-folder: true
```