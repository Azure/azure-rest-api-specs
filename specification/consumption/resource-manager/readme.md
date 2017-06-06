# Consumption
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Consumption.



---
## Getting Started 
To build the SDK for Consumption, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the Consumption API.

``` yaml
# common 
title: Consumption
description: Consumption Client
tag: 2017-04-24-preview

```


# Tag: 2017-04-24-preview

These settings apply only when `--tag=2017-04-24-preview` is specified on the command line.

``` yaml $(tag) == '2017-04-24-preview'
input-file:
- Microsoft.Consumption/2017-04-24-preview/consumption.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

