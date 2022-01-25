## Java

``` yaml $(java)

directive:
  - rename-model:
      from: Address
      to: AddressPrivate
  - rename-model:
      from: AddressRanges
      to: AddressRangesPrivate
  - rename-model:
      from: SearchAddressResult
      to: SearchAddressResultPrivate    
  - rename-model:
      from: SearchAddressResultItem
      to: SearchAddressResultItemPrivate            
  - rename-model:
      from: ReverseSearchAddressResult
      to: ReverseSearchAddressResultPrivate     
  - rename-model:
      from: ReverseSearchAddressResultItem
      to: ReverseSearchAddressResultItemPrivate  
  - rename-model:
      from: ReverseSearchCrossStreetAddressResult
      to: ReverseSearchCrossStreetAddressResultPrivate
  - rename-model:
      from: ReverseSearchCrossStreetAddressResultItem
      to: ReverseSearchCrossStreetAddressResultItemPrivate   
  - rename-model:
      from: EntryPoint
      to: EntryPointPrivate
  - rename-model:
      from: SearchSummary
      to: SearchSummaryPrivate
  - rename-model:
      from: SearchAddressBatchResult
      to: SearchAddressBatchResultPrivate
  - rename-model:
      from: SearchAddressBatchItem
      to: SearchAddressBatchItemPrivate
  - rename-model:
      from: ReverseSearchAddressBatchProcessResult
      to: ReverseSearchAddressBatchResultPrivate
  - rename-model:
      from: ReverseSearchAddressBatchItem
      to: ReverseSearchAddressBatchItemPrivate
  - rename-model:
      from: BoundingBox
      to: BoundingBoxPrivate
  - rename-model:
      from: Polygon
      to: PolygonPrivate

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
    custom-types: BatchRequest,BatchResultSummary,DataSource,ErrorDetail,ErrorResponseException,ElectricVehicleConnector,EntryPointType,GeographicEntityType,JsonFormat,LocalizedMapView,OperatingHoursRange,MatchType,PointOfInterestCategoryTreeResult,PointOfInterestExtendedPostalCodes,RoadUseType,SearchIndexes,ErrorResponse
```