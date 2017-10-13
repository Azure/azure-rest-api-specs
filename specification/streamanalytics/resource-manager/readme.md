# StreamAnalytics

> see https://aka.ms/autorest

This is the AutoRest configuration file for StreamAnalytics.



---
## Getting Started 
To build the SDK for StreamAnalytics, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the StreamAnalytics API.

``` yaml
title: Stream Analytics Management Client
description: Stream Analytics Client
openapi-type: arm
tag: package-2016-03
```


### Tag: package-2016-03

These settings apply only when `--tag=package-2016-03` is specified on the command line.

``` yaml $(tag) == 'package-2016-03'
input-file:
- Microsoft.StreamAnalytics/2016-03-01/streamingjobs.json
- Microsoft.StreamAnalytics/2016-03-01/inputs.json
- Microsoft.StreamAnalytics/2016-03-01/outputs.json
- Microsoft.StreamAnalytics/2016-03-01/transformations.json
- Microsoft.StreamAnalytics/2016-03-01/functions.json
- Microsoft.StreamAnalytics/2016-03-01/subscriptions.json
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
  namespace: Microsoft.Azure.Management.StreamAnalytics
  output-folder: $(csharp-sdks-folder)/StreamAnalytics/Management.StreamAnalytics/Generated
  clear-output-folder: true
```


## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: streamanalytics
  clear-output-folder: true
```

### Tag: package-2016-03 and go

These settings apply only when `--tag=package-2016-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2016-03' && $(go)
output-folder: $(go-sdk-folder)/services/streamanalytics/mgmt/2016-03-01/streamanalytics
```
