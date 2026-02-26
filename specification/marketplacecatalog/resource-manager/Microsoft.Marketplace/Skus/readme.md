# Marketplace Catalog Skus

> see https://aka.ms/autorest

This is the AutoRest configuration file for Marketplace Catalog Skus.

## Configuration

### Basic Information

This is a TypeSpec project so we only want the readme to default the default tag and point to the outputted swagger file.
This is used for some tools such as doc generation and swagger apiview generation. It isn't used for SDK code gen as we
use the native TypeSpec code generation configured in the tspconfig.yaml file.

```yaml
openapi-type: arm
tag: package-2025-05-01
```

### Tag: package-2025-05-01

These settings apply only when `--tag=package-2025-05-01` is specified on the command line.

```yaml $(tag) == 'package-2025-05-01'
input-file:
  - stable/2025-05-01/openapi.json

suppressions:
  - code: RequiredPropertiesMissingInResourceModel
    from: openapi.json
    where: $.definitions.SkuSummaryListResult
    reason: SkuSummaryListResult is a paged collection model, not an ARM resource. It does not need id, name, or type properties.
```

---

