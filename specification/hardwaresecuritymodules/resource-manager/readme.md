# HardwareSecurityModules

> see https://aka.ms/autorest

This is the AutoRest configuration file for hardware security module RP.



---
## Getting Started
To build the SDK for hardware security modules, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information
These are the global settings for the Hardware Security Modules API.

``` yaml
openapi-type: arm
tag: package-2018-10
```


### Tag: package-2018-02

These settings apply only when `--tag=package-2018-10` is specified on the command line.

``` yaml $(tag) == 'package-2018-10'
input-file:
- Microsoft.HardwareSecurityModules/preview/2018-10-31-preview/dedicatedhsm.json
```


