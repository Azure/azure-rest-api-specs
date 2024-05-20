## Java

``` yaml $(java)
directive:
  - rename-model:
      from: MapTileset
      to: MapTilesetPrivate
  - from: swagger-document
    where: '$.parameters["BoundingBoxSouthWest"]'
    transform: >
      $["x-ms-parameter-grouping"]["name"] = "BoundingBoxPrivate";
  - from: swagger-document
    where: '$.parameters["BoundingBoxNorthEast"]'
    transform: >
      $["x-ms-parameter-grouping"]["name"] = "BoundingBoxPrivate";
  - from: swagger-document
    where: '$.parameters["bbox"]'
    transform: >
      $["x-ms-client-name"] = "BoundingBoxPrivate";
    
java:
    namespace: com.azure.maps.render
    license-header: MICROSOFT_MIT_SMALL
    payload-flattening-threshold: 0
    output-folder: $(azure-libraries-for-java-folder)/azure-maps-render
    add-context-parameter: true
    context-client-method-parameter: true
    client-logger: true
    generate-client-as-impl: true
    sync-methods: all
    generate-sync-async-clients: false
    polling: {}
    models-subpackage: implementation.models
    custom-types-subpackage: models
    custom-types: LocalizedMapView,MapImageStyle,RasterTileFormat,StaticMapLayer,MapTileSize,TileIndex,TilesetID,Copyright,CopyrightCaption,MapAttribution,RegionCopyrights,RegionCopyrightsCountry,ErrorAdditionalInfo,ErrorDetail,ErrorResponse,ErrorResponseException
```