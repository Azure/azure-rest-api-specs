# Storage
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Storage.



---
## Getting Started 
To build the SDK for Storage, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the Storage API.

``` yaml
# common 
title: Storage
description: Storage Client
api-version: 2017-06-01

```


# API Version: 2017-06-01

These settings apply only when `--api-version=2017-06-01` is specified on the command line.

``` yaml $(api-version) == '2017-06-01'
input-file:
- Microsoft.Storage/2017-06-01/storage.json

```


# API Version: 2016-12-01

These settings apply only when `--api-version=2016-12-01` is specified on the command line.

``` yaml $(api-version) == '2016-12-01'
input-file:
- Microsoft.Storage/2016-12-01/storage.json

```
 
# API Version: 2016-05-01

These settings apply only when `--api-version=2016-05-01` is specified on the command line.

``` yaml $(api-version) == '2016-05-01'
input-file:
- Microsoft.Storage/2016-05-01/storage.json

```
 
# API Version: 2016-01-01

These settings apply only when `--api-version=2016-01-01` is specified on the command line.

``` yaml $(api-version) == '2016-01-01'
input-file:
- Microsoft.Storage/2016-01-01/storage.json

```
 
# API Version: 2015-06-15

These settings apply only when `--api-version=2015-06-15` is specified on the command line.

``` yaml $(api-version) == '2015-06-15'
input-file:
- Microsoft.Storage/2015-06-15/storage.json

```
 
# API Version: 2015-05-01-preview

These settings apply only when `--api-version=2015-05-01-preview` is specified on the command line.

``` yaml $(api-version) == '2015-05-01-preview'
input-file:
- Microsoft.Storage/2015-05-01-preview/storage.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

