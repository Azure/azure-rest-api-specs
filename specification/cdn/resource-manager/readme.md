# Cdn
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Cdn.



---
## Getting Started 
To build the SDK for Cdn, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the Cdn API.

``` yaml
openapi-type: arm
tag: package-2017-04
```

### Tag: package-2017-04

These settings apply only when `--tag=package-2017-04` is specified on the command line.

``` yaml $(tag) == 'package-2017-04'
input-file:
- Microsoft.Cdn/2017-04-02/cdn.json
```
 
### Tag: package-2016-10

These settings apply only when `--tag=package-2016-10` is specified on the command line.

``` yaml $(tag) == 'package-2016-10'
input-file:
- Microsoft.Cdn/2016-10-02/cdn.json
```
 
### Tag: package-2016-04

These settings apply only when `--tag=package-2016-04` is specified on the command line.

``` yaml $(tag) == 'package-2016-04'
input-file:
- Microsoft.Cdn/2016-04-02/cdn.json
```
 
### Tag: package-2015-06

These settings apply only when `--tag=package-2015-06` is specified on the command line.

``` yaml $(tag) == 'package-2015-06'
input-file:
- Microsoft.Cdn/2015-06-01/cdn.json
```


---
# Code Generation


## C# 

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  # last generated with AutoRest.1.0.0-Nightly20170212
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.Cdn
  payload-flattening-threshold: 2
  output-folder: $(csharp-sdks-folder)/Cdn/Management.Cdn/Generated
  clear-output-folder: true
```
