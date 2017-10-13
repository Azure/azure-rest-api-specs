# MobileEngagement
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for MobileEngagement.



---
## Getting Started 
To build the SDK for MobileEngagement, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the MobileEngagement API.

``` yaml
openapi-type: arm
tag: package-2014-12
```


### Tag: package-2014-12

These settings apply only when `--tag=package-2014-12` is specified on the command line.

``` yaml $(tag) == 'package-2014-12'
input-file:
- Microsoft.MobileEngagement/2014-12-01/mobile-engagement.json
```


---
# Code Generation


## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: mobileengagement
  clear-output-folder: true
```

### Tag: package-2014-12 and go

These settings apply only when `--tag=package-2014-12 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2014-12' && $(go)
output-folder: $(go-sdk-folder)/services/mobileengagement/mgmt/2014-12-01/mobileengagement
```
