# Service Fabric Client APIs

> see https://aka.ms/autorest

This is the AutoRest configuration file for ServiceFabricClient.



---
## Getting Started
To build the SDK for ServiceFabricClient, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information
These are the global settings for the ServiceFabricClient API.

``` yaml
openapi-type: data-plane
tag: '6.0'
```


### Tag: 1.0.0

These settings apply only when `--tag=1.0.0` is specified on the command line.

``` yaml $(tag) == '1.0.0'
input-file:
- Microsoft.ServiceFabric/1.0.0/servicefabric.json
```


### Tag: 5.6

These settings apply only when `--tag=5.6` is specified on the command line.

``` yaml $(tag) == '5.6'
input-file:
- Microsoft.ServiceFabric/5.6/servicefabric.json
```


### Tag: 6.0

These settings apply only when `--tag=6.0` is specified on the command line.

``` yaml $(tag) == '6.0'
input-file:
- Microsoft.ServiceFabric/6.0/servicefabric.json
```
