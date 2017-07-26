# Scheduler
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Scheduler.



---
## Getting Started 
To build the SDK for Scheduler, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the Scheduler API.

``` yaml
openapi-type: arm
tag: package-2016-03
```


### Tag: package-2016-03

These settings apply only when `--tag=package-2016-03` is specified on the command line.

``` yaml $(tag) == 'package-2016-03'
input-file:
- Microsoft.Scheduler/2016-03-01/scheduler.json
```
 
### Tag: package-2016-01

These settings apply only when `--tag=package-2016-01` is specified on the command line.

``` yaml $(tag) == 'package-2016-01'
input-file:
- Microsoft.Scheduler/2016-01-01/scheduler.json
```
 
### Tag: package-2014-08-preview

These settings apply only when `--tag=package-2014-08-preview` is specified on the command line.

``` yaml $(tag) == 'package-2014-08-preview'
input-file:
- Microsoft.Scheduler/2014-08-01-preview/scheduler.json
```


---
## C# 

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: NONE
  namespace: Microsoft.Azure.Management.Scheduler
  output-folder: $(csharp-sdks-folder)/Scheduler/Management.Scheduler/Generated
  clear-output-folder: true
```