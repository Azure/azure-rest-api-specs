# RecoveryServices
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for RecoveryServices.



---
## Getting Started 
To build the SDK for RecoveryServices, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the RecoveryServices API.

``` yaml
# common 
title: Recovery Services
description: Recovery Services Client
tag: 2016-12-01

```


# Tag: 2016-12-01

These settings apply only when `--tag=2016-12-01` is specified on the command line.

``` yaml $(tag) == '2016-12-01'
input-file:
- Microsoft.RecoveryServices/2016-12-01/backup.json
- Microsoft.RecoveryServices/2016-06-01/registeredidentities.json
- Microsoft.RecoveryServices/2016-06-01/replicationusages.json
- Microsoft.RecoveryServices/2016-06-01/vaults.json
- Microsoft.RecoveryServices/2016-06-01/vaultusages.json

```
 
# Tag: 2016-06-01

These settings apply only when `--tag=2016-06-01` is specified on the command line.

``` yaml $(tag) == '2016-06-01'
input-file:
- Microsoft.RecoveryServices/2016-06-01/registeredidentities.json
- Microsoft.RecoveryServices/2016-06-01/replicationusages.json
- Microsoft.RecoveryServices/2016-06-01/vaults.json
- Microsoft.RecoveryServices/2016-06-01/vaultusages.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

