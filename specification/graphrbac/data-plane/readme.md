# GraphRbac
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for GraphRbac.



---
## Getting Started 
To build the SDK for GraphRbac, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the GraphRbac API.

``` yaml
# common 
title: GraphRbacManagementClient
description: Azure Active Directory Graph RBAC management client.
openapi-type: data-plane
tag: 1.6

```


# Tag: 1.6

These settings apply only when `--tag=1.6` is specified on the command line.

``` yaml $(tag) == '1.6'
input-file:
- 1.6/graphrbac.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```


#### Language-specific settings: Python

These settings apply only when `--python` is specified on the command line.

``` yaml $(python)
python:
  # override the default output folder
  output-folder: $(output-folder)/python
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.graphrbac
```
