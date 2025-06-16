# Azure Migrate

> see https://aka.ms/autorest

This is the AutoRest configuration file for Azure Migrate - Assessment.

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
tag: package-preview-2024-03
```

### Tag: package-preview-2024-03

These settings apply only when `--tag=package-preview-2024-03` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-03'
input-file:
  - preview/2024-03-03-preview/assessmentProjects.json
  - preview/2024-03-03-preview/avsAssessments.json
  - preview/2024-03-03-preview/heterogeneousAssessments.json
  - preview/2024-03-03-preview/machineAssessments.json
  - preview/2024-03-03-preview/sqlAssessments.json
  - preview/2024-03-03-preview/businessCases.json
  - preview/2024-03-03-preview/webAppAssessments.json
  - preview/2024-03-03-preview/webAppCompoundAssessments.json
  - preview/2024-03-03-preview/aksAssessments.json
  - preview/2024-03-03-preview/collectors.json
suppressions:
  - code: AvoidAdditionalProperties
    reason: Dictionary is used only in the AssessmentOptions proxy resource, which is a singleton and immutable across the assessment Project.
```

### Tag: package-2024-01

These settings apply only when `--tag=package-2024-01` is specified on the command line.

```yaml $(tag) == 'package-2024-01'
input-file:
  - stable/2024-01-15/migrate.json
suppressions:
  - code: AvoidAdditionalProperties
    reason: Migrate feature is widely adopted and requires additionalProperties for these swagger properties.
  - code: ProvisioningStateMustBeReadOnly
    reason: The current swagger version only modifies the resources which do not have Provisioning states as readOnly and not introducing any new Resources, These are incorrectly flagged for previous versions.
  - code: UnSupportedPatchProperties
    reason: There is no patch operation that is introduced in this swagger version where it is not readOnly. This is incorrectly flagged for previous versions. 
```

### Tag: package-preview-2024-01

These settings apply only when `--tag=package-preview-2024-01` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-01'
input-file:
  - preview/2024-01-01-preview/migrate.json
suppressions:
  - code: AvoidAdditionalProperties
    reason: Migrate feature is widely adopted and requires additionalProperties for these swagger properties.
  - code: ProvisioningStateMustBeReadOnly
    reason: The current swagger version only modifies the resources which do not have Provisioning states as readOnly and not introducing any new Resources, These are incorrectly flagged for previous versions.
  - code: UnSupportedPatchProperties
    reason: There is no patch operation that is introduced in this swagger version where it is not readOnly. This is incorrectly flagged for previous versions. 
```

### Tag: package-preview-2023-09

These settings apply only when `--tag=package-preview-2023-09` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-09'
input-file:
  - preview/2023-09-09-preview/migrate.json
suppressions:
  - code: AvoidAdditionalProperties
    reason: Migrate feature is widely adopted and requires additionalProperties for these swagger properties.
  - code: ProvisioningStateMustBeReadOnly
    reason: The current swagger version only modifies the resources which do not have Provisioning states as readOnly and not introducing any new Resources, These are incorrectly flagged for previous versions.
  - code: UnSupportedPatchProperties
    reason: There is no patch operation that is introduced in this swagger version where it is not readOnly. This is incorrectly flagged for previous versions. 
```

### Tag: package-preview-2023-05

These settings apply only when `--tag=package-preview-2023-05` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-05'
input-file:
  - preview/2023-05-01-preview/migrate.json
suppressions:
  - code: AvoidAdditionalProperties
    reason: Migrate feature is widely adopted and requires additionalProperties for these swagger properties.
  - code: ProvisioningStateMustBeReadOnly
    reason: The current swagger version only modifies the resources which do not have Provisioning states as readOnly and not introducing any new Resources, These are incorrectly flagged for previous versions.
  - code: UnSupportedPatchProperties
    reason: There is no patch operation that is introduced in this swagger version where it is not readOnly. This is incorrectly flagged for previous versions. 
```

### Tag: package-preview-2023-04

These settings apply only when `--tag=package-preview-2023-04` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-04'
input-file:
  - preview/2023-04-01-preview/migrate.json
```

### Tag: package-2023-03

These settings apply only when `--tag=package-2023-03` is specified on the command line.

```yaml $(tag) == 'package-2023-03'
input-file:
  - stable/2023-03-15/migrate.json
```

### Tag: package-2019-10

These settings apply only when `--tag=package-2019-10` is specified on the command line.

``` yaml $(tag) == 'package-2019-10'
input-file:
- stable/2019-10-01/migrate.json
```

### Tag: package-2018-02

These settings apply only when `--tag=package-2018-02` is specified on the command line.

``` yaml $(tag) == 'package-2018-02'
input-file:
- stable/2018-02-02/migrate.json
```

### Tag: package-preview-2017-11

These settings apply only when `--tag=package-preview-2017-11` is specified on the command line.

``` yaml $(tag) == 'package-preview-2017-11'
input-file:
- preview/2017-11-11-preview/migrate.json
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
