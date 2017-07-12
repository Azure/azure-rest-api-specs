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

## Configuration



### Basic Information 
These are the global settings for the DataLakeStore API.

``` yaml
 
title: DataLake Store
description: DataLake Store Client
openapi-type: data-plane
tag: package-2016-11
```


### Tag: package-2016-11

These settings apply only when `--tag=package-2016-11` is specified on the command line.

``` yaml $(tag) == 'package-2016-11'
input-file:
- Microsoft.DataLakeStore/2016-11-01/filesystem.json
```
 
### Tag: package-2015-10-preview

These settings apply only when `--tag=package-2015-10-preview` is specified on the command line.

``` yaml $(tag) == 'package-2015-10-preview'
input-file:
- Microsoft.DataLakeStore/2015-10-01-preview/filesystem.json
```


---
## Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

