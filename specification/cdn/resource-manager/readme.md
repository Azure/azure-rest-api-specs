# Cdn
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Cdn.



---
## Getting Started 
To build the SDK for Cdn, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the Cdn API.

``` yaml
# common 
title: CDN
description: CDN Client
openapi-type: arm
tag: 2016-10-02

```


# Tag: 2016-10-02

These settings apply only when `--tag=2016-10-02` is specified on the command line.

``` yaml $(tag) == '2016-10-02'
input-file:
- Microsoft.Cdn/2016-10-02/cdn.json

```
 
# Tag: 2016-04-02

These settings apply only when `--tag=2016-04-02` is specified on the command line.

``` yaml $(tag) == '2016-04-02'
input-file:
- Microsoft.Cdn/2016-04-02/cdn.json

```
 
# Tag: 2015-06-01

These settings apply only when `--tag=2015-06-01` is specified on the command line.

``` yaml $(tag) == '2015-06-01'
input-file:
- Microsoft.Cdn/2015-06-01/cdn.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

