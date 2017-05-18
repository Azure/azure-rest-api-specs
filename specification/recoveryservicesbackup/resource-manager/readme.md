# RecoveryServicesBackup
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for RecoveryServicesBackup.



---
## Getting Started 
To build the SDK for RecoveryServicesBackup, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the RecoveryServicesBackup API.

``` yaml
# common 
title: Recovery Services Backup
description: Recovery Services Backup Client
api-version: 2016-12-01

```


# API Version: 2016-12-01

These settings apply only when `--api-version=2016-12-01` is specified on the command line.

``` yaml $(api-version) == '2016-12-01'
input-file:
- Microsoft.RecoveryServices/2016-12-01/backupManagement.json

```
 
# API Version: 2016-06-01

These settings apply only when `--api-version=2016-06-01` is specified on the command line.

``` yaml $(api-version) == '2016-06-01'
input-file:
- Microsoft.RecoveryServices/2016-06-01/recoveryservicesbackup.json
- Microsoft.RecoveryServices/2016-06-01/registeredIdentities.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

