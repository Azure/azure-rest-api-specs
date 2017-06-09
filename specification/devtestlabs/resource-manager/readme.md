# DevTestLab
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for DevTestLab.



---
## Getting Started 
To build the SDK for DevTestLab, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the DevTestLab API.

``` yaml
# common 
title: Dev Test Lab
description: Dev Test Lab Client
openapi-type: arm
tag: 2016-05-15

```


# Tag: 2016-05-15

These settings apply only when `--tag=2016-05-15` is specified on the command line.

``` yaml $(tag) == '2016-05-15'
input-file:
- Microsoft.DevTestLab/2016-05-15/DTL.json

```
 
# Tag: 2015-05-21-preview

These settings apply only when `--tag=2015-05-21-preview` is specified on the command line.

``` yaml $(tag) == '2015-05-21-preview'
input-file:
- Microsoft.DevTestLab/2015-05-21-preview/DTL.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

