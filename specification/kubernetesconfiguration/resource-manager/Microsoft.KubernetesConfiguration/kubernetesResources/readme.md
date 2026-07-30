# kubernetesconfiguration

> see https://aka.ms/autorest

This is the AutoRest configuration file for KubernetesConfiguration.

## Getting Started

To build the SDKs for KubernetesConfiguration kubernetes resources, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the KubernetesConfiguration.

``` yaml
title: KubernetesResourcesClient
description: KubernetesConfiguration Kubernetes Resources Client
openapi-type: arm
tag: package-preview-2026-07
```

---

### Tag: package-preview-2026-07

These settings apply only when `--tag=package-preview-2026-07` is specified on the command line.

``` yaml $(tag) == 'package-preview-2026-07'
input-file:
  - preview/2026-07-01-preview/KubernetesResources.json
suppressions:
  - code: OperationsAPIImplementation
    from: KubernetesResources.json
    reason: Operations API is implemented as a separate service.
```