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
tag: package-stable-2023-07-01
```

### Suppression

``` yaml
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: timezone.json
    reason: It will break existing clients if we change the name

  - suppress: LroExtension
    from: search.json
    where: $.paths["/providers/Microsoft.Subscription/subscriptionOperations/{operationId}"].get
    reason: The reason for this suppression is the API is already released and introducing new LRO properties will not function and are not supported today and will only be developed for the next version of this API.

  - suppress: INVALID_TYPE
    reason: false positive from oav is breaking our example validation. See azure/oav#1020.

  - suppress: RESPONSE_SCHEMA_NOT_IN_SPEC
    reason: false positive from oav is breaking our example validation. See azure/oav#1021.

```

### Tag: package-stable-2023-07-01

These settings apply only when `--tag=package-stable-2023-07-01` is specified on the command line.

```yaml $(tag) == 'package-stable-2023-07-01'
input-file:
  - Common/stable/2023-06-01/common.json
  - Creator/stable/2023-07-01/alias.json
  - Creator/stable/2023-07-01/dataset.json
  - Creator/stable/2023-07-01/dwgconversion.json
  - Creator/stable/2023-07-01/features.json
  - Creator/stable/2023-07-01/featurestate.json
  - Creator/stable/2023-07-01/mapconfiguration.json
  - Creator/stable/2023-07-01/style.json
  - Creator/stable/2023-07-01/tileset.json
  - Microsoft.Maps/Data/preview/2.0/data.json
  - DataRegistry/stable/2023-06-01/dataregistry.json
  - Geolocation/preview/1.0/geolocation.json
  - Render/stable/2022-08-01/render.json
  - Route/preview/1.0/route.json
  - Search/stable/2023-06-01/search.json
  - Spatial/stable/2022-08-01/spatial.json
  - Timezone/preview/1.0/timezone.json
  - Traffic/preview/1.0/traffic.json
  - Weather/stable/1.1/weather.json
```

### Tag: package-preview-2.0

These settings apply only when `--tag=package-preview-2.0` is specified on the command line.

```yaml $(tag) == 'package-preview-2.0'
input-file:
  - Microsoft.Maps/Alias/preview/2.0/alias.json
  - Microsoft.Maps/Data/preview/2.0/data.json
  - Microsoft.Maps/Dataset/preview/2.0/dataset.json
  - Microsoft.Maps/DEM/preview/1.0/elevation.json
  - Microsoft.Maps/DwgConversion/preview/2.0/dwgconversion.json
  - Microsoft.Maps/FeatureState/preview/2.0/featurestate.json
  - Microsoft.Maps/Feedback/preview/1.0/feedback.json
  - Microsoft.Maps/Geolocation/preview/1.0/geolocation.json
  - Microsoft.Maps/Render/preview/1.0/render.json
  - Microsoft.Maps/Render/preview/2.0/render.json
  - Microsoft.Maps/Route/preview/1.0/route.json
  - Microsoft.Maps/Search/preview/1.0/search.json
  - Microsoft.Maps/Spatial/preview/1.0/spatial.json
  - Microsoft.Maps/Tileset/preview/2.0/tileset.json
  - Microsoft.Maps/Timezone/preview/1.0/timezone.json
  - Microsoft.Maps/Traffic/preview/1.0/traffic.json
  - Microsoft.Maps/Weather/preview/1.0/weather.json
  - Microsoft.Maps/WFS/preview/2.0/wfs.json
```

### Tag: package-1.0-preview

These settings apply only when `--tag=package-1.0-preview` is specified on the command line.

``` yaml $(tag) == 'package-1.0-preview'
input-file:
  - Microsoft.Maps/Data/preview/1.0/data.json
  - Microsoft.Maps/DEM/preview/1.0/elevation.json
  - Microsoft.Maps/Feedback/preview/1.0/feedback.json
  - Microsoft.Maps/Geolocation/preview/1.0/geolocation.json
  - Microsoft.Maps/Render/preview/1.0/render.json
  - Microsoft.Maps/Render/preview/2.0/render.json
  - Microsoft.Maps/Route/preview/1.0/route.json
  - Microsoft.Maps/Search/preview/1.0/search.json
  - Microsoft.Maps/Spatial/preview/1.0/spatial.json
  - Microsoft.Maps/Timezone/preview/1.0/timezone.json
  - Microsoft.Maps/Traffic/preview/1.0/traffic.json
  - Microsoft.Maps/Weather/preview/1.0/weather.json
```
