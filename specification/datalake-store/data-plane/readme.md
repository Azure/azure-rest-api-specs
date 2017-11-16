# DataLakeStore
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for DataLakeStore.



---
## Getting Started 
To build the SDK for DataLakeStore, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the DataLakeStore API.

``` yaml
openapi-type: data-plane
tag: package-2016-11
```


### Tag: package-2016-11

These settings apply only when `--tag=package-2016-11` is specified on the command line.

``` yaml $(tag) == 'package-2016-11'
input-file:
- Microsoft.DataLakeStore/2016-11-01/filesystem.json
```
 
### Tag: package-2015-10-preview

These settings apply only when `--tag=package-2015-10-preview` is specified on the command line.

``` yaml $(tag) == 'package-2015-10-preview'
input-file:
- Microsoft.DataLakeStore/2015-10-01-preview/filesystem.json
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
  namespace: Microsoft.Azure.Management.DataLake.Store
  output-folder: $(csharp-sdks-folder)/DataLake.Store/Management.DataLake.Store/Generated
```


## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: filesystem
  clear-output-folder: true
```

### Tag: package-2016-11 and go

These settings apply only when `--tag=package-2016-11 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2016-11' && $(go)
output-folder: $(go-sdk-folder)/services/datalake/store/2016-11-01/filesystem
```

### Tag: package-2015-10-preview and go

These settings apply only when `--tag=package-2015-10-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2015-10-preview' && $(go)
output-folder: $(go-sdk-folder)/services/datalake/store/2015-10-01-preview/filesystem
```
