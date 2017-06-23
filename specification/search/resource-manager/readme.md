# SearchClient
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for SearchClient.



---
## Getting Started 
To build the SDK for SearchClient, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the SearchClient API.

``` yaml
# common 
title: Search
description: Search Client
openapi-type: arm
tag: package-2015-08

```


# Tag: package-2015-08

These settings apply only when `--tag=package-2015-08` is specified on the command line.

``` yaml $(tag) == 'package-2015-08'
input-file:
- Microsoft.Search/2015-08-19/search.json

```
 
# Tag: package-2015-02

These settings apply only when `--tag=package-2015-02` is specified on the command line.

``` yaml $(tag) == 'package-2015-02'
input-file:
- Microsoft.Search/2015-02-28/search.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

