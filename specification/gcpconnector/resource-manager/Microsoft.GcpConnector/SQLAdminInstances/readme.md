# SQLAdminInstances

> see https://aka.ms/autorest

This is the AutoRest configuration file for SQLAdminInstances.

---

## Getting Started

To build the SDK for SQLAdminInstances, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for SQLAdminInstances.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2027-01-01
```

### Suppression

```yaml
directive:
  - suppress: AvoidAdditionalProperties
    reason: Properties in the GCP definition represent user-defined tags and labels.
    where:
      - $.definitions.SQLAdminInstanceProperties.properties.gcpTags
      - $.definitions.SQLAdminInstanceTagsUpdate.properties.tags
      - $.definitions.Settings.properties.userLabels
```

### Tag: package-2027-01-01

These settings apply only when `--tag=package-2027-01-01` is specified on the command line.

```yaml $(tag) == 'package-2027-01-01'
input-file:
  - stable/2027-01-01/sqlAdminInstance.json
```
