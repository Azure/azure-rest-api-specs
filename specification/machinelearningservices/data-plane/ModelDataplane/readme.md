# AzureMachineLearning ModelDataplane

> see https://aka.ms/autorest

This is the AutoRest configuration file for AzureMachineLearning ModelDataplane.

---

## Getting Started

To build the SDK for AzureMachineLearning ModelDataplane, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the AzureMachineLearning API.

```yaml
openapi-type: data-plane
tag: package-model-dataplane-1.0.0
```

### Tag: package-model-dataplane-1.0.0

These settings apply only when `--tag=package-model-dataplane-1.0.0` is specified on the command line.

```yaml $(tag) == 'package-model-dataplane-1.0.0'
input-file:
  - stable/1.0.0/model-dataplane.json
```