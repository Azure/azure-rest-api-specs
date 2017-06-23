# ContainerRegistry
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for ContainerRegistry.



---
## Getting Started 
To build the SDK for ContainerRegistry, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the ContainerRegistry API.

``` yaml
# common 
title: Container Registry
description: Container Registry Client
openapi-type: arm
tag: package-2017-06-preview

```


# Tag: package-2017-06-preview

These settings apply only when `--tag=package-2017-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-06-preview'
input-file:
- Microsoft.ContainerRegistry/2017-06-01-preview/containerregistry.json

```
 
# Tag: package-2017-03

These settings apply only when `--tag=package-2017-03` is specified on the command line.

``` yaml $(tag) == 'package-2017-03'
input-file:
- Microsoft.ContainerRegistry/2017-03-01/containerregistry.json

```
 
# Tag: package-2016-06-preview

These settings apply only when `--tag=package-2016-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2016-06-preview'
input-file:
- Microsoft.ContainerRegistry/2016-06-27-preview/containerregistry.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

