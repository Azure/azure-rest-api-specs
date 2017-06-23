# TimeSeriesInsights
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for TimeSeriesInsights.



---
## Getting Started 
To build the SDK for TimeSeriesInsights, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the TimeSeriesInsights API.

``` yaml
# common 
title: Time Series Insights
description: Time Series Insights Client
openapi-type: arm
tag: package-2017-02-preview

```


# Tag: package-2017-02-preview

These settings apply only when `--tag=package-2017-02-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-02-preview'
input-file:
- Microsoft.TimeSeriesInsights/2017-02-28-preview/timeseriesinsights.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

