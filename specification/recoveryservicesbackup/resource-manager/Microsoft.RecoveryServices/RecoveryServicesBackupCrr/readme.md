# RecoveryServicesBackupCRR

> see https://aka.ms/autorest

This is the AutoRest configuration file for RecoveryServicesBackupCRR (Cross Region Restore).

---

## Getting Started

To build the SDK for RecoveryServicesBackupCRR, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the RecoveryServicesBackupCRR API.

```yaml
title: RecoveryServicesBackupCrrClient
description: Open API 2.0 Specs for Azure RecoveryServices Backup CRR service
openapi-type: arm
tag: package-2026-07-15
license-header: MICROSOFT_MIT
```

### Validations

Run validations when `--validate` is specified on command line

```yaml $(validate)
azure-validator: true
model-validator: true
semantic-validator: true
message-format: json
```

### Tag: package-2026-07-15

These settings apply only when `--tag=package-2026-07-15` is specified on the command line.

```yaml $(tag) == 'package-2026-07-15'
input-file:
  - stable/2026-07-15/bms.json
```
