# AzureServiceConnectionController

> see https://aka.ms/autorest

This is the AutoRest configuration file for the Microsoft.Network AzureServiceConnectionController ARM API.

## Configuration

```yaml
title: AzureServiceConnectionController
description: Microsoft.Network AzureServiceConnectionController Resource Provider API
openapi-type: arm
tag: package-2026-02-09-preview
```

### Tag: package-2026-02-09-preview

These settings apply only when `--tag=package-2026-02-09-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-02-09-preview'
input-file:
  - preview/2026-02-09-preview/openapi.json
```

### Tag: avocado-examples

These settings are used for CI reference validation of example files.

```yaml $(tag) == 'avocado-examples'
input-file:
  - examples/2026-02-09-preview/Operations_List.json
  - examples/2026-02-09-preview/AzureServiceConnectionControllers_CreateOrUpdate.json
  - examples/2026-02-09-preview/AzureServiceConnectionControllers_Delete.json
  - examples/2026-02-09-preview/AzureServiceConnectionControllers_Get.json
  - examples/2026-02-09-preview/AzureServiceConnectionControllers_ListByResourceGroup.json
  - examples/2026-02-09-preview/AzureServiceConnectionControllers_ListBySubscription.json
  - examples/2026-02-09-preview/AzureServiceConnectionControllers_Patch.json
```
