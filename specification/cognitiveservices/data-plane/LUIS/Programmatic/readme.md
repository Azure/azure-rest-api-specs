# Cognitive Services LUIS SDKs

> see https://aka.ms/autorest

Configuration for generating LUIS Programmatic SDK.

``` yaml
tag: programmatic_2_0
add-credentials: true
openapi-type: data-plane
```

The current release for the Programmatic Endpoint is `programmatic_2_0`.

# Releases

## Programmatic 2.0
These settings apply only when `--tag=programmatic_2_0` is specified on the command line.

``` yaml $(tag) == 'programmatic_2_0'
input-file: v2.0/LUIS-Programmatic.json
# Remove Deprecated Pattern's Operations
directive:
  - reason: Deprecated
    remove-operation: Features_GetApplicationVersionPatternFeatures
  - reason: Deprecated
    remove-operation: Features_CreatePatternFeature
  - reason: Deprecated
    remove-operation: Features_GetPatternFeatureInfo
  - reason: Deprecated
    remove-operation: Features_UpdatePatternFeature
  - reason: Deprecated
    remove-operation: Features_DeletePatternFeature
```

### Programmatic 2.0 - CSharp Settings
These settings apply only when `--csharp` is specified on the command line.
``` yaml $(csharp)
csharp:
  override-client-name: LuisProgrammaticAPI
  sync-methods: None
  license-header: MICROSOFT_MIT_NO_VERSION
  azure-arm: false
  namespace: Microsoft.Azure.CognitiveServices.Language.LUIS.Programmatic
  output-folder: $(csharp-sdks-folder)/CognitiveServices/dataPlane/Language/LUIS-Programmatic/Generated
  clear-output-folder: true
```