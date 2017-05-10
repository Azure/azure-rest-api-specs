# CognitiveServices
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for CognitiveServices.



---
## Getting Started 
To build the SDK for CognitiveServices, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the CognitiveServices API.

``` yaml
# common 
title: Cognitive Services
description: Cognitive Services Client
api-version: 2017-04-18

```


# API Version: 2017-04-18

These settings apply only when `--api-version=2017-04-18` is specified on the command line.

``` yaml $(api-version) == '2017-04-18'
input-file:
- Microsoft.CognitiveServices/2017-04-18/cognitiveservices.json

```
 
# API Version: 2016-02-01-preview

These settings apply only when `--api-version=2016-02-01-preview` is specified on the command line.

``` yaml $(api-version) == '2016-02-01-preview'
input-file:
- Microsoft.CognitiveServices/2016-02-01-preview/cognitiveservices.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

