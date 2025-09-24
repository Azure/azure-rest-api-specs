## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
service-name: CosmosDB
modelerfour:
  lenient-model-deduplication: true
enable-sync-stack: false
rename-model: DataTransferServiceResourceCreateUpdateProperties:DataTransferServiceResourceCreateUpdateParameters,GraphApiComputeServiceResourceCreateUpdateProperties:GraphApiComputeServiceResourceCreateUpdateParameters,MaterializedViewsBuilderServiceResourceCreateUpdateProperties:MaterializedViewsBuilderServiceResourceCreateUpdateParameters,SqlDedicatedGatewayServiceResourceCreateUpdateProperties:SqlDedicatedGatewayServiceResourceCreateUpdateParameters
directive:
  - from: managedCassandra.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DocumentDB/cassandraClusters/{clusterName}/invokeCommandAsync"].post
    transform: $['operationId'] = 'CassandraClusters_invokeCommandAsyncResource'
  - from: managedCassandra.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DocumentDB/cassandraClusters/{clusterName}/commands/{commandId}"].get
    transform: $['operationId'] = 'CassandraClusters_GetCommandAsyncResource'
```
