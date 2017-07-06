# CustomerInsights
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for CustomerInsights.



---
## Getting Started 
To build the SDK for CustomerInsights, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the CustomerInsights API.

``` yaml
# common 
title: Customer Insights
description: Customer Insights Client
openapi-type: arm
tag: package-2017-04

```


# Tag: package-2017-04

These settings apply only when `--tag=package-2017-04` is specified on the command line.

``` yaml $(tag) == 'package-2017-04'
input-file:
- Microsoft.CustomerInsights/2017-04-26/customer-insights.json

```


# Tag: package-2017-01

These settings apply only when `--tag=package-2017-01` is specified on the command line.

``` yaml $(tag) == 'package-2017-01'
input-file:
- Microsoft.CustomerInsights/2017-01-01/customer-insights.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

