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
tag: package-2025-10-01
```

### Tag: package-2025-10-01

These settings apply only when `--tag=package-2025-10-01` is specified on the command line.

```yaml $(tag) == 'package-2025-10-01'
input-file:
  - stable/2025-10-01/GeneratedSystemEvents.json
```

### Suppression

``` yaml
directive:
  - suppress: OAV133
    from: GeneratedSystemEvents.json
    reason: OpenAI and Azure require two different discriminators.
```