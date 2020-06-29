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
tag: package-1.0-preview
```

### Suppression

``` yaml
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: timezone.json
    reason: It will break existing clients if we change the name

```


### Tag: package-2.0-preview

These settings apply only when `--tag=package-2.0-preview` is specified on the command line.

``` yaml $(tag) == 'package-2.0-preview'
input-file:
  - ./Render/preview/2.0/render.json
```

### Tag: package-1.0-preview

These settings apply only when `--tag=package-1.0-preview` is specified on the command line.

``` yaml $(tag) == 'package-1.0-preview'
input-file:
  - ./Alias/preview/1.0/alias.json
  - ./Data/preview/1.0/data.json
  - ./Dataset/preview/1.0/dataset.json
  - ./DwgConversion/preview/1.0/dwgconversion.json
  - ./FeatureState/preview/1.0/featurestate.json
  - ./Feedback/preview/1.0/feedback.json
  - ./Geolocation/preview/1.0/geolocation.json
  - ./Mobility/preview/1.0/mobility.json
  - ./Render/preview/1.0/render.json
  - ./Route/preview/1.0/route.json
  - ./Search/preview/1.0/search.json
  - ./Spatial/preview/1.0/spatial.json
  - ./Tileset/preview/1.0/tileset.json
  - ./Timezone/preview/1.0/timezone.json
  - ./Traffic/preview/1.0/traffic.json
  - ./Weather/preview/1.0/weather.json
  - ./WFS/preview/1.0/wfs.json
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
