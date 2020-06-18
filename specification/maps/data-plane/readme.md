# Azure Maps

> see https://aka.ms/autorest

This is the AutoRest configuration file for MapsClient


---
## Getting Started
To build the SDK for Maps, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information
These are the global settings for MapsClient.

``` yaml
title: MapsClient
openapi-type: data-plane
tag: package-1.0
```

### Suppression

``` yaml
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: timezone.json
    reason: It will break existing clients if we change the name

```


### Tag: package-1.0

These settings apply only when `--tag=package-1.0` is specified on the command line.

``` yaml $(tag) == 'package-1.0'
input-file:
  - ./Alias/preview/v1/alias.json
  - ./Data/preview/v1/data.json
  - ./Dataset/preview/v1/dataset.json
  - ./DwgConversion/preview/v1/dwgconversion.json
  - ./FeatureState/preview/v1/featurestate.json
  - ./Feedback/preview/v1/feedback.json
  - ./Geolocation/preview/v1/geolocation.json
  - ./Mobility/preview/v1/mobility.json
  - ./Render/preview/v1/render.json
  - ./Route/preview/v1/route.json
  - ./Search/preview/v1/search.json
  - ./Spatial/preview/v1/spatial.json
  - ./Tileset/preview/v1/tileset.json
  - ./Timezone/preview/v1/timezone.json
  - ./Traffic/preview/v1/traffic.json
  - ./Weather/preview/v1/weather.json
  - ./WFS/preview/v1/wfs.json
```

### Tag: ts

These settings apply only when `--tag=ts` is specified on the command line

``` yaml $(tag) == 'ts'
input-file:
  - ./search/preview/v1/search.json
  - ./route/preview/v1/route.json
  - ./timezone/preview/v1/timezone.json
  - ./render/preview/v1/render.json
  - ./mobility/preview/v1/mobility.json
  - ./spatial/preview/v1/spatial.json

typescript:
  enum-types: true
  azure-arm: true

directive:
    - from: swagger-document
      where: $..*[?(@.name === "format" && @.enum.includes('json'))]
      transform: $.enum = ['json'];
      reason: >
        Autorest historically only supported json responses. For the SDK, the over-the-wire format
        of the data isn't important.
    - from: swagger-document
      where: $.paths..responses
      transform: >
        for (var responseCode of Object.keys($)) {
          var responseCodeInt = parseInt(responseCode);
          if (responseCodeInt >= 300 || responseCodeInt < 200) { delete $[responseCode] };     
        }
        return $;
      reason: Autorest treats all responses defined for an operation as successful.
    - from: swagger-document
      where: $..*[?(@.default !== undefined && !@.required)]
      transform: $.default = undefined;
      reason: Our APIs have mutually exclusive parameters. Removing all non-required defaults to prevent 4XX failures.
    - from: swagger-document
      where: $.securityDefinitions
      transform: $ = undefined;
      reason: The typescript sdk has built-in security handling. Security definitions can be removed.
    - from: swagger-document
      where: $.security
      transform: $ = undefined;
      reason: The typescript sdk has built-in security handling. Security can be removed.
    - from: swagger-document
      where: $.paths..parameters
      transform: >
        for (var i = 0; i < $.length; i++) {
          if ($[i].$ref && $doc.parameters) {
            var path = $[i].$ref.split("/");
            var param = path[path.length - 1];
            if (["subscription-key", "x-ms-client-id"].indexOf($doc.parameters[param].name.toLowerCase()) !== -1) {
              $.splice(i--, 1);
            }
          }
        }
      reason: The typescript sdk has built-in security handling. Subscription key and client id can be removed from parameters.
    - from: swagger-document
      where: $.parameters[?(["subscription-key", "x-ms-client-id"].indexOf(@.name.toLowerCase()) !== -1)]
      transform: $ = undefined;
      reason: The typescript sdk has built-in security handling. Subscription key and client id can be removed from parameters.

```

## CSharp Settings

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  license-header: MICROSOFT_MIT_NO_VERSION
  azure-arm: false
  namespace: Microsoft.Azure.Maps
  output-folder: $(csharp-sdks-folder)/Maps/Generated
  clear-output-folder: true
```

## Validation Steps

``` yaml $(validation)
azure-validator: true
semantic-validator: true
model-validator: true
```
