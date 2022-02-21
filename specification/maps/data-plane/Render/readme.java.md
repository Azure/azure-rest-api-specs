## Java

``` yaml $(java)

directive:
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
  - from: swagger-document
    where: '$.definitions["MapTileset"]'
    transform: >
      $["x-ms-client-name"] = "MapTilesetPrivate";
#   - from: swagger-document
#     where: '$.paths["/map/tile"].get'
#     transform: >
#       $["operationId"] = "GetMapTile";
#   - from: swagger-document
#     where: '$.paths["/map/statetile"].get'
#     transform: >
#       $["operationId"] = "GetMapStateTile";
#   - from: swagger-document
#     where: '$.paths["/map/static/{format}"].get'
#     transform: >
#       $["operationId"] = "GetMapStaticImage";
    
java:
    namespace: com.azure.maps.render
    license-header: MICROSOFT_MIT_NO_CODEGEN
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
    custom-types: LocalizedMapView,MapImageStyle,RasterTileFormat,StaticMapLayer,MapTileSize,TileIndex,TilesetID
```