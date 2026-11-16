# AzureMachineLearning AIAssets

> see https://aka.ms/autorest

This is the AutoRest configuration file for AzureMachineLearning AIAssets.

---

## Getting Started

To build the SDK for AzureMachineLearning AIAssets, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the AzureMachineLearning API.

```yaml
openapi-type: data-plane
tag: package-2024-05-01-preview
```

### Tag: package-2024-05-01-preview

These settings apply only when `--tag=package-2024-05-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-05-01-preview'
input-file:
  - preview/2024-05-01-preview/azure-ai-assets.json
```

### Tag: package-2024-04-01-preview

These settings apply only when `--tag=package-2024-04-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-04-01-preview'
input-file:
  - preview/2024-04-01-preview/azure-ai-assets.json
```