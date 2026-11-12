# Workload Manager

> see https://aka.ms/autorest

This is the AutoRest configuration file for the Workload Manager resource provider.

---

## Configuration

### Basic Information

```yaml
title: WorkloadManagerManagementClient
description: The Workload Manager resource management API.
openapi-type: arm
tag: package-2026-11-01-preview

suppressions:
  - code: OperationsAPIImplementation
    reason: The Microsoft.Compute operations API is defined in the central Compute service specification and is not duplicated in this split subservice.
    from: WorkloadManager.json
```

### Tag: package-2026-11-01-preview

These settings apply only when `--tag=package-2026-11-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-11-01-preview'
input-file:
  - preview/2026-11-01-preview/WorkloadManager.json
```
