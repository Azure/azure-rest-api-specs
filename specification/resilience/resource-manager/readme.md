# Resilience

> see https://aka.ms/autorest

This is the AutoRest configuration file for Resilience.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the Resilience.

```yaml
openapi-type: arm
openapi-subtype: providerHub
tag: package-2025-03-01-preview
```

### Tag: package-2024-11-01-preview

These settings apply only when `--tag=package-2024-11-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-11-01-preview'
input-file:
  - Microsoft.Resilience/preview/2024-11-01-preview/resilience.json
```

### Tag: package-2024-06-01-preview

These settings apply only when `--tag=package-2024-06-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-06-01-preview'
input-file:
  - Microsoft.Resilience/preview/2024-06-01-preview/resilience.json
```

### Tag: package-2025-01-01-preview

These settings apply only when `--tag=package-2025-01-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-01-01-preview'
input-file:
  - Microsoft.Resilience/preview/2025-01-01-preview/resilience.json
```

### Tag: package-2025-03-01-preview

These settings apply only when `--tag=package-2025-03-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-03-01-preview'
input-file:
  - Microsoft.Resilience/preview/2025-03-01-preview/resilience.json
```

## Suppression

```yaml
directive:
  - suppress: AvoidAdditionalProperties
    from: resilience.json
    reason: |
      The extendedMetadata field is designed to accept dynamic key-value pairs for
      extensibility. Also note that Microsoft.Resilience is an internal and hidden
      provider with no real customers. (This API Spec is here to satisfy the requirement
      for Azure Resource Notification publishing/RPLite process).
```