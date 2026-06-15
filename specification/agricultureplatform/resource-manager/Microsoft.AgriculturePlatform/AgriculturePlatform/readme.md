# AgriculturePlatform

> see https://aka.ms/autorest

This is the AutoRest configuration file for AgriculturePlatform.

## Configuration

### Basic Information

This is a TypeSpec project so we only want to readme to default the default tag and point to the outputted swagger file.
This is used for some tools such as doc generation and swagger apiview generation it isn't used for SDK code gen as we
use the native TypeSpec code generation configured in the tspconfig.yaml file.

```yaml
openapi-type: arm
openapi-subtype: providerHub
tag: package-2024-06-01-preview
```

### Tag: package-2024-06-01-preview

These settings apply only when `--tag=package-2024-06-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-06-01-preview'
input-file:
  - preview/2024-06-01-preview/agricultureplatform.json
suppressions:
  - code: PatchBodyParametersSchema
    reason: Suppress PATCH rule as the required properties are defined during typespec generation. Also, empty object can still be passed, properties are not mandatory for the update schema.
  - code: AvoidAnonymousTypes
    where:
        - $.definitions["Azure.ResourceManager.CommonTypes.ManagedServiceIdentityUpdate"].properties["userAssignedIdentities"].additionalProperties
    reason: Typespec generated definitions contain anonymous types.
```

---
