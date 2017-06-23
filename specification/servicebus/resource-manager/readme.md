# ServiceBus
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for ServiceBus.



---
## Getting Started 
To build the SDK for ServiceBus, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the ServiceBus API.

``` yaml
# common 
title: Service Bus
description: Service Bus Client
openapi-type: arm
tag: package-2015-08

```


# Tag: package-2015-08

These settings apply only when `--tag=package-2015-08` is specified on the command line.

``` yaml $(tag) == 'package-2015-08'
input-file:
- Microsoft.ServiceBus/2015-08-01/servicebus.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

