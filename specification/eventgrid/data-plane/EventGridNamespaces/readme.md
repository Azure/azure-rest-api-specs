# EventGrid

> see https://aka.ms/autorest

This is the AutoRest configuration file for EventGrid.

Multiple Azure services publish events to Azure Event Grid. This is the configuration file for generating
the Publish API and the schemas for those events. Each Azure service publishing to Azure Event Grid has its own tag OpenAPI specification
that describes the schemas for its events.

This configuration enables packaging all of the above as one EventGrid data plane library.
This enables customers to download one EventGrid data plane library instead of having to install separate packages to get the event schemas for each service.

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
title: EventGrid
description: Azure Messaging EventGridClient Namespaces
openapi-type: data-plane
tag: package-2024-06-01
```

### Tag: package-2024-06-01

These settings apply only when `--tag=package-2024-06-01` is specified on the command line.

``` yaml $(tag) == 'package-2024-06-01'
input-file:
- Microsoft.EventGrid/stable/2024-06-01/EventGrid.json
```

### Tag: package-2023-11-01

These settings apply only when `--tag=package-2023-11-01` is specified on the command line.

``` yaml $(tag) == 'package-2023-11-01'
input-file:
- Microsoft.EventGrid/stable/2023-11-01/EventGrid.json
```

### Tag: package-2023-10-01-preview

These settings apply only when `--tag=package-2023-10-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-10-01-preview'
input-file:
- Microsoft.EventGrid/preview/2023-10-01-preview/EventGrid.json

```

### Tag: package-2023-06-01-preview

These settings apply only when `--tag=package-2023-06-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-06-01-preview'
input-file:
- Microsoft.EventGrid/preview/2023-06-01-preview/EventGrid.json
```