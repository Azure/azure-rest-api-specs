# Advisor
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Advisor.



---
## Getting Started 
To build the SDK for Advisor, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the Advisor API.

``` yaml
# common 
title: Advisor
description: Advisor Client
openapi-type: arm
tag: 2017-04-19

```


# Tag: 2017-04-19

These settings apply only when `--tag=2017-04-19` is specified on the command line.

``` yaml $(tag) == '2017-04-19'
input-file:
- Microsoft.Advisor/2017-04-19/advisor.json

```
 
# Tag: 2017-03-31

These settings apply only when `--tag=2017-03-31` is specified on the command line.

``` yaml $(tag) == '2017-03-31'
input-file:
- Microsoft.Advisor/2017-03-31/advisor.json

```
 
# Tag: 2016-07-12-preview

These settings apply only when `--tag=2016-07-12-preview` is specified on the command line.

``` yaml $(tag) == '2016-07-12-preview'
input-file:
- Microsoft.Advisor/2016-07-12-preview/advisor.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

