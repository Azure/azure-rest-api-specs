# TrafficManager
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for TrafficManager.



---
## Getting Started 
To build the SDK for TrafficManager, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration


### Basic Information 
These are the global settings for the TrafficManager API.

``` yaml
openapi-type: arm
tag: package-2017-09-preview
```

### Tag: package-2017-09-preview

These settings apply only when `--tag=package-2017-09-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-09-preview'
input-file:
- Microsoft.Network/2017-09-01-preview/trafficmanager.json
```


### Tag: package-2017-05

These settings apply only when `--tag=package-2017-05` is specified on the command line.

``` yaml $(tag) == 'package-2017-05'
input-file:
- Microsoft.Network/2017-05-01/trafficmanager.json
```


### Tag: package-2017-03

These settings apply only when `--tag=package-2017-03` is specified on the command line.

``` yaml $(tag) == 'package-2017-03'
input-file:
- Microsoft.Network/2017-03-01/trafficmanager.json
```
 
### Tag: package-2015-11

These settings apply only when `--tag=package-2015-11` is specified on the command line.

``` yaml $(tag) == 'package-2015-11'
input-file:
- Microsoft.Network/2015-11-01/trafficmanager.json
```


---
# Code Generation


## C# 

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  # last generated with commit 9e35e9c1e14dc46fcb1837ad108bba185ccaf9a9
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.TrafficManager
  payload-flattening-threshold: 2
  output-folder: $(csharp-sdks-folder)/TrafficManager/Management.TrafficManager/Generated
  clear-output-folder: true
```