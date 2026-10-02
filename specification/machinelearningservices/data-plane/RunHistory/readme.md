# AzureMachineLearning RunHistory

> see https://aka.ms/autorest

This is the AutoRest configuration file for AzureMachineLearning RunHistory.

---

## Getting Started

To build the SDK for AzureMachineLearning RunHistory, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the AzureMachineLearning API.

```yaml
openapi-type: data-plane
tag: package-runhistory-v1.0
```

### Tag: package-runhistory-v1.0

These settings apply only when `--tag=package-runhistory-v1.0` is specified on the command line.

```yaml $(tag) == 'package-runhistory-v1.0'
input-file:
  - stable/v1.0/run-history.json
```

### Tag: package-runhistory-2019-08-01

```yaml $(tag) == 'package-runhistory-2019-08-01'
input-file:
  - stable/2019-08-01/runHistory.json
```

### Tag: package-runhistory-2019-09-30

```yaml $(tag) == 'package-runhistory-2019-09-30'
input-file:
  - stable/2019-09-30/runHistory.json
```
