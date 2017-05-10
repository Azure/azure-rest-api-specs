# MobileEngagement
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for MobileEngagement.



---
## Getting Started 
To build the SDK for MobileEngagement, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the MobileEngagement API.

``` yaml
# common 
title: Mobile Engagement
description: Mobile Engagement Client
api-version: 2014-12-01

```


# API Version: 2014-12-01

These settings apply only when `--api-version=2014-12-01` is specified on the command line.

``` yaml $(api-version) == '2014-12-01'
input-file:
- Microsoft.MobileEngagement/2014-12-01/mobile-engagement.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

