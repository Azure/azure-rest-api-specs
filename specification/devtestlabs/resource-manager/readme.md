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
tag: package-2016-05

```


# Tag: package-2016-05

These settings apply only when `--tag=package-2016-05` is specified on the command line.

``` yaml $(tag) == 'package-2016-05'
input-file:
- Microsoft.DevTestLab/2016-05-15/DTL.json

```
 
# Tag: package-2015-05-preview

These settings apply only when `--tag=package-2015-05-preview` is specified on the command line.

``` yaml $(tag) == 'package-2015-05-preview'
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

