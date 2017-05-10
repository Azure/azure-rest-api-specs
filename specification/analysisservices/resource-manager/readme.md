# AnalysisServices
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for AnalysisServices.



---
## Getting Started 
To build the SDK for AnalysisServices, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the AnalysisServices API.

``` yaml
# common 
title: Analysis Services
description: Analysis Services Client
api-version: 2016-05-16

```


# API Version: 2016-05-16

These settings apply only when `--api-version=2016-05-16` is specified on the command line.

``` yaml $(api-version) == '2016-05-16'
input-file:
- Microsoft.AnalysisServices/2016-05-16/analysisservices.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

