# GuestResources

> see https://aka.ms/autorest

This is the AutoRest configuration file for GuestResources.

## Configuration

### Basic Information

This is a TypeSpec project so we only want the readme to default the default tag and point to the outputted swagger file.
This is used for some tools such as doc generation and swagger apiview generation — it isn't used for SDK code gen as we
use the native TypeSpec code generation configured in the tspconfig.yaml file.

```yaml
openapi-type: arm
tag: package-2026-03-01
```

### Tag: package-2026-03-01

These settings apply only when `--tag=package-2026-03-01` is specified on the command line.

```yaml $(tag) == 'package-2026-03-01'
input-file:
  - stable/2026-03-01/guestresources.json
```
