# Azure Maps

> see https://aka.ms/autorest

This is the AutoRest configuration file for MapsClient

---

## Getting Started

To build the SDK for Maps, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for MapsClient.

``` yaml
title: MapsClient
openapi-type: data-plane
```

### Suppression

``` yaml
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: timezone.json
    reason: It will break existing clients if we change the name

  - suppress: LroExtension
    from: search.json
    where: $.paths["/providers/Microsoft.Subscription/subscriptionOperations/{operationId}"].get
    reason: The reason for this suppression is the API is already released and introducing new LRO properties will not function and are not supported today and will only be developed for the next version of this API.

  - suppress: RESPONSE_SCHEMA_NOT_IN_SPEC
    reason: false positive from oav is breaking our example validation. See azure/oav#1021.

```
