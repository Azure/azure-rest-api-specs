# Intune
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Intune.



---
## Getting Started 
To build the SDK for Intune, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the Intune API.

``` yaml
# common 
title: Intune
description: Intune Client
tag: 2015-01-14-preview

```


# Tag: 2015-01-14-preview

These settings apply only when `--tag=2015-01-14-preview` is specified on the command line.

``` yaml $(tag) == '2015-01-14-preview'
input-file:
- Microsoft.Intune/2015-01-14-preview/intune.json

```
 
# Tag: 2015-01-14-privatepreview

These settings apply only when `--tag=2015-01-14-privatepreview` is specified on the command line.

``` yaml $(tag) == '2015-01-14-privatepreview'
input-file:
- Microsoft.Intune/2015-01-14-privatepreview/intune.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

