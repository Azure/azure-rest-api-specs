# Batch
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Batch.



---
## Getting Started 
To build the SDK for Batch, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the Batch API.

``` yaml
openapi-type: arm
tag: package-2017-09
```

### Tag: package-2017-09

These settings apply only when `--tag=package-2017-09` is specified on the command line.

``` yaml $(tag) == 'package-2017-09'
input-file:
- Microsoft.Batch/2017-09-01/BatchManagement.json
```

## Suppression

Note that this setting should be removed once [this GitHub bug](https://github.com/Azure/azure-openapi-validator/issues/68) is fixed.
``` yaml
directive:
  - suppress: R2063
    from: BatchManagement.json
    reason: Bug in linter
```


### Tag: package-2017-05

These settings apply only when `--tag=package-2017-05` is specified on the command line.

``` yaml $(tag) == 'package-2017-05'
input-file:
- Microsoft.Batch/2017-05-01/BatchManagement.json
```


### Tag: package-2017-01

These settings apply only when `--tag=package-2017-01` is specified on the command line.

``` yaml $(tag) == 'package-2017-01'
input-file:
- Microsoft.Batch/2017-01-01/BatchManagement.json
```
 
### Tag: package-2015-12

These settings apply only when `--tag=package-2015-12` is specified on the command line.

``` yaml $(tag) == 'package-2015-12'
input-file:
- Microsoft.Batch/2015-12-01/BatchManagement.json
```


---
# Code Generation


## C# 

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  # last generated with AutoRest.1.0.0-Nightly20170129 from commit 19f63015ea5a8a0fc64b9d7e2cdfeac447d93eaf 
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.Batch
  payload-flattening-threshold: 1
  output-folder: $(csharp-sdks-folder)/Batch/Management/Management.Batch/Generated
  clear-output-folder: true
```


## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: batch
  clear-output-folder: true
```

### Tag: package-2017-09 and go

These settings apply only when `--tag=package-2017-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-09' && $(go)
output-folder: $(go-sdk-folder)/services/batch/mgmt/2017-09-01/batch
```

### Tag: package-2017-05 and go

These settings apply only when `--tag=package-2017-05 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-05' && $(go)
output-folder: $(go-sdk-folder)/services/batch/mgmt/2017-05-01/batch
```

### Tag: package-2017-01 and go

These settings apply only when `--tag=package-2017-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-01' && $(go)
output-folder: $(go-sdk-folder)/services/batch/mgmt/2017-01-01/batch
```

### Tag: package-2015-12 and go

These settings apply only when `--tag=package-2015-12 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2015-12' && $(go)
output-folder: $(go-sdk-folder)/services/batch/mgmt/2015-12-01/batch
```