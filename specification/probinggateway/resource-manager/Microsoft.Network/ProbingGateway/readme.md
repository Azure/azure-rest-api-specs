# ProbingGateway

> see https://aka.ms/autorest

This is the AutoRest configuration file for the Microsoft.Network ProbingGateway ARM API.

## Configuration

```yaml
title: ProbingGateway
description: Microsoft.Network ProbingGateway Resource Provider API
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
  - examples/2026-02-09-preview/ProbingGateways_CreateOrUpdate.json
  - examples/2026-02-09-preview/ProbingGateways_Delete.json
  - examples/2026-02-09-preview/ProbingGateways_Get.json
  - examples/2026-02-09-preview/ProbingGateways_ListByResourceGroup.json
  - examples/2026-02-09-preview/ProbingGateways_ListBySubscription.json
  - examples/2026-02-09-preview/ProbingGateways_Patch.json
```
