# Authorization
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Authorization.



---
## Getting Started 
To build the SDK for Authorization, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the Authorization API.

``` yaml
# common 
title: Authorization
description: Authorization Client
openapi-type: arm
tag: 2015-07-01

```


# Tag: 2015-07-01

These settings apply only when `--tag=2015-07-01` is specified on the command line.

``` yaml $(tag) == '2015-07-01'
input-file:
- Microsoft.Authorization/2015-07-01/authorization.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

