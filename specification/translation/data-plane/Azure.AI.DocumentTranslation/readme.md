# Cognitive Services Document Translation  SDK

> see https://aka.ms/autorest

Configuration for generating Document Translation  SDK.

### Basic Information

These are the global settings for the app.
The current release is `package-2024-05-01`.

``` yaml
tag: package-2024-05-01
add-credentials: true
openapi-type: data-plane
```

# Releases

### Release Tag: 2024-05-01
These settings apply only when `--tag=package-2024-05-01` is specified on the command line.

``` yaml $(tag) == 'package-2024-05-01'
input-file: 
  - stable/2024-05-01/openapi.json
suppressions:
  - code: ValidFormats
    from: openapi.json
    reason: Format is the name of the property and lint diff shouldn't be validating that
```

### Release 2023-11-01-preview
These settings apply only when `--tag=2023-11-01-preview` is specified on the command line.

``` yaml $(tag) == '2023-11-01-preview'
version: 2023-11-01-preview
input-file:
  - preview/2023-11-01-preview/openapi.json
```