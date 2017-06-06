# DataLakeStore
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for DataLakeStore.



---
## Getting Started 
To build the SDK for DataLakeStore, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the DataLakeStore API.

``` yaml
# common 
title: DataLake Store
description: DataLake Store Client
tag: 2016-11-01

```


# Tag: 2016-11-01

These settings apply only when `--tag=2016-11-01` is specified on the command line.

``` yaml $(tag) == '2016-11-01'
input-file:
- Microsoft.DataLakeStore/2016-11-01/account.json
- Microsoft.DataLakeStore/2016-11-01/filesystem.json

```
 
# Tag: 2015-10-01-preview

These settings apply only when `--tag=2015-10-01-preview` is specified on the command line.

``` yaml $(tag) == '2015-10-01-preview'
input-file:
- Microsoft.DataLakeStore/2015-10-01-preview/account.json
- Microsoft.DataLakeStore/2015-10-01-preview/filesystem.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

