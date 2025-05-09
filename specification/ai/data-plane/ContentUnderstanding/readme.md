# Azure AI Content Understanding SDK

> see https://aka.ms/autorest

Configuration for generating Content Understanding SDK.

The current release is `2024-12-01-preview`.

``` yaml

tag: 2024-12-01-preview
add-credentials: true
openapi-type: data-plane
```

# Releases

### Release 2024-12-01-preview
These settings apply only when `--tag=2024-12-01-preview` is specified on the command line.
``` yaml $(tag) == '2024-12-01-preview'
input-file:
  - preview/2024-12-01-preview/ContentUnderstanding.json
```


# Suppressions
``` yaml
suppressions:
  - code: EnumMustHaveType
    from: ContentUnderstanding.json
    where: $.definitions.FieldDefinition.properties
    reason: False alert.  'enum' is a custom property name here, not the Swagger property
  - code: AvoidAnonymousTypes
    from: ContentUnderstanding.json
    reason: TypeSpec creates anonymous operation status monitors inline
  - code: EnumInsteadOfBoolean
    from: ContentUnderstanding.json
  - code: PathParameterSchema
    from: ContentUnderstanding.json
    reason: Specify length constraints in regex pattern
```