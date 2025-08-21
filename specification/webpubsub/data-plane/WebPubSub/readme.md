# Web PubSub Service`

> see https://aka.ms/autorest

This is the AutoRest configuration file for Web PubSub Service.

## Configuration

### Basic Information

This is a TypeSpec project so we only want the readme for the default tag and point to the outputted swagger file.
This is used for some tools such as doc generation and swagger apiview generation it isn't used for SDK code gen as we
use the native TypeSpec code generation configured in the tspconfig.yaml file.

``` yaml
openapi-type: data-plane
tag: package-2024-12-01
```

### Suppression

``` yaml
directive:
  - suppress: LROStatusCodesReturnTypeSchema
    reason: For this data plane API, it is not a long run operation and the status code indicates the results.
  - suppress: XmsExamplesRequired
    reason: There are a lot of APIs that does not have the example. While it is being worked upon disabling this to ensure that we catch and fix other violations
```


### Tag: package-2024-12-01

These settings apply only when `--tag=package-2024-12-01` is specified on the command line.

```yaml $(tag) == 'package-2024-12-01'
input-file:
  - WebPubSub/stable/2024-12-01/webpubsub.json