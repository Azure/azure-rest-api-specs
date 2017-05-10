# StorageImportExport
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for StorageImportExport.



---
## Getting Started 
To build the SDK for StorageImportExport, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the StorageImportExport API.

``` yaml
# common 
title: Storage Import Export
description: Storage Import Export Client
api-version: 2016-11-01

```


# API Version: 2016-11-01

These settings apply only when `--api-version=2016-11-01` is specified on the command line.

``` yaml $(api-version) == '2016-11-01'
input-file:
- Microsoft.ImportExport/2016-11-01/storsimple.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

