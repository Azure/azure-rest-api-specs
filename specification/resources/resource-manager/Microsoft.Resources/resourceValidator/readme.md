# Bicep

> see https://aka.ms/autorest
This is the AutoRest configuration file.

## Getting Started

To build the SDKs, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`
To see additional help and options, run:

> `autorest --help`
For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings.

``` yaml
title: ResourceValidationClient
description: Resource Validation Client
openapi-type: arm
tag: package-2022-06
```

### Tag: package-2022-06

These settings apply only when `--tag=package-2022-06` is specified on the command line.

``` yaml $(tag) == 'package-2022-06'
input-file:
  - stable/2022-06-01/resourceValidator.json
```

## Suppression

``` yaml
directive:
  - suppress: OperationsAPIImplementation
    from: resourceValidator.json
    reason: Operations API is implemented as a separate service.
  - suppress: LocationMustHaveXmsMutability
    from: resourceValidator.json
    where: $.definitions.ResourceValidationRequest.properties.location
    reason: Linter bug. This is a POST request and not a tracked resource properties model.
  - suppress: EnumInsteadOfBoolean
    from: resourceValidator.json
    where: $.definitions.ResourceValidationRequest.properties.performPreflightWithoutRbacWriteCheck
    reason: This is how the existing API models it unfortunately. We can't change it without breaking changes. It is a very descriptively-named binary property.
  - suppress: EnumInsteadOfBoolean
    from: resourceValidator.json
    where: $.definitions.ResourceValidationRequestResource.properties.onlyIfNotExists
    reason: This is how the existing API models it unfortunately. We can't change it without breaking changes. It is a true binary property, however.
  - suppress: AvoidAdditionalProperties
    from: resourceValidator.json
    where: $.definitions.ResourceValidationRequestResource
    reason: This accepts any arbitrary ARM resource payload plus a required apiVersion and an optional onlyIfNotExists property. This is also unfortunately how the existing API works and we can't change it without breaking changes.
```