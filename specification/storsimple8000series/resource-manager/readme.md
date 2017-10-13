# StorSimple
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for StorSimple.



---
## Getting Started 
To build the SDK for StorSimple, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the StorSimple API.

``` yaml
openapi-type: arm
tag: package-2017-06
```


### Tag: package-2017-06

These settings apply only when `--tag=package-2017-06` is specified on the command line.

``` yaml $(tag) == 'package-2017-06'
input-file:
- Microsoft.StorSimple/2017-06-01/storsimple.json
```

---
# Code Generation


## C# 

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.StorSimple8000Series
  output-folder: $(csharp-sdks-folder)/StorSimple8000Series/Management.StorSimple8000Series/Generated
  clear-output-folder: true
```


## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: storsimple
  clear-output-folder: true
```

### Tag: package-2017-06 and go

These settings apply only when `--tag=package-2017-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-06' && $(go)
output-folder: $(go-sdk-folder)/services/storsimple8000series/mgmt/2017-06-01/storsimple
```
