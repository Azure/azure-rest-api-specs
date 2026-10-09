# AzureMachineLearning WorkspaceDataplane

> see https://aka.ms/autorest

This is the AutoRest configuration file for AzureMachineLearning WorkspaceDataplane.

---

## Getting Started

To build the SDK for AzureMachineLearning WorkspaceDataplane, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the AzureMachineLearning API.

```yaml
openapi-type: data-plane
tag: package-workspace-dataplane-2023-06-01-preview
```

### Tag: package-workspace-dataplane-2023-06-01-preview

These settings apply only when `--tag=package-workspace-dataplane-2023-06-01-preview` is specified on the command line.

```yaml $(tag) == 'package-workspace-dataplane-2023-06-01-preview'
input-file:
  - preview/2023-06-01-preview/workspace-dataplane.json
```