import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";


using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;


namespace Microsoft.Sql;
/**
* An elastic pool.
*/
@parentResource(Server)
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
model ElasticPool extends TrackedResource {
/**
* The name of the elastic pool.
*/
@path
@key("elasticPoolName")
@segment("elasticPools")
@visibility("read")
"name": string;
/**
* The elastic pool SKU.
* 
* The list of SKUs may vary by region and support offer. To determine the SKUs (including the SKU name, tier/edition, family, and capacity) that are available to your subscription in an Azure region, use the `Capabilities_ListByLocation` REST API or the following command:
* 
* ```azurecli
* az sql elastic-pool list-editions -l <location> -o table
* ````
* 
*/
"sku"?: Sku;
/**
* Kind of elastic pool. This is metadata used for the Azure portal experience.
*/
@visibility("read")
"kind"?: string;
/**
* Resource properties.
*/
@extension("x-ms-client-flatten", true)
properties?: ElasticPoolProperties
}



@armResourceOperations
interface ElasticPools {
/**
* Gets an elastic pool.
*/
get is ArmResourceRead<ElasticPool>

/**
* Creates or updates an elastic pool.
*/
createOrUpdate is ArmResourceCreateOrReplaceAsync<ElasticPool,BaseParameters<ElasticPool>,ArmAsyncOperationHeader>

/**
* Updates an elastic pool.
*/
@parameterVisibility("read")
update is ArmCustomPatchAsync<ElasticPool,ElasticPoolUpdate,BaseParameters<ElasticPool>,ArmLroLocationHeader>

/**
* Deletes an elastic pool.
*/
delete is ArmResourceDeleteAsync<ElasticPool,BaseParameters<ElasticPool>,ArmLroLocationHeader>

/**
* Gets all elastic pools in a server.
*/
@operationId("ElasticPools_ListByServer")
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
listByServer is ArmResourceListByParent<ElasticPool,{
    ...BaseParameters<ElasticPool>;
    /**
* The number of elements in the collection to skip.
*/
@query("$skip")
"$skip"?: int64
    }>

/**
* Cancels the asynchronous operation on the elastic pool.
*/
@operationId("ElasticPoolOperations_Cancel")
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
cancel is ArmResourceActionSync<ElasticPool,void,void,{
    ...BaseParameters<ElasticPool>;
    /**
* The operation identifier.
*/
@path
"operationId": string
    }>

/**
* Failovers an elastic pool.
*/
failover is ArmResourceActionAsync<ElasticPool,void,void>

@operationId("Metrics_ListElasticPool")
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
/**
* Returns elastic pool  metrics.
*/
// FIXME: Metrics_ListElasticPool could not be converted to a resource operation
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/metrics")
@get op `listElasticPool` is Azure.Core.Foundations.Operation<{/**
* The subscription ID that identifies an Azure subscription.
*/
@path
"subscriptionId": string
/**
* The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
*/
@path
"resourceGroupName": string
/**
* The name of the server.
*/
@path
"serverName": string
/**
* The name of the elastic pool.
*/
@path
"elasticPoolName": string
/**
* An OData filter expression that describes a subset of metrics to return.
*/
@query("$filter")
"$filter": string}, MetricListResult>;




@operationId("MetricDefinitions_ListElasticPool")
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
/**
* Returns elastic pool metric definitions.
*/
// FIXME: MetricDefinitions_ListElasticPool could not be converted to a resource operation
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/metricDefinitions")
@get op `listElasticPool` is Azure.Core.Foundations.Operation<{/**
* The subscription ID that identifies an Azure subscription.
*/
@path
"subscriptionId": string
/**
* The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
*/
@path
"resourceGroupName": string
/**
* The name of the server.
*/
@path
"serverName": string
/**
* The name of the elastic pool.
*/
@path
"elasticPoolName": string}, MetricDefinitionListResult>;




@operationId("ElasticPoolActivities_ListByElasticPool")
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
/**
* Returns elastic pool activities.
*/
// FIXME: ElasticPoolActivities_ListByElasticPool could not be converted to a resource operation
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/elasticPoolActivity")
@get op `listByElasticPool` is Azure.Core.Foundations.Operation<{/**
* The subscription ID that identifies an Azure subscription.
*/
@path
"subscriptionId": string
/**
* The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
*/
@path
"resourceGroupName": string
/**
* The name of the server.
*/
@path
"serverName": string
/**
* The name of the elastic pool for which to get the current activity.
*/
@path
"elasticPoolName": string}, ElasticPoolActivityListResult>;




@operationId("ElasticPoolDatabaseActivities_ListByElasticPool")
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
/**
* Returns activity on databases inside of an elastic pool.
*/
// FIXME: ElasticPoolDatabaseActivities_ListByElasticPool could not be converted to a resource operation
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/elasticPoolDatabaseActivity")
@get op `listByElasticPool` is Azure.Core.Foundations.Operation<{/**
* The subscription ID that identifies an Azure subscription.
*/
@path
"subscriptionId": string
/**
* The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
*/
@path
"resourceGroupName": string
/**
* The name of the server.
*/
@path
"serverName": string
/**
* The name of the elastic pool.
*/
@path
"elasticPoolName": string}, ElasticPoolDatabaseActivityListResult>;




@operationId("ElasticPoolOperations_ListByElasticPool")
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
/**
* Gets a list of operations performed on the elastic pool.
*/
// FIXME: ElasticPoolOperations_ListByElasticPool could not be converted to a resource operation
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/operations")
@get op `listByElasticPool` is Azure.Core.Foundations.Operation<{/**
* The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
*/
@path
"resourceGroupName": string
/**
* The name of the server.
*/
@path
"serverName": string

@path
"elasticPoolName": string
/**
* The subscription ID that identifies an Azure subscription.
*/
@path
"subscriptionId": string}, ElasticPoolOperationListResult>;




@operationId("Databases_ListByElasticPool")
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
/**
* Gets a list of databases in an elastic pool.
*/
// FIXME: Databases_ListByElasticPool could not be converted to a resource operation
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/databases")
@get op `listByElasticPool` is Azure.Core.Foundations.Operation<{/**
* The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
*/
@path
"resourceGroupName": string
/**
* The name of the server.
*/
@path
"serverName": string
/**
* The name of the elastic pool.
*/
@path
"elasticPoolName": string
/**
* The subscription ID that identifies an Azure subscription.
*/
@path
"subscriptionId": string}, ResourceListResult<Database>>;




}



@@projectedName(ElasticPools.`createOrUpdate`::parameters.resource, "json", "parameters");
@@extension(ElasticPools.`createOrUpdate`::parameters.resource, "x-ms-client-name", "parameters");
@@doc(ElasticPools.`createOrUpdate`::parameters.resource, "The elastic pool parameters.");
@@projectedName(ElasticPools.`update`::parameters.properties, "json", "parameters");
@@extension(ElasticPools.`update`::parameters.properties, "x-ms-client-name", "parameters");
@@doc(ElasticPools.`update`::parameters.properties, "The elastic pool update parameters.");