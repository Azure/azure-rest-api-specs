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
## Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

