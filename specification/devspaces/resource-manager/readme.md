# DevSpaces

> see https://aka.ms/autorest

This is the AutoRest configuration file for DevSpaces.


---
## Getting Started
To build the SDK for DevSpaces, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information
These are the global settings for the DevSpaces API.

``` yaml
title: DevSpacesManagementClient
description: Dev Spaces Client
openapi-type: arm
tag: package-2018-06-01-preview
```

### Tag: package-2018-06-01-preview

These settings apply only when `--tag=package-2018-06-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-06-01-preview'
input-file:
- Microsoft.DevSpaces/preview/2018-06-01-preview/devspaces.json
```


---
# Code Generation


## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  # last generated with AutoRest.1.0.0-Nightly20170126
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.DevSpaces
  payload-flattening-threshold: 2
  output-folder: $(csharp-sdks-folder)/DevSpaces/Management.DevSpaces/Generated
  clear-output-folder: true
```

## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: devspaces
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2018-06-01-preview
```

### Tag: package-2018-06-01-preview and go

These settings apply only when `--tag=package-2018-06-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-06-01-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2018-06-01-preview/$(namespace)
```
