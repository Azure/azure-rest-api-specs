# VoiceLive

> see https://aka.ms/autorest

This is the AutoRest configuration file for VoiceLive.

## Configuration

### Basic Information

This is a TypeSpec project so this readme only points to the outputted swagger files.
This is used for some tools such as doc generation and swagger apiview generation it isn't used for SDK code gen as we
use the native TypeSpec code generation configured in the tspconfig.yaml file. The default (latest)
API version is controlled by the `@azure-tools/typespec-autorest` emitter in tspconfig.yaml.

```yaml
openapi-type: data-plane
```

### Tag: package-2026-07-15

These settings apply only when `--tag=package-2026-07-15` is specified on the command line.

```yaml $(tag) == 'package-2026-07-15'
input-file:
  - stable/2026-07-15/VoiceLive.json
```

### Tag: package-2026-06-01-preview

These settings apply only when `--tag=package-2026-06-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-06-01-preview'
input-file:
  - preview/2026-06-01-preview/VoiceLive.json
```

### Tag: package-2026-04-10

These settings apply only when `--tag=package-2026-04-10` is specified on the command line.

```yaml $(tag) == 'package-2026-04-10'
input-file:
  - stable/2026-04-10/VoiceLive.json
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
  - suppress: IntegerTypeMustHaveFormat
    from: VoiceLive.json
    where: $.definitions.ResponseSession.properties.expires_at
    reason: OpenAI Realtime uses the "unixtime" format, which this legacy rule does not recognize.
```
