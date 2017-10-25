# Authorization
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Authorization.



---
## Getting Started 
To build the SDK for Authorization, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the Authorization API.

``` yaml
openapi-type: arm
tag: package-2015-07
```


### Tag: package-2015-07

These settings apply only when `--tag=package-2015-07` is specified on the command line.

``` yaml $(tag) == 'package-2015-07'
input-file:
- Microsoft.Authorization/2015-07-01/authorization.json
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
  namespace: Microsoft.Azure.Management.Authorization
  output-folder: $(csharp-sdks-folder)/Authorization/Management.Authorization/Generated
  clear-output-folder: true
```


## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: authorization
  clear-output-folder: true
```

### Tag: package-2015-07 and go

These settings apply only when `--tag=package-2015-07 --go` is specified on he command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2015-07' && $(go)
output-folder: $(go-sdk-folder)/services/authorization/mgmt/2015-07-01/authorization
```
