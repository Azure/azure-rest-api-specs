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
# Code Generation


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
  namespace: azure.mgmt.scheduler
  package-name: azure-mgmt-scheduler
  clear-output-folder: true
```
``` yaml $(python) && $(python-mode) == 'update'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/azure-mgmt-scheduler/azure/mgmt/scheduler
```
``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/azure-mgmt-scheduler
```



## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: scheduler
  clear-output-folder: true
```

### Tag: package-2016-03 and go

These settings apply only when `--tag=package-2016-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2016-03' && $(go)
output-folder: $(go-sdk-folder)/services/scheduler/mgmt/2016-03-01/scheduler
```

### Tag: package-2016-01 and go

These settings apply only when `--tag=package-2016-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2016-01' && $(go)
output-folder: $(go-sdk-folder)/services/scheduler/mgmt/2016-01-01/scheduler
```

### Tag: package-2014-08-preview and go

These settings apply only when `--tag=package-2014-08-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2014-08-preview' && $(go)
output-folder: $(go-sdk-folder)/services/scheduler/mgmt/2014-08-01-preview/scheduler
```
