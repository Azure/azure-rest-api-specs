# EventHub
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for EventHub.



---
## Getting Started 
To build the SDK for EventHub, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the EventHub API.

``` yaml
# common 
title: Event Hub
description: Event Hub Client
openapi-type: arm
tag: 2015-08-01

```


# Tag: 2015-08-01

These settings apply only when `--tag=2015-08-01` is specified on the command line.

``` yaml $(tag) == '2015-08-01'
input-file:
- Microsoft.EventHub/2015-08-01/EventHub.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

