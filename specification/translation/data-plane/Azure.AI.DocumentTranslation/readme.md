# Cognitive Services Document Translation  SDK

> see https://aka.ms/autorest

Configuration for generating Document Translation  SDK.

### Basic Information

These are the global settings for the app.
The current release is `v1.0`.

``` yaml
tag: v1.0
add-credentials: true
openapi-type: data-plane
```

# Releases

### Release Tag: v1.0
These settings apply only when `--tag=v1.0` is specified on the command line.

``` yaml $(tag) == 'v1.0'
input-file: 
  - stable/v1.0/openapi.json
```

### Tag: package-2023-11-01-preview

These settings apply only when `--tag=2023-11-01-preview` is specified on the command line.

```yaml $(tag) == '2023-11-01-preview'
input-file:
  - preview/2023-11-01-preview/openapi.json
```
