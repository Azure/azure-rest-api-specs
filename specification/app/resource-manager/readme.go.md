## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/appcontainers/armappcontainers
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
modelerfour:
  lenient-model-deduplication: true # !!temporary!! to solve the duplicate schema issue of ErrorResponse in common-types v2 and v3 introduced in this PR https://github.com/Azure/azure-rest-api-specs/pull/27786
```
