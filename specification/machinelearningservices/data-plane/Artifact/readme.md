# AzureMachineLearning Artifact

> see https://aka.ms/autorest

This is the AutoRest configuration file for AzureMachineLearning Artifact.

---

## Getting Started

To build the SDK for AzureMachineLearning Artifact, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the AzureMachineLearning API.

```yaml
openapi-type: data-plane
tag: package-2019-08
```

### Tag: package-2019-08

These settings apply only when `--tag=package-2019-08` is specified on the command line.

```yaml $(tag) == 'package-2019-08'
input-file:
  - stable/2019-08-01/artifact.json
```

### Tag: package-2019-09

These settings apply only when `--tag=package-2019-09` is specified on the command line.

```yaml $(tag) == 'package-2019-09'
input-file:
  - stable/2019-09-30/artifact.json
```