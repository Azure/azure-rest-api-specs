# StorageBucket

> see https://aka.ms/autorest

This is the AutoRest configuration file for StorageBucket.

---

## Getting Started

To build the SDK for StorageBucket, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for StorageBucket.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2027-01-01
```

### Suppression

```yaml
directive:
  - suppress: OperationsAPIImplementation
    reason: The Operations API for Microsoft.GcpConnector is defined once for the whole resource provider in the GcpConnector spec (GcpConnector/stable/2027-01-01/operations.json).
  - suppress: AvoidAdditionalProperties
    reason: Properties in the GCP definition represent user-defined tags and labels.
    where:
      - $.definitions.BucketProperties.properties.gcpTags
      - $.definitions.GcpBucketProperties.properties.labels
      - $.definitions.StorageBucketTagsUpdate.properties.tags
```

### Tag: package-2027-01-01

These settings apply only when `--tag=package-2027-01-01` is specified on the command line.

```yaml $(tag) == 'package-2027-01-01'
input-file:
  - stable/2027-01-01/storageBucket.json
```
