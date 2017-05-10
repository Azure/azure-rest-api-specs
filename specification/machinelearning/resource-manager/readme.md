# MachineLearning
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for MachineLearning.



---
## Getting Started 
To build the SDK for MachineLearning, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the MachineLearning API.

``` yaml
# common 
title: Machine Learning
description: Machine Learning Client
api-version: 2017-01-01

```


# API Version: 2017-01-01

These settings apply only when `--api-version=2017-01-01` is specified on the command line.

``` yaml $(api-version) == '2017-01-01'
input-file:
- Microsoft.MachineLearning/2016-05-01-preview/commitmentPlans.json
- Microsoft.MachineLearning/2017-01-01/webservices.json

```
 
# API Version: 2016-05-01-preview

These settings apply only when `--api-version=2016-05-01-preview` is specified on the command line.

``` yaml $(api-version) == '2016-05-01-preview'
input-file:
- Microsoft.MachineLearning/2016-05-01-preview/commitmentPlans.json
- Microsoft.MachineLearning/2016-05-01-preview/webservices.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

