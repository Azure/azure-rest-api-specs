# ApplicationInsights
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for ApplicationInsightsDataPlane.



---
## Getting Started 
To build the SDK for ApplicationInsightsDataPlane, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information 

These are the global settings for the ApplicationInsights API.

``` yaml
title: ApplicationInsightsDataClient
description: Composite Swagger for Application Insights Data Client
add-credentials: true
openapi-type: data-plane
tag: v1
```

### Tag: v1

These settings apply only when `--tag=v1` is specified on the command line.

``` yaml $(tag) == 'v1'
input-file:
- microsoft.insights/v1/AppInsights.json
```

# Code Generation

## C# 

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.ApplicationInsights
  output-folder: $(csharp-sdks-folder)/ApplicationInsights/Data.ApplicationInsights/Generated
  clear-output-folder: true
  payload-flattening-threshold: 3
directive:
  - reason: Don't expose the GET endpoint since it's behavior is more limited than POST
    remove-operation: GetQuery
```


## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: insights
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: v1
```

### Tag: v1 and go

These settings apply only when `--tag=v1 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'v1' && $(go)
output-folder: $(go-sdk-folder)/services/appinsights/v1/insights
```

