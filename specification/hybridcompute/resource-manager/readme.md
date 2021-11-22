# HybridCompute
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for HybridCompute RP.



---
## Getting Started 
To build the SDK for HybridCompute, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information 
These are the global settings for the HybridCompute API.

``` yaml
openapi-type: arm
tag: package-2019-08
```

### Tag: package-2019-03

These settings apply only when `--tag=package-2019-03` is specified on the command line.

``` yaml $(tag) == 'package-2019-03'
input-file:
- Microsoft.HybridCompute/preview/2019-03-18/HybridCompute.json
```

### Tag: package-2019-08

These settings apply only when `--tag=package-2019-08` is specified on the command line.

``` yaml $(tag) == 'package-2019-08'
input-file:
- Microsoft.HybridCompute/preview/2019-08-02/HybridCompute.json
```

---
# Code Generation


---
## C# 

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.HybridCompute
  output-folder: $(csharp-sdks-folder)/HybridCompute/Microsoft.Azure.Management.HybridCompute/src/Generated
  clear-output-folder: true
directive:
  - remove-operation: 
    - Machines_Reconnect
    - Machines_CreateOrUpdate
    - Machines_Update
    - Machines_Delete
```

## PowerShell

``` yaml $(powershell)
powershell:
  namespace: Microsoft.Azure.Management.HybridCompute
  output-folder: generated
  clear-output-folder: true
directive:
  - remove-operation: 
    - Machines_Reconnect
    - Machines_CreateOrUpdate
    - Machines_Update
    - Machines_Delete
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
  namespace: azure.mgmt.hybridcompute
  package-name: azure-mgmt-hybridcompute
  clear-output-folder: true
```
``` yaml $(python) && $(python-mode) == 'update'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/hybridcompute/azure-mgmt-hybridcompute/azure/mgmt/hybridcompute
```
``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/azure-mgmt-hybridcompute
directive:
  - remove-operation: 
    - Machines_Reconnect
    - Machines_CreateOrUpdate
    - Machines_Update
    - Machines_Delete
```

## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
  namespace: hybridcompute
```


### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2019-03
```

### Tag: package-2019-03 and go

These settings apply only when `--tag=package-2019-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2019-03' && $(go)
output-folder: $(go-sdk-folder)/services/preview/hybridcompute/mgmt/2019-03-18-preview/hybridcompute
```

## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.hybridcompute
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-hybridcompute
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2019-03
```

### Tag: package-2019-03 and java

These settings apply only when `--tag=package-2019-03 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-03' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.hybridcompute.v2019_03_18
  output-folder: $(azure-libraries-for-java-folder)/hybridcompute/resource-manager/v2019_03_18

regenerate-manager: true
generate-interface: true
```
