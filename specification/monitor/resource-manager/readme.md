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
title: Monitor Management Client
description: Monitor Management Client
api-version: 2017-03-01

```


# API Version: 2017-03-01

These settings apply only when `--api-version=2017-03-01` is specified on the command line.

``` yaml $(api-version) == '2017-03-01'
input-file:
- microsoft.insights/2015-04-01/autoscale_API.json
- microsoft.insights/2016-03-01/alertRulesIncidents_API.json
- microsoft.insights/2016-03-01/alertRules_API.json
- microsoft.insights/2016-03-01/logProfiles_API.json
- microsoft.insights/2016-09-01/serviceDiagnosticsSettings_API.json
- microsoft.insights/2017-03-01-preview/activityLogAlerts_API.json
- microsoft.insights/2017-04-01/actionGroups_API.json
- microsoft.insights/2017-04-01/activityLogAlerts_API.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

