# IotHub
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for IotHub.



---
## Getting Started 
To build the SDK for IotHub, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the IotHub API.

``` yaml
# common 
title: IOT Hub
description: IOT Hub Client
openapi-type: arm
tag: 2017-01-19

```


# Tag: 2017-01-19

These settings apply only when `--tag=2017-01-19` is specified on the command line.

``` yaml $(tag) == '2017-01-19'
input-file:
- Microsoft.Devices/2017-01-19/iothub.json

```
 
# Tag: 2016-02-03

These settings apply only when `--tag=2016-02-03` is specified on the command line.

``` yaml $(tag) == '2016-02-03'
input-file:
- Microsoft.Devices/2016-02-03/iothub.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

