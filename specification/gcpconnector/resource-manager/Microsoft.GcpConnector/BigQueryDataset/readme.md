# BigQueryDataset

> see https://aka.ms/autorest

This is the AutoRest configuration file for BigQueryDataset.

---

## Getting Started

To build the SDK for BigQueryDataset, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for BigQueryDataset.

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
      - $.definitions.BigQueryDatasetProperties.properties.gcpTags
      - $.definitions.BigQueryDatasetTagsUpdate.properties.tags
      - $.definitions.GcpBigQueryDatasetProperties.properties.labels
      - $.definitions.GcpBigQueryDatasetProperties.properties.resourceTags
```

### Tag: package-2027-01-01

These settings apply only when `--tag=package-2027-01-01` is specified on the command line.

```yaml $(tag) == 'package-2027-01-01'
input-file:
  - stable/2027-01-01/bigQueryDataset.json
```
