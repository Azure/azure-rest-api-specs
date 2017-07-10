# AppInsights
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for AppInsights.



---
## Getting Started 
To build the SDK for AppInsights, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the AppInsights API.

``` yaml
title: AppInsightsManagementClient
description: Composite Swagger for Application Insights Management Client
openapi-type: arm
tag: package-2015-05
```


### Tag: package-2015-05

These settings apply only when `--tag=package-2015-05` is specified on the command line.

``` yaml $(tag) == 'package-2015-05'
input-file:
- microsoft.insights/2015-05-01/aiOperations_API.json
- microsoft.insights/2015-05-01/components_API.json
- microsoft.insights/2015-05-01/webTests_API.json
```


---
## Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

