## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

```yaml $(typescript)
typescript:
  azure-arm: false
  generate-package-json: false
  generate-readme-md: false
  generate-metadata: true
  generate-license-txt: true
  output-folder: "$(typescript-sdks-folder)/sdk/quantum/quantum-jobs"
  package-name: "@azure/quantum-jobs"
  license-header: MICROSOFT_MIT_NO_VERSION
  add-credentials: true
  credential-scopes: ["https://quantum.microsoft.com/.default"]
  title: QuantumJobClient
  v3: true
```
