# Smart Detector Alert Rules API

> see https://aka.ms/autorest

This is the AutoRest configuration file for Smart Detector Alert Rules API.

---

## Getting Started

To build the SDK for Smart Detector Alert Rules API, simply [Install AutoRest](https://aka.ms/autorest/install) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the Smart Detector Alert Rules API.

```yaml
openapi-type: arm
tag: package-2021-04-01
```

### Tag: package-2021-04-01

These settings apply only when `--tag=package-2021-04-01` is specified on the command line.

```yaml $(tag) == 'package-2021-04-01'
input-file:
  - stable/2021-04-01/SmartDetectorAlertRulesApi.json
```

### Tag: package-2019-06-01

These settings apply only when `--tag=package-2019-06-01` is specified on the command line.

```yaml $(tag) == 'package-2019-06-01'
input-file:
  - stable/2019-06-01/SmartDetectorAlertRulesApi.json
```

### Tag: package-2019-03-01

These settings apply only when `--tag=package-2019-03-01` is specified on the command line.

```yaml $(tag) == 'package-2019-03-01'
input-file:
  - stable/2019-03-01/SmartDetectorAlertRulesApi.json
```

---

## Suppression

```yaml
directive:
  - suppress: R3016
    from: SmartDetectorAlertRulesApi.json
    reason: Current API design doesn't have patch operations.
