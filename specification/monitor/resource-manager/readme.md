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

## Configuration



### Basic Information 
These are the global settings for the MonitorClient API.

``` yaml
title: MonitorClient
description: Monitor Management Client
openapi-type: arm
tag: package-2017-03
```


### Tag: package-2017-03

These settings apply only when `--tag=package-2017-03` is specified on the command line.

``` yaml $(tag) == 'package-2017-03'
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
## Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```


## Language-specific settings: Python

These settings apply only when `--python` is specified on the command line.

``` yaml $(python)
python:
  # override the default output folder
  output-folder: $(output-folder)/python
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.monitor
```
