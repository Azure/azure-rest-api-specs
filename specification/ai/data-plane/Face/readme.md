# Azure AI Face SDK

> see https://aka.ms/autorest

Configuration for generating Face SDK.

The current release is `v1.2-preview.1`.

``` yaml

tag: v1.2-preview.1
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

### Release v1.1-preview.1
These settings apply only when `--tag=v1.1-preview.1` is specified on the command line.
``` yaml $(tag) == 'v1.1-preview.1'
input-file:
  - preview/v1.1-preview.1/Face.json
suppressions:
  - code: LroExtension
    from: Face.json
    reason: Our LRO behavior does not fit the default generated poller
  - code: AvoidAnonymousParameter
    from: Face.json
    reason: Use anonymous parameter to provide interface with flatten parameters
```

### Release v1.2-preview.1
These settings apply only when `--tag=v1.2-preview.1` is specified on the command line.
``` yaml $(tag) == 'v1.2-preview.1'
input-file:
  - preview/v1.2-preview.1/Face.json
suppressions:
  - code: LroExtension
    from: Face.json
    reason: Our LRO behavior does not fit the default generated poller
  - code: AvoidAnonymousParameter
    from: Face.json
    reason: Use anonymous parameter to provide interface with flatten parameters
```