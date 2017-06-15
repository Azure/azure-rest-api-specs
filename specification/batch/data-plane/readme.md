# Batch
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Batch.



---
## Getting Started 
To build the SDK for Batch, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the Batch API.

``` yaml
# common 
title: Batch
description: Batch Client
openapi-type: data-plane
tag: 2017-06-01.5.1

```


# Tag: 2017-06-01.5.1

These settings apply only when `--tag=2017-06-01.5.1` is specified on the command line.

``` yaml $(tag) == '2017-06-01.5.1'
input-file:
- Microsoft.Batch/2017-06-01.5.1/BatchService.json

```


# Tag: 2017-05-01.5.0

These settings apply only when `--tag=2017-05-01.5.0` is specified on the command line.

``` yaml $(tag) == '2017-05-01.5.0'
input-file:
- Microsoft.Batch/2017-05-01.5.0/BatchService.json

```


# Tag: 2017-01-01.4.0

These settings apply only when `--tag=2017-01-01.4.0` is specified on the command line.

``` yaml $(tag) == '2017-01-01.4.0'
input-file:
- Microsoft.Batch/2017-01-01.4.0/BatchService.json

```
 
# Tag: 2016-07-01.3.1

These settings apply only when `--tag=2016-07-01.3.1` is specified on the command line.

``` yaml $(tag) == '2016-07-01.3.1'
input-file:
- Microsoft.Batch/2016-07-01.3.1/BatchService.json

```
 
# Tag: 2016-02-01.3.0

These settings apply only when `--tag=2016-02-01.3.0` is specified on the command line.

``` yaml $(tag) == '2016-02-01.3.0'
input-file:
- Microsoft.Batch/2016-02-01.3.0/BatchService.json

```
 
# Tag: 2015-12-01.2.2

These settings apply only when `--tag=2015-12-01.2.2` is specified on the command line.

``` yaml $(tag) == '2015-12-01.2.2'
input-file:
- Microsoft.Batch/2015-12-01.2.2/BatchService.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

