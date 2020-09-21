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

### Tag: package-1.0-preview

These settings apply only when `--tag=package-1.0-preview` is specified on the command line.

``` yaml $(tag) == 'package-1.0-preview'
input-file:
  - Microsoft.Maps/Alias/preview/1.0/alias.json
  - Microsoft.Maps/Data/preview/1.0/data.json
  - Microsoft.Maps/Dataset/preview/1.0/dataset.json
  - Microsoft.Maps/DwgConversion/preview/1.0/dwgconversion.json
  - Microsoft.Maps/FeatureState/preview/1.0/featurestate.json
  - Microsoft.Maps/Feedback/preview/1.0/feedback.json
  - Microsoft.Maps/Geolocation/preview/1.0/geolocation.json
  - Microsoft.Maps/Mobility/preview/1.0/mobility.json
  - Microsoft.Maps/Render/preview/1.0/render.json
  - Microsoft.Maps/Route/preview/1.0/route.json
  - Microsoft.Maps/Search/preview/1.0/search.json
  - Microsoft.Maps/Spatial/preview/1.0/spatial.json
  - Microsoft.Maps/Tileset/preview/1.0/tileset.json
  - Microsoft.Maps/Timezone/preview/1.0/timezone.json
  - Microsoft.Maps/Traffic/preview/1.0/traffic.json
  - Microsoft.Maps/Weather/preview/1.0/weather.json
  - Microsoft.Maps/WFS/preview/1.0/wfs.json
```
