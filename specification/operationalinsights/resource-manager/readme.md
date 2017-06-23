# OperationalInsights
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for OperationalInsights.



---
## Getting Started 
To build the SDK for OperationalInsights, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the OperationalInsights API.

``` yaml
# common 
title: Operational Insights
description: Operational Insights Client
openapi-type: arm
tag: package-2015-11-preview

```


# Tag: package-2015-11-preview

These settings apply only when `--tag=package-2015-11-preview` is specified on the command line.

``` yaml $(tag) == 'package-2015-11-preview'
input-file:
- Microsoft.OperationalInsights/2015-11-01-preview/OperationalInsights.json
- Microsoft.OperationalInsights/2015-03-20/OperationalInsights.json

```
 
# Tag: package-2015-03

These settings apply only when `--tag=package-2015-03` is specified on the command line.

``` yaml $(tag) == 'package-2015-03'
input-file:
- Microsoft.OperationalInsights/2015-03-20/OperationalInsights.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

