## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

```yaml $(typescript)
typescript:
  package-name: "@azure-rest/iot-device-update"
  description: Iot Device Update Client
  package-version: 1.0.0-beta.1
  output-folder: "$(typescript-sdks-folder)/sdk/deviceupdate/iot-device-update-rest"
  rest-level-client: true
  add-credentials: true
  license-header: MICROSOFT_MIT_NO_VERSION
  generate-metadata: true
  credential-scopes: https://api.adu.microsoft.com/.default
```