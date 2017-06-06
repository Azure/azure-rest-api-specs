# AppInsights
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for AppInsights.



---
## Getting Started 
To build the SDK for AppInsights, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the AppInsights API.

``` yaml
# common 
title: AppInsights
description: AppInsights Client
tag: 2015-05-01

```


# Tag: 2015-05-01

These settings apply only when `--tag=2015-05-01` is specified on the command line.

``` yaml $(tag) == '2015-05-01'
input-file:
- microsoft.insights/2015-05-01/aiOperations_API.json
- microsoft.insights/2015-05-01/components_API.json
- microsoft.insights/2015-05-01/webTests_API.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

