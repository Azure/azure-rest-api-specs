## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
azure-arm: false
package-name: "@azure/maps-timezone"
license-header: MICROSOFT_MIT_NO_VERSION
output-folder: "$(typescript-sdks-folder)/sdk/maps/maps-timezone/src/generated"
source-code-folder-path: "."
clear-output-folder: true
generate-metadata: false
v3: true
use-extension:
  "@autorest/typescript": "6.0.0-alpha.20210514.1"
```
