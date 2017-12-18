# Consumption
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Consumption.



---
## Getting Started 
To build the SDK for Consumption, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the Consumption API.

``` yaml
openapi-type: arm
tag: package-2017-11
```

### Tag: package-2017-11

These settings apply only when `--tag=package-2017-11` is specified on the command line.

``` yaml $(tag) == 'package-2017-11'
input-file:
- Microsoft.Consumption/2017-11-30/consumption.json
```

### Tag: package-2017-04-preview

These settings apply only when `--tag=package-2017-04-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-04-preview'
input-file:
- Microsoft.Consumption/2017-04-24-preview/consumption.json
```

### Tag: package-2017-12-preview

These settings apply only when `--tag=package-2017-12-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-12-preview'
input-file:
- Microsoft.Consumption/2017-12-30-preview/consumption.json
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
  namespace: Microsoft.Azure.Management.Consumption
  output-folder: $(csharp-sdks-folder)/Consumption/Management.Consumption/Generated
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
  namespace: azure.mgmt.consumption
  package-name: azure-mgmt-consumption
  clear-output-folder: true
```
``` yaml $(python) && $(python-mode) == 'update'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/azure-mgmt-consumption/azure/mgmt/consumption
```
``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/azure-mgmt-consumption
```


## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: consumption
  clear-output-folder: true
```

### Tag: package-2017-04-preview and go

These settings apply only when `--tag=package-2017-04-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-04-preview' && $(go)
output-folder: $(go-sdk-folder)/services/consumption/mgmt/2017-04-24-preview/consumption
```

### Tag: package-2017-11-30 and go
These settings apply only when `--tag=package-2017-11-30 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-11-30' && $(go)
output-folder: $(go-sdk-folder)/services/consumption/mgmt/2017-11-30/consumption
```

### Tag: package-2017-12-30-preview and go
These settings apply only when `--tag=package-2017-12-30-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-12-30-preview' && $(go)
output-folder: $(go-sdk-folder)/services/consumption/mgmt/2017-12-30-preview/consumption
```