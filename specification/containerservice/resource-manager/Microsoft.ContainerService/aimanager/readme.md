# Azure Kubernetes AI Manager

> see https://aka.ms/autorest

This is the AutoRest configuration file for Azure Kubernetes AI Manager.

## Getting Started

To build the SDKs for Azure Kubernetes AI Manager, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the AI Manager API.

```yaml
openapi-type: arm
tag: package-2026-04-02-preview
```

### Tag: package-2026-04-02-preview

These settings apply only when `--tag=package-2026-04-02-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-04-02-preview'
input-file:
  - preview/2026-04-02-preview/aimanagers.json
suppressions:
  - code: AvoidAdditionalProperties
    from: aimanagers.json
    where: $.definitions.AIManagerNamespaceProperties.properties.labels
    reason: Labels are a key/value map that is passed through to the underlying Kubernetes model.
  - code: AvoidAdditionalProperties
    from: aimanagers.json
    where: $.definitions.AIManagerNamespaceProperties.properties.annotations
    reason: Annotations are a key/value map that is passed through to the underlying Kubernetes model.
```
