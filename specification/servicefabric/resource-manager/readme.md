# ServiceFabricClient
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for ServiceFabricClient.



---
## Getting Started 
To build the SDK for ServiceFabricClient, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the ServiceFabricClient API.

``` yaml
# common 
title: Service Fabric
description: Service Fabric Client
openapi-type: arm
tag: 2016-09-01

```


# Tag: 2016-09-01

These settings apply only when `--tag=2016-09-01` is specified on the command line.

``` yaml $(tag) == '2016-09-01'
input-file:
- Microsoft.ServiceFabric/2016-09-01/servicefabric.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

