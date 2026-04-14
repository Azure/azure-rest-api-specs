# VoiceLive

> see https://aka.ms/autorest

This is the AutoRest configuration file for VoiceLive.

## Configuration

### Basic Information

This is a TypeSpec project so we only want to readme to default the default tag and point to the outputted swagger file.
This is used for some tools such as doc generation and swagger apiview generation it isn't used for SDK code gen as we
use the native TypeSpec code generation configured in the tspconfig.yaml file.

```yaml
openapi-type: data-plane
tag: package-2026-04-10
```

### Tag: package-2026-04-10

These settings apply only when `--tag=package-2026-04-10` is specified on the command line.

```yaml $(tag) == 'package-2026-04-10'
input-file:
  - preview/2026-04-10/VoiceLive.json
```

### Tag: package-2026-01-01-preview

These settings apply only when `--tag=package-2026-01-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-01-01-preview'
input-file:
  - preview/2026-01-01-preview/VoiceLive.json
```

### Tag: package-2025-10-01

These settings apply only when `--tag=package-2025-10-01` is specified on the command line.

```yaml $(tag) == 'package-2025-10-01'
input-file:
  - stable/2025-10-01/VoiceLive.json
```

### Suppression

``` yaml
directive:
  - suppress: OAV133
    from: VoiceLive.json
    reason: OpenAI and Azure require two different discriminators.
```
