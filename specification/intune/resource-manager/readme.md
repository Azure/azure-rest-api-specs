# Intune
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Intune.



---
## Getting Started 
To build the SDK for Intune, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the Intune API.

``` yaml
openapi-type: arm
tag: package-2015-01-preview
```


### Tag: package-2015-01-preview

These settings apply only when `--tag=package-2015-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2015-01-preview'
input-file:
- Microsoft.Intune/2015-01-14-preview/intune.json
```
 
### Tag: package-2015-01-privatepreview

These settings apply only when `--tag=package-2015-01-privatepreview` is specified on the command line.

``` yaml $(tag) == 'package-2015-01-privatepreview'
input-file:
- Microsoft.Intune/2015-01-14-privatepreview/intune.json
```