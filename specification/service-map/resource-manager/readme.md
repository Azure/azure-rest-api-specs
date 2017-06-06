# ServiceMap
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for ServiceMap.



---
## Getting Started 
To build the SDK for ServiceMap, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the ServiceMap API.

``` yaml
# common 
title: Service Map
description: Service Map Client
tag: 2015-11-01-preview

```


# Tag: 2015-11-01-preview

These settings apply only when `--tag=2015-11-01-preview` is specified on the command line.

``` yaml $(tag) == '2015-11-01-preview'
input-file:
- Microsoft.OperationalInsights/2015-11-01-preview/arm-service-map.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

