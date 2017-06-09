# RecoveryServicesSiteRecovery
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for RecoveryServicesSiteRecovery.



---
## Getting Started 
To build the SDK for RecoveryServicesSiteRecovery, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the RecoveryServicesSiteRecovery API.

``` yaml
# common 
title: Recovery Services Site Recovery
description: Recovery Services Site Recovery Client
openapi-type: arm
tag: 2016-08-10

```


# Tag: 2016-08-10

These settings apply only when `--tag=2016-08-10` is specified on the command line.

``` yaml $(tag) == '2016-08-10'
input-file:
- Microsoft.RecoveryServices/2016-08-10/service.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

