# CloudFunction

> see https://aka.ms/autorest

This is the AutoRest configuration file for CloudFunction.

---

## Getting Started

To build the SDK for CloudFunction, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for CloudFunction.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2027-01-01
```

### Suppression

```yaml
directive:
  - suppress: AvoidAdditionalProperties
    reason: Properties in the GCP definition represent user-defined tags, labels and environment variables.
    where:
      - $.definitions.FunctionProperties.properties.gcpTags
      - $.definitions.BuildConfig.properties.environmentVariables
      - $.definitions.CloudFunctionTagsUpdate.properties.tags
      - $.definitions.GcpFunctionProperties.properties.labels
      - $.definitions.ServiceConfig.properties.environmentVariables
```

### Tag: package-2027-01-01

These settings apply only when `--tag=package-2027-01-01` is specified on the command line.

```yaml $(tag) == 'package-2027-01-01'
input-file:
  - stable/2027-01-01/cloudFunction.json
```
