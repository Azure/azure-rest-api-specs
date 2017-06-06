# TrafficManager
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for TrafficManager.



---
## Getting Started 
To build the SDK for TrafficManager, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration for generating APIs


---
#### Basic Information 
These are the global settings for the TrafficManager API.

``` yaml
# common 
title: Traffic Manager
description: Traffic Manager Client
tag: 2017-05-01

```


# Tag: 2017-05-01

These settings apply only when `--tag=2017-05-01` is specified on the command line.

``` yaml $(tag) == '2017-05-01'
input-file:
- Microsoft.Network/2017-05-01/trafficmanager.json

```


# Tag: 2017-03-01

These settings apply only when `--tag=2017-03-01` is specified on the command line.

``` yaml $(tag) == '2017-03-01'
input-file:
- Microsoft.Network/2017-03-01/trafficmanager.json

```
 
# Tag: 2015-11-01

These settings apply only when `--tag=2015-11-01` is specified on the command line.

``` yaml $(tag) == '2015-11-01'
input-file:
- Microsoft.Network/2015-11-01/trafficmanager.json

```


---
#### Language-specific settings: CSharp

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  # override the default output folder
  output-folder: $(output-folder)/csharp
```

