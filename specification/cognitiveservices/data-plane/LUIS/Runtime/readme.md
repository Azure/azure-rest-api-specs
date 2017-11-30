# Cognitive Services LUIS SDKs

> see https://aka.ms/autorest

Configuration for generating LUIS Runtime SDK.

``` yaml
tag: runtime_2_0
add-credentials: true
openapi-type: data-plane
```

The current release for the Runtime Endpoint is `runtime_2_0`.

# Releases

## Runtime 2.0
These settings apply only when `--tag=runtime_2_0` is specified on the command line.

``` yaml $(tag) == 'runtime_2_0'
input-file: v2.0/LUIS-Runtime.json

# remove Resolve2 from code-generation (since the POST and GET operations are functionally identical)
directive:
  remove-operation: Prediction_Resolve2
```

### Runtime 2.0 - CSharp Settings
These settings apply only when `--csharp` is specified on the command line.
``` yaml $(csharp)
csharp:
  override-client-name: LuisRuntimeAPI
  sync-methods: None
  license-header: MICROSOFT_MIT_NO_VERSION
  azure-arm: false
  namespace: Microsoft.Azure.CognitiveServices.Language.LUIS
  output-folder: $(csharp-sdks-folder)/CognitiveServices/dataPlane/Language/LUIS-Runtime/Generated
  clear-output-folder: true

# csharp has support for modelAsExtensible now; replace modelAsString with that. 
directive:
  from: swagger-document
  where: $..['x-ms-enum']
  transform: >
    if( $['modelAsString'] ) {
      $['modelAsExtensible'] = true;
      $['modelAsString'] = false;
    }
```