# HanaOnAzure

> see https://aka.ms/autorest

This is the AutoRest configuration file for HanaOnAzure.



---
## Getting Started 
To build the SDK for HanaOnAzure, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information
These are the global settings for the HANA on Azure API.

``` yaml
title: HanaManagementClient
description: HANA on Azure Client
openapi-type: arm
tag: package-2017-11
azure-arm: true
```


### Tag: package-2017-11

These settings apply only when `--tag=package-2017-11` is specified on the command line.

``` yaml $(tag) == 'package-2017-11'
input-file:
- Microsoft.HanaOnAzure/preview/2017-11-03-preview/hanaonazure.json
```

### Tag: package-2017-06

These settings apply only when `--tag=package-2017-06` is specified on the command line.

``` yaml $(tag) == 'package-2017-06'
input-file:
- Microsoft.HanaOnAzure/preview/2017-06-15-preview/hanaonazure.json
```


## Python

These settings apply only when `--python` is specified on the command line.

``` yaml $(python)
python:
  # override the default output folder
  output-folder: $(output-folder)/python
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.saphanaonazure
  package-name: azure.mgmt.saphanaonazure
  package-version: 0.0.1
```
