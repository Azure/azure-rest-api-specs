# RecoveryServicesBackupCrr

> see https://aka.ms/autorest

This is the AutoRest configuration file for the Recovery Services Backup Cross Region Restore service.

---

## Getting Started

To build the SDK, install [AutoRest](https://aka.ms/autorest/install) and run:

> `autorest`

---

## Configuration

```yaml
title: Recovery Services Backup Passive Client
description: OpenAPI 2.0 specifications for the Azure Recovery Services Backup Cross Region Restore service
openapi-type: arm
tag: package-passivestamp-2023-01-15
license-header: MICROSOFT_MIT
```

### Validations

```yaml $(validate)
azure-validator: true
model-validator: true
semantic-validator: true
message-format: json
```

### Tag: package-passivestamp-2023-01-15

```yaml $(tag) == 'package-passivestamp-2023-01-15'
input-file:
  - stable/2023-01-15/bms.json
```

## Suppression

```yaml $(directive)
directive:
  - suppress: TrackedResourceBeyondsThirdLevel
    from: bms.json
    where: $.definitions.RecoveryPointResource
    reason: Existing CRR recovery point resource retained for compatibility in API version 2023-01-15.
  - suppress: LroErrorContent
    from: bms.json
    reason: The service API infrastructure converts exceptions to the existing CloudError contract; changing it would be a breaking change.
```
