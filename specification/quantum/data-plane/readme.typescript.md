## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

```yaml $(typescript)
typescript:
  output-folder: "$(typescript-sdks-folder)/sdk/quantum/quantum-jobs"
  generate-license-txt: true
  generate-package-json: false
  generate-readme-md: false
  generate-metadata: true
  package-name: "@azure/quantum-jobs"
  package-version: "1.0.0-beta.2"
  license-header: MICROSOFT_MIT_NO_VERSION
  output-folder: ../
  source-code-folder-path: ./src/
  add-credentials: true
  credential-scopes: ["https://quantum.microsoft.com/.default"]
  title: QuantumJobClient
  v3: true
```
