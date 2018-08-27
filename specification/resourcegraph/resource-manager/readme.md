# ResourceGraph
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for ResourceGraph.



---
## Getting Started
To build the SDK for ResourceGraph, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration


### Basic Information 
These are the global settings for the ResourceGraph API.

``` yaml
title: ResourceGraphClient
openapi-type: arm
tag: package-2018-09-preview
```

### Validations
Run validations when `--validate` is specified on command line

``` yaml $(validate)
azure-validator: true
semantic-validator: true
model-validator: true
message-format: json
```


### Tag: package-2018-09-preview

These settings apply only when `--tag=package-2018-09-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-09-preview'
input-file:
- Microsoft.ResourceGraph/preview/2018-09-01-preview/resourcegraph.json
```