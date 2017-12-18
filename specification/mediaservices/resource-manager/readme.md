# MediaServices
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for MediaServices.



---
## Getting Started 
To build the SDK for MediaServices, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the MediaServices API.

``` yaml
openapi-type: arm
tag: package-2015-10
```


### Tag: package-2015-10

These settings apply only when `--tag=package-2015-10` is specified on the command line.

``` yaml $(tag) == 'package-2015-10'
input-file:
- Microsoft.Media/2015-10-01/media.json
```

---
# Code Generation


## C# 

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  # last generated from commit 3586e2989d502434c4f607dd38d40e46aabede5c
  azure-arm: true
  payload-flattening-threshold: 2
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.Media
  output-folder: $(csharp-sdks-folder)/Media/Management.Media/Generated
  clear-output-folder: true
```

## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
python-mode: create
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.media
  package-name: azure-mgmt-media
  clear-output-folder: true
```
``` yaml $(python) && $(python-mode) == 'update'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/azure-mgmt-media/azure/mgmt/media
```
``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/azure-mgmt-media
```


## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: media
  clear-output-folder: true
```

### Tag: package-2015-10 and go

These settings apply only when `--tag=package-2015-10 --go` is specified on the command line.
Please also specify the `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2015-10' && $(go)
output-folder: $(go-sdk-folder)/services/mediaservices/mgmt/2015-10-01/media
```
