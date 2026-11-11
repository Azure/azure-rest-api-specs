## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
credential-scopes: https://dev.azuresynapse.net/.default
add-credentials: true
typescript:
  azure-arm: true
  generate-metadata: true
batch:
    - package-access-control: true
      package-name: "@azure/synapse-access-control"
      output-folder: $(typescript-sdks-folder)/sdk/synapse/synapse-access-control
      clear-output-folder: true
      tracing-info:
        namespace: "Azure.Synapse.AccessControl"
        packagePrefix: "Microsoft.Synapse"
    - package-artifacts: true
      package-name: "@azure/synapse-artifacts"
      output-folder: $(typescript-sdks-folder)/sdk/synapse/synapse-artifacts
      clear-output-folder: true
      tracing-info:
        namespace: "Azure.Synapse.Artifacts"
        packagePrefix: "Microsoft.Synapse"
    - package-spark: true
      package-name: "@azure/synapse-spark"
      output-folder: $(typescript-sdks-folder)/sdk/synapse/synapse-spark
      clear-output-folder: true
      tracing-info:
        namespace: "Azure.Synapse.Spark"
        packagePrefix: "Microsoft.Synapse"
    - package-vnet: true
      package-name: "@azure/synapse-managed-private-endpoints"
      output-folder: $(typescript-sdks-folder)/sdk/synapse/synapse-managed-private-endpoints
      clear-output-folder: true
      tracing-info:
        namespace: "Azure.Synapse.ManagedPrivateEndpoints"
        packagePrefix: "Microsoft.Synapse"
    - package-monitoring: true
      package-name: "@azure/synapse-monitoring"
      output-folder: $(typescript-sdks-folder)/sdk/synapse/synapse-monitoring
      clear-output-folder: true
      tracing-info:
        namespace: "Azure.Synapse.Monitoring"
        packagePrefix: "Microsoft.Synapse"
```
