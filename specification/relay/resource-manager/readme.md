# Relay
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Relay.



---
## Getting Started 
To build the SDK for Relay, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the Relay API.

``` yaml
# common 
title: Relay
description: Relay Client
openapi-type: arm
tag: 2016-07-01

```


# Tag: 2016-07-01

These settings apply only when `--tag=2016-07-01` is specified on the command line.

``` yaml $(tag) == '2016-07-01'
input-file:
- Microsoft.Relay/2016-07-01/relay.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

