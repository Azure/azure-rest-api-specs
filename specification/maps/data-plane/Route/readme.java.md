## Java

``` yaml $(java)

directive:
  - rename-model:
      from: RouteMatrix
      to: RouteMatrixPrivate
  - rename-model:
      from: RouteMatrixResult
      to: RouteMatrixResultPrivate   
  - rename-model:
      from: RouteMatrixQuery
      to: RouteMatrixQueryPrivate           
java:
    namespace: com.azure.maps.route
    license-header: MICROSOFT_MIT_NO_CODEGEN
    payload-flattening-threshold: 0
    output-folder: $(azure-libraries-for-java-folder)/azure-maps-route 
    add-context-parameter: true
    context-client-method-parameter: true
    client-logger: true
    generate-client-as-impl: true
    sync-methods: all
    generate-sync-async-clients: false
    polling: {}
    models-subpackage: implementation.models
    custom-types-subpackage: models
    custom-types: AlternativeRouteType,BatchResultSummary,ComputeTravelTime,DelayMagnitude,DrivingSide,EffectiveSetting,ErrorAdditionalInfo,ErrorDetail,ErrorResponse,ErrorResponseException,GuidanceInstructionType,GuidanceManeuver,InclineLevel,JunctionType,Report,ResponseSectionType,ResponseTravelMode,Route,RouteAvoidType,RouteDirections,RouteDirectionsBatchResult,RouteGuidance,RouteInstructionGroup,RouteInstructionsType,RouteLegSummary,RouteMatrixSummary,RouteOptimizedWaypoint,RouteRangeResult,RouteReport,RouteRepresentationForBestOrder,RouteSection,RouteSectionTec,RouteSectionTecCause,RouteSummary,RouteType,SectionType,SimpleCategory,TravelMode,VehicleEngineType,VehicleLoadType,WindingnessLevel
```