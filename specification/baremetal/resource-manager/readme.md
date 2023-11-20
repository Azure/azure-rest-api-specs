# AzureBridge Admin

> see https://aka.ms/autorest

This is the AutoRest configuration file for BootstrapRP.

---
## Getting Started
To build the SDK for AzureBridge Admin, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information
These are the global settings for the BootstrapRP API.

``` yaml
title: BootstrapRP
description: BootstrapRP Client
openapi-type: arm
openapi-subtype: providerHub
tag: package-2021-06
```

### Tag: 2021-06-01

These settings apply only when `--tag=package-2021-06` is specified on the command line.

``` yaml $(tag) == 'package-2021-06'
input-file:
    - Microsoft.BareMetal/preview/2021-06-01-preview/BootstrapRP.json
```

## Suppression

``` yaml
suppressions:
  - code: ParametersInPointGet
    from: BootstrapRP.json
    reason: Error with Lint test
  - code: RequestBodyMustExistForPutPatch
    from: BootstrapRP.json
    reason: Error with Lint test
  - code: TrackedExtensionResourcesAreNotAllowed
    from: BootstrapRP.json
    reason: Error with Lint test
  - code: PathForTrackedResourceTypes
    from: BootstrapRP.json
    reason: Error with Lint test
  - code: PatchPropertiesCorrespondToPutProperties
    from: BootstrapRP.json
    reason: Tags are the only property permitted to be updated.  Tags is inside TrackedResource on the PUT, which has a required field, location.
```