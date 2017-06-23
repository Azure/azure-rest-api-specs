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
openapi-type: data-plane
tag: package-2016-09

```


# Tag: package-2016-09

These settings apply only when `--tag=package-2016-09` is specified on the command line.

``` yaml $(tag) == 'package-2016-09'
input-file:
- Microsoft.Search/2016-09-01/searchindex.json
- Microsoft.Search/2016-09-01/searchservice.json

```
 
# Tag: package-2015-02-preview

These settings apply only when `--tag=package-2015-02-preview` is specified on the command line.

``` yaml $(tag) == 'package-2015-02-preview'
input-file:
- Microsoft.Search/2015-02-28-preview/searchindex.json
- Microsoft.Search/2015-02-28-preview/searchservice.json

```
 
# Tag: package-2015-02

These settings apply only when `--tag=package-2015-02` is specified on the command line.

``` yaml $(tag) == 'package-2015-02'
input-file:
- Microsoft.Search/2015-02-28/searchindex.json
- Microsoft.Search/2015-02-28/searchservice.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

