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
tag: package-v1
```

### Tag: package-v1

These settings apply only when `--tag=package-v1` is specified on the command line.

```yaml $(tag) == 'package-v1'
input-file:
  - openapi3/v1/VoiceLive.json
```

### Tag: package-virtual-public-preview

These settings apply only when `--tag=package-virtual-public-preview` is specified on the command line.

```yaml $(tag) == 'package-virtual-public-preview'
input-file:
  - openapi3/virtual-public-preview/VoiceLive.json
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

## Contributing

VoiceLive uses the **label-based (`v1`) versioning** pattern. For authoring rules — how to add
GA and preview features, promote preview to GA, handle breaking changes, and compile/send a PR
— see [CONTRIBUTING.md](CONTRIBUTING.md). For the full design and rationale, see
[docs/versioning.md](docs/versioning.md).
