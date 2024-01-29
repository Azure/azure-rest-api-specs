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
tag: package-stable-2023-06-01
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

  - suppress: RESPONSE_SCHEMA_NOT_IN_SPEC
    reason: false positive from oav is breaking our example validation. See azure/oav#1021.

```

### Tag: package-stable-2023-06-01

These settings apply only when `--tag=package-stable-2023-06-01` is specified on the command line.

```yaml $(tag) == 'package-stable-2023-06-01'
input-file:
  - Common/stable/2023-06-01/common.json
  - DataRegistry/stable/2023-06-01/dataregistry.json
  - Geolocation/preview/1.0/geolocation.json
  - Creator/preview/2.0/data.json
  - Render/stable/2022-08-01/render.json
  - Route/preview/1.0/route.json
  - Search/stable/2023-06-01/search.json
  - Spatial/stable/2022-08-01/spatial.json
  - Timezone/preview/1.0/timezone.json
  - Traffic/preview/1.0/traffic.json
  - Weather/stable/1.1/weather.json
```

### Tag: package-stable-1.0

These settings apply only when `--tag=package-stable-1.0` is specified on the command line.

```yaml $(tag) == 'package-stable-1.0'
input-file:
  - Microsoft.Maps/Data/preview/1.0/data.json
  - Microsoft.Maps/Render/preview/1.0/render.json
  - Search/preview/1.0/search.json
```

### Tag: package-2023-10-01-preview

These settings apply only when `--tag=package-2023-10-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-10-01-preview'
input-file:
  - Route/preview/2023-10-01-preview/route.json
```

### Tag: package-deprecated

These settings apply only when `--tag=package-deprecated` is specified on the command line.

``` yaml $(tag) == 'package-deprecated'
input-file:
  - Microsoft.Maps/Alias/preview/2.0/alias.json
  - Microsoft.Maps/Data/preview/2.0/data.json
  - Microsoft.Maps/DEM/preview/1.0/elevation.json
  - Microsoft.Maps/Feedback/preview/1.0/feedback.json
  - Microsoft.Maps/Geolocation/preview/1.0/geolocation.json
  - Microsoft.Maps/Render/preview/2.0/render.json
  - Microsoft.Maps/Route/preview/1.0/route.json
  - Microsoft.Maps/Search/preview/1.0/search.json
  - Microsoft.Maps/Spatial/preview/1.0/spatial.json
  - Microsoft.Maps/Timezone/preview/1.0/timezone.json
  - Microsoft.Maps/Traffic/preview/1.0/traffic.json
  - Microsoft.Maps/Weather/preview/1.0/weather.json
```

### Tag: package-creator

These settings apply only when `--tag=package-creator` is specified on the command line.

``` yaml $(tag) == 'package-creator'
input-file:
  - Microsoft.Maps/Dataset/preview/2.0/dataset.json
  - Microsoft.Maps/DwgConversion/preview/2.0/dwgconversion.json
  - Microsoft.Maps/FeatureState/preview/2.0/featurestate.json
  - Microsoft.Maps/Tileset/preview/2.0/tileset.json
  - Microsoft.Maps/WFS/preview/2.0/wfs.json
```
