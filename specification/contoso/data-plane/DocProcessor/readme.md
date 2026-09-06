# Contoso DocProcessor

> see https://aka.ms/autorest

This is the AutoRest configuration file for ContosoDocProcessor.

## General Information

These are the global settings for the ContosoDocProcessor API.

```yaml
openapi-type: data-plane
tag: package-2024-01-preview
```

### Tag: package-2024-01-preview

These settings apply only when `--tag=package-2024-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-01-preview'
input-file:
  - preview/2024-01-01-preview/contosodocprocessor.json
```
