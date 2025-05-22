## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: videoanalyzer
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/videoanalyzer/armvideoanalyzer
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
directive:
- rename-model:
    from: 'Properties'
    to: 'MetricProperties'
- from: swagger-document
  where: '$.paths.*[?(@.operationId.startsWith("OperationStatuses_"))]'
  transform: >
    $["operationId"] = $["operationId"].replace("OperationStatuses_", "PrivateEndpointConnectionsOperationStatuses_")
- from: swagger-document
  where: '$.paths.*[?(@.operationId.startsWith("OperationResults_"))]'
  transform: >
    $["operationId"] = $["operationId"].replace("OperationResults_", "PrivateEndpointConnectionsOperationResults_")
```
