# Azure Migrate

> see https://aka.ms/autorest

This is the AutoRest configuration file for Azure Migrate - Waves.

---

## Getting Started

To build the SDK for Migrate, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the API.

``` yaml
openapi-type: arm
tag: package-preview-2025-03
```

### Tag: package-preview-2025-03

These settings apply only when `--tag=package-preview-2025-03` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-03'
input-file:
  - preview/2025-03-30-preview/waves.json
suppressions:
  - code: AvoidAdditionalProperties
    reason: Dictionary is used only in the AssessmentOptions proxy resource, which is a singleton and immutable across the assessment Project.
```

## Suppression

``` yaml
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: migrate.json
    where: $.definitions.AssessedMachineProperties.properties.monthlyStandardSSDStorageCost
    reason: SSD is short form.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: migrate.json
    where: $.definitions.AssessmentProperties.properties.monthlyStandardSSDStorageCost
    reason: SSD is short form.
```
