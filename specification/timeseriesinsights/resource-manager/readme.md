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
api-version: 2017-02-28-preview

```


# API Version: 2017-02-28-preview

These settings apply only when `--api-version=2017-02-28-preview` is specified on the command line.

``` yaml $(api-version) == '2017-02-28-preview'
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

