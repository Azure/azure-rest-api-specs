# EventGrid

> see https://aka.ms/autorest

This is the AutoRest configuration file for EventGrid.


Multiple Azure services publish events to Azure Event Grid. This is the configuration file for generating
the Publish API and the schemas for those events. Each Azure service publishing to Azure Event Grid has its own tag OpenAPI specification
that describes the schemas for its events.

This configuration enables packaging all of the above as one EventGrid data plane library.
This enables customers to download one EventGrid data plane library instead of having to install separate packages to get the event schemas for each service.


---
## Getting Started
To build the SDK for EventGrid, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information
These are the global settings for the EventGrid API.

``` yaml
title: EventGridClient
description: EventGrid Client
openapi-type: data-plane
tag: package-2018-01
```

### Tag: package-2018-01

These settings apply only when `--tag=package-2018-01` is specified on the command line.

``` yaml $(tag) == 'package-2018-01'
input-file:
- Microsoft.Storage/stable/2018-01-01/Storage.json
- Microsoft.EventHub/stable/2018-01-01/EventHub.json
- Microsoft.EventGrid/stable/2018-01-01/EventGrid.json
```

---
# Code Generation

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.EventGrid
  sync-methods: None
  output-folder: $(csharp-sdks-folder)/EventGrid/DataPlane/Microsoft.Azure.EventGrid/Generated
  clear-output-folder: true
```


## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
python-mode: create
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.eventgrid
  package-name: azure-eventgrid
  clear-output-folder: true
```
``` yaml $(python) && $(python-mode) == 'update'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/azure-eventgrid/azure/eventgrid
```
``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/azure-eventgrid
```

## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: eventgrid
  clear-output-folder: true
```

### Tag: package-2018-01 and go

These settings apply only when `--tag=package-2018-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-01' && $(go)
output-folder: $(go-sdk-folder)/services/eventgrid/2018-01-01/eventgrid
```

