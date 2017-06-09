# DocumentDB
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for DocumentDB.



---
## Getting Started 
To build the SDK for DocumentDB, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the DocumentDB API.

``` yaml
# common 
title: Document DB
description: Document DB Client
openapi-type: arm
tag: 2015-04-08

```


# Tag: 2015-04-08

These settings apply only when `--tag=2015-04-08` is specified on the command line.

``` yaml $(tag) == '2015-04-08'
input-file:
- Microsoft.DocumentDB/2015-04-08/documentdb.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

