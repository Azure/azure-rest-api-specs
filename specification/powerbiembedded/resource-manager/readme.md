# PowerBI
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for PowerBI.



---
## Getting Started 
To build the SDK for PowerBI, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the PowerBI API.

``` yaml
# common 
title: Power BI
description: Power BI Client
tag: 2016-01-29

```


# Tag: 2016-01-29

These settings apply only when `--tag=2016-01-29` is specified on the command line.

``` yaml $(tag) == '2016-01-29'
input-file:
- Microsoft.PowerBI/2016-01-29/powerbiembedded.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

