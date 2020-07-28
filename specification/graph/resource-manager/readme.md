# Graph

> see https://aka.ms/autorest

This is the AutoRest configuration file for Graph.

---

## Getting Started

To build the SDK for Graph, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the Graph API.

``` yaml
title: GraphManagementClient
description: Graph Client
openapi-type: arm
tag: package-1.0
```


### Tag: package-1.0

These settings apply only when `--tag=package-1.0` is specified on the command line.

```yaml $(tag) == 'package-1.0'
input-file:
  - Microsoft.Graph/preview/1.0/graph.json
  - Microsoft.Graph/preview/1.0/guest.json
```
