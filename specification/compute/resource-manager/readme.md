# Compute
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Compute.


The compute RP comprises of small services where each service has its own api-version.
Hence, each sub-service has its own swagger spec. 

All of them are tied together using this configuration and are packaged together into one compute client library.
This makes it easier for customers to download one (nuget/npm/pip/maven/gem) compute client library package rather than installing individual packages for each sub service.


---
## Getting Started 
To build the SDK for Compute, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the Compute API.

``` yaml
# common 
title: Compute
description: Compute Client
api-version: 2017-03-30

```


# API Version: 2017-03-30

These settings apply only when `--api-version=2017-03-30` is specified on the command line.

``` yaml $(api-version) == '2017-03-30'
input-file:
- Microsoft.Compute/2017-03-30/compute.json
- Microsoft.Compute/2017-03-30/disk.json
- Microsoft.Compute/2017-03-30/runCommands.json
- Microsoft.ContainerService/2017-01-31/containerService.json

```


# API Version: 2016-04-30-preview

These settings apply only when `--api-version=2016-04-30-preview` is specified on the command line.

``` yaml $(api-version) == '2016-04-30-preview'
input-file:
- Microsoft.Compute/2016-04-30-preview/compute.json
- Microsoft.Compute/2016-04-30-preview/disk.json
- Microsoft.ContainerService/2017-01-31/containerService.json

```
 
# API Version: 2016-03-30

These settings apply only when `--api-version=2016-03-30` is specified on the command line.

``` yaml $(api-version) == '2016-03-30'
input-file:
- Microsoft.Compute/2016-03-30/compute.json
- Microsoft.ContainerService/2016-03-30/containerService.json

```
 
# API Version: 2015-06-15-preview

These settings apply only when `--api-version=2015-06-15-preview` is specified on the command line.

``` yaml $(api-version) == '2015-06-15-preview'
input-file:
- Microsoft.Compute/2015-06-15/compute.json
- Microsoft.ContainerService/2015-11-01-preview/containerService.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

