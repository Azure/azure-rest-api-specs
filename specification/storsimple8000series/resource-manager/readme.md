# StorSimple
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for StorSimple.



---
## Getting Started 
To build the SDK for StorSimple, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the StorSimple API.

``` yaml
# common 
title: StorSimple 8000 Series
description: StorSimple 8000 Series Client
openapi-type: arm
tag: package-2017-06

```


# Tag: package-2017-06

These settings apply only when `--tag=package-2017-06` is specified on the command line.

``` yaml $(tag) == 'package-2017-06'
input-file:
- Microsoft.StorSimple/2017-06-01/storsimple.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

