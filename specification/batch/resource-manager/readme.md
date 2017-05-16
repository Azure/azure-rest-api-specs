# Batch
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Batch.



---
## Getting Started 
To build the SDK for Batch, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the Batch API.

``` yaml
# common 
title: Batch
description: Batch Client
api-version: 2017-05-01

```


# API Version: 2017-05-01

These settings apply only when `--api-version=2017-05-01` is specified on the command line.

``` yaml $(api-version) == '2017-05-01'
input-file:
- Microsoft.Batch/2017-05-01/BatchManagement.json

```


# API Version: 2017-01-01

These settings apply only when `--api-version=2017-01-01` is specified on the command line.

``` yaml $(api-version) == '2017-01-01'
input-file:
- Microsoft.Batch/2017-01-01/BatchManagement.json

```
 
# API Version: 2015-12-01

These settings apply only when `--api-version=2015-12-01` is specified on the command line.

``` yaml $(api-version) == '2015-12-01'
input-file:
- Microsoft.Batch/2015-12-01/BatchManagement.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

