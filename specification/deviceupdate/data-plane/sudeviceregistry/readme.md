# Software Update for Device Registry

> see https://aka.ms/autorest

This is the AutoRest configuration file for Software Update for Device Registry.

## Configuration

### Basic Information

This TypeSpec service uses native TypeSpec SDK generation configured in
`tspconfig.yaml`. This file supplies the generated OpenAPI document to tools
such as documentation generation and Swagger APIView generation.

```yaml
openapi-type: data-plane
tag: package-2026-11-02-preview
```

### Tag: package-2026-11-02-preview

These settings apply only when `--tag=package-2026-11-02-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-11-02-preview'
input-file:
  - preview/2026-11-02-preview/softwareupdatedeviceregistry.json
```