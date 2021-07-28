# EdgeOrder

> see https://aka.ms/autorest

This is the AutoRest configuration file for EdgeOrder.



---
## Getting Started
To build the SDK for EdgeOrder, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information
These are the global settings for the EdgeOrder API.

``` yaml
title: Edge Order API's
openapi-type: arm
tag: package-2020-12-preview
```

### Tag: package-2020-12-preview

These settings apply only when `--tag=package-2020-12-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-12-preview'
input-file:
- Microsoft.EdgeOrder/preview/2020-12-01-preview/edgeorder.json
```
---