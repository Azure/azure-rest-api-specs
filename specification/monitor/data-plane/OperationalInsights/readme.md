# My API
> see https://aka.ms/autorest

### Basic Information
These are the global settings.

``` yaml
openapi-type: data-plane
tag: package-v1
```

### Tag: package-v1

These settings apply only when `--tag=package-v1` is specified on the command line.

``` yaml $(tag) == 'package-v1'
input-file:
- stable/v1/OperationalInsights.json
suppressions:
  - code: AvoidAnonymousTypes
    reason: Typespec generated definitions can contain anonymous types.
```
