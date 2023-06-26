# connectedcredentials

> see https://aka.ms/autorest
This is the AutoRest configuration file for connectedcredentials.

### Basic Information

This is a TypeSpec project so we only want to readme to default the default tag and point to the outputted swagger file.
This is used for some tools such as doc generation and swagger apiview generation it isn't used for SDK code gen as we
use the native TypeSpec code generation configured in the tspconfig.yaml file.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2023-06-12-preview
```

### Tag: package-2023-06-12-preview

These settings apply only when `--tag=package-2023-06-12-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-06-12-preview'
input-file:
  - Microsoft.ConnectedCredentials/preview/2023-06-12-preview/connectedcredentials.json
```
