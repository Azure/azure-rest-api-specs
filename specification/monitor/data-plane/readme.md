# MonitorClient
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for MonitorClient.



---
## Getting Started 
To build the SDK for MonitorClient, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the MonitorClient API.

``` yaml
# common 
title: Monitor Client
description: Monitor Client
openapi-type: data-plane
tag: package-2016-09

```


# Tag: package-2016-09

These settings apply only when `--tag=package-2016-09` is specified on the command line.

``` yaml $(tag) == 'package-2016-09'
input-file:
- microsoft.insights/2014-04-01/usageMetrics_API.json
- microsoft.insights/2015-04-01/activityLogs_API.json
- microsoft.insights/2015-04-01/eventCategories_API.json
- microsoft.insights/2015-04-01/tenantActivityLogs_API.json
- microsoft.insights/2016-03-01/metricDefinitions_API.json
- microsoft.insights/2016-09-01/metrics_API.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

