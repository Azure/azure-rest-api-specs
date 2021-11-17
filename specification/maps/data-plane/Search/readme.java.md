## Java

``` yaml $(java)
java:
    namespace: com.azure.maps.search
    license-header: MICROSOFT_MIT_NO_CODEGEN
    payload-flattening-threshold: 0
    output-folder: $(azure-libraries-for-java-folder)/azure-maps-search 
    add-context-parameter: true
    context-client-method-parameter: true
    client-logger: true
    generate-client-as-impl: true
    sync-methods: all
    generate-sync-async-clients: false
    polling: {}
    models-subpackage: implementation.models
    custom-types-subpackage: models
    custom-types: BatchRequest,ErrorResponseException,ElectricVehicleConnector,GeographicEntityType,JsonFormat,LocalizedMapView,OperatingHoursRange,PointOfInterestCategoryTreeResult,PointOfInterestExtendedPostalCodes,PolygonResult,ResponseFormat,ReverseSearchAddressBatchProcessResult,ReverseSearchAddressResult,ReverseSearchCrossStreetAddressResult,RoadUseType,SearchAddressBatchProcessResult,SearchAddressResult,SearchAlongRouteRequest,SearchIndexes,SearchInsideGeometryRequest,SearchesFuzzySearchBatchResponse,SearchesGetFuzzySearchBatchResponse,SearchesGetReverseSearchAddressBatchResponse,SearchesGetSearchAddressBatchResponse,SearchesReverseSearchAddressBatchResponse,SearchesSearchAddressBatchResponse,ErrorResponse
```