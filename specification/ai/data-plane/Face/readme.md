# Cognitive Services Face SDK

> see https://aka.ms/autorest

Configuration for generating Face SDK.

The current release is `v1.0`.

``` yaml

tag: v1.0
add-credentials: true
openapi-type: data-plane
```
# Releases

### Release v1.0
These settings apply only when `--tag=v1.0` is specified on the command line.

``` yaml $(tag) == 'v1.0'
input-file: stable/v1.0/Face.json
suppressions:
  - code: HostParametersValidation
    from: Face.json
    reason: Legacy swagger file
  - code: OperationIdNounVerb
    from: Face.json
    reason: Legacy swagger file
  - code: IntegerTypeMustHaveFormat
    from: Face.json
    reason: Legacy swagger file
  - code: LroExtension 
    from: Face.json
    reason: Legacy swagger file
```
