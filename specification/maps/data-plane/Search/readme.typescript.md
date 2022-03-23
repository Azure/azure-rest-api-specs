## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
azure-arm: false
package-name: "@azure/maps-search"
license-header: MICROSOFT_MIT_NO_VERSION
output-folder: "$(typescript-sdks-folder)/sdk/maps/maps-search"
source-code-folder-path: ""
clear-output-folder: false
generate-metadata: false
directive:
  - from: search.json
    where: $.definitions.SearchInsideGeometryRequestBody.properties.geometry
    transform: >
      $ = {
        "description": "A valid `GeoJSON` object. Please refer to [RFC 7946](https://tools.ietf.org/html/rfc7946#section-3) for details.",
        "type": "object"
      };
    reason: Autorest TS codegen does not deserialize array of base class objects as an operation parameter properly -> https://github.com/Azure/autorest.typescript/issues/1040
```
