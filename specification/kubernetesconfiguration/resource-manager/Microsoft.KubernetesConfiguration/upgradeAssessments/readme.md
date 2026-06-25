# kubernetesconfiguration

> see https://aka.ms/autorest

This is the AutoRest configuration file for KubernetesConfiguration.

## Getting Started

To build the SDKs for UpgradeAssessments in KubernetesConfiguration, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the UpgradeAssessments in KubernetesConfiguration.

``` yaml
title: UpgradeAssessmentsClient
description: APIs for cluster upgrade assessment resources under Microsoft.KubernetesConfiguration.
openapi-type: arm
tag: package-2026-06-preview
```

---

### Tag: package-2026-06-preview

These settings apply only when `--tag=package-2026-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2026-06-preview'
input-file:
  - preview/2026-06-15-preview/upgradeAssessments.json
suppressions:
  - code: OperationsAPIImplementation
    from: upgradeAssessments.json
    reason: Operations API is implemented as a separate service.
```