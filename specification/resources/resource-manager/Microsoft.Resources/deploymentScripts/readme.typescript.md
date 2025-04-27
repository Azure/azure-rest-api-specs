## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

```yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-deployments-deploymentscripts"
  output-folder: "$(typescript-sdks-folder)/sdk/deployments/arm-deployments-deploymentscripts"
  override-client-name: DeploymentScriptsClient
  generate-metadata: true
```
