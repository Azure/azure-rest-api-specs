## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: redisenterprise
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/redisenterprise/armredisenterprise/v3
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
modelerfour:
  lenient-model-deduplication: true # !!temporary!! to solve the duplicate schema issue of ErrorResponse in common-types v2 and v3 introduced in this PR https://github.com/Azure/azure-rest-api-specs/pull/20502
```
