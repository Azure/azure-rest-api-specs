## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
azure-arm: false
package-name: "@azure/maps-route"
license-header: MICROSOFT_MIT_NO_VERSION
output-folder: "$(typescript-sdks-folder)/sdk/maps/maps-route"
source-code-folder-path: ""
clear-output-folder: false
generate-metadata: false
directive:
  - from: route.json
    where: $.definitions.RouteDirectionParameters.properties.supportingPoints
    transform: >
      $ = {
        "description": "A GeoJSON Geometry collection representing sequence of coordinates used as input for route reconstruction and for calculating zero or more alternative routes to this reference route.\n  - The provided sequence of supporting points is used as input for route reconstruction.\n  - The alternative routes are calculated between the origin and destination points specified in the base path parameter locations.\n  - If both _minDeviationDistance_ and _minDeviationTime_ are set to zero, then these origin and destination points are\n  expected to be at (or very near) the beginning and end of the reference route, respectively.\n  - Intermediate locations (_waypoints_) are not supported when using <_supportingPoints_>.\n  - The reference route may contain traffic incidents of type _ROAD_CLOSURE_, which are\n  ignored for the calculation of the reference route's travel time and traffic delay.",
        "type": "object"
      };
    reason: Autorest TS codegen does not deserialize array of base class objects as an operation parameter properly -> https://github.com/Azure/autorest.typescript/issues/1040
```
