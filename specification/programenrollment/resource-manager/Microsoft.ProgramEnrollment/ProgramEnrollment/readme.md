# ProgramEnrollment

> see https://aka.ms/autorest

This is the AutoRest configuration file for ProgramEnrollment.

## Configuration

### Basic Information

This is a TypeSpec project so we only want to readme to default the default tag and point to the outputted swagger file.
This is used for some tools such as doc generation and swagger apiview generation it isn't used for SDK code gen as we
use the native TypeSpec code generation configured in the tspconfig.yaml file.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-preview-2026-03-01
```

### Tag: package-preview-2026-03-01

These settings apply only when `--tag=package-preview-2026-03-01` is specified on the command line.

```yaml $(tag) == 'package-preview-2026-03-01'
input-file:
  - preview/2026-03-01-preview/openapi.json

directive:
  - suppress: GuidUsage
    from:
      - openapi.json
    where:
      - $.definitions["Azure.Core.uuid"].format
    reason: |
      The tenantId field on DomainGroup references a Microsoft Entra
      tenant identifier, which is a UUID/GUID by definition. ARM reviewer
      (Chris Stackhouse) confirmed this change and will approve the
      suppression.
```

---
