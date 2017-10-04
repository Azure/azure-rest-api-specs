# ResourceHealth
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for ResourceHealth.



---
## Getting Started 
To build the SDK for ResourceHealth, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the ResourceHealth API.

``` yaml
openapi-type: arm
tag: package-2017-07
```


### Tag: package-2017-07

These settings apply only when `--tag=package-2017-07` is specified on the command line.

``` yaml $(tag) == 'package-2017-07'
input-file:
- Microsoft.ResourceHealth/2017-07-01/resourcehealth.json
```


### Tag: package-2015-01

These settings apply only when `--tag=package-2015-01` is specified on the command line.

``` yaml $(tag) == 'package-2015-01'
input-file:
- Microsoft.ResourceHealth/2015-01-01/resourcehealth.json
```