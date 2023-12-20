import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SqlServer.tsp";


using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;


namespace Azure.ResourceManager.Sql;
@doc("A database resource.")
@parentResource(SqlServer)
model SqlDatabase is TrackedResource<DatabaseProperties> {
@doc("The name of the database.")
@path
@key("databaseName")
@segment("databases")
"name": string;

...Azure.ResourceManager.ManagedServiceIdentity

...Azure.ResourceManager.ResourceSku

...Azure.ResourceManager.ResourceKind

...Azure.ResourceManager.ManagedBy
}



@armResourceOperations
interface SqlDatabases {
@doc("Gets a database.")
get is ArmResourceRead<SqlDatabase,{
    ...BaseParameters<SqlDatabase>,
    @doc("The child resources to include in the response.")
@query("$expand")
"$expand"?: string
@doc("An OData filter expression that filters elements in the collection.")
@query("$filter")
"$filter"?: string
    }>
@doc("Creates a new database or updates an existing database.")
createOrUpdate is ArmResourceCreateOrUpdateAsync<SqlDatabase>
@doc("Updates an existing database.")
update is ArmResourcePatchAsync<SqlDatabase,DatabaseProperties>
@doc("Deletes the database.")
delete is ArmResourceDeleteAsync<SqlDatabase>
@doc("Gets a list of databases.")
listByServer is ArmResourceListByParent<SqlDatabase,{
    ...BaseParameters<SqlDatabase>,
    
@query("$skipToken")
"$skipToken"?: string
    }>
@doc("Creates a restore point for a data warehouse.")
create is ArmResourceActionAsync<SqlDatabase,CreateDatabaseRestorePointDefinition,SqlServerDatabaseRestorePoint>
@doc("Cancels the asynchronous operation on the database.")
cancel is ArmResourceActionSync<SqlDatabase,void,void,{
    ...BaseParameters<SqlDatabase>,
    @doc("The operation identifier.")
@path
"operationId": string
    }>
@doc("Revalidates an existing encryption protector for a particular database.")
revalidate is ArmResourceActionAsync<SqlDatabase,void,void,{
    ...BaseParameters<SqlDatabase>,
    @doc("The name of the encryption protector to be updated.")
@path
"encryptionProtectorName": EncryptionProtectorName
    }>
@doc("Reverts an existing encryption protector for a particular database.")
revert is ArmResourceActionAsync<SqlDatabase,void,void,{
    ...BaseParameters<SqlDatabase>,
    @doc("The name of the encryption protector to be updated.")
@path
"encryptionProtectorName": EncryptionProtectorName
    }>
@doc("Exports a database.")
export is ArmResourceActionAsync<SqlDatabase,ExportDatabaseDefinition,ImportExportOperationResult>
@doc("Failovers a database.")
failover is ArmResourceActionAsync<SqlDatabase,void,void,{
    ...BaseParameters<SqlDatabase>,
    @doc("The type of replica to be failed over.")
@query("replicaType")
"replicaType"?: ReplicaType
    }>
@doc("Imports a bacpac into a new database.")
import is ArmResourceActionAsync<SqlDatabase,ImportExistingDatabaseDefinition,ImportExportOperationResult>
@doc("Renames a database.")
rename is ArmResourceActionSync<SqlDatabase,ResourceMoveDefinition,void>
@doc("Pauses a database.")
pause is ArmResourceActionAsync<SqlDatabase,void,SqlDatabase>
@doc("Resumes a database.")
resume is ArmResourceActionAsync<SqlDatabase,void,SqlDatabase>
@doc("Upgrades a data warehouse.")
upgradeDataWarehouse is ArmResourceActionAsync<SqlDatabase,void,void>
@doc("Returns database metrics.")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/metrics")
@get op ListDatabase is Azure.Core.Foundations.Operation<{@doc("The subscription ID that identifies an Azure subscription.")
@path
"subscriptionId": string
@doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
@path
"resourceGroupName": string
@doc("The name of the server.")
@path
"serverName": string
@doc("The name of the database.")
@path
"databaseName": string
@doc("An OData filter expression that describes a subset of metrics to return.")
@query("$filter")
"$filter": string}, MetricListResult>;



@doc("Returns database metric definitions.")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/metricDefinitions")
@get op ListDatabase is Azure.Core.Foundations.Operation<{@doc("The subscription ID that identifies an Azure subscription.")
@path
"subscriptionId": string
@doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
@path
"resourceGroupName": string
@doc("The name of the server.")
@path
"serverName": string
@doc("The name of the database.")
@path
"databaseName": string}, MetricDefinitionListResult>;



@doc("List database columns")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/columns")
@get op ListByDatabase is Azure.Core.Foundations.Operation<{@doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
@path
"resourceGroupName": string
@doc("The name of the server.")
@path
"serverName": string
@doc("The name of the database.")
@path
"databaseName": string

@query({name: "schema", format: "multi"})
"schema"?: string[]

@query({name: "table", format: "multi"})
"table"?: string[]

@query({name: "column", format: "multi"})
"column"?: string[]

@query({name: "orderBy", format: "multi"})
"orderBy"?: string[]
@doc("An opaque token that identifies a starting point in the collection.")
@query("$skiptoken")
"$skiptoken"?: string
@doc("The subscription ID that identifies an Azure subscription.")
@path
"subscriptionId": string}, DatabaseColumnListResult>;



@doc("List database extension. This will return an empty list as it is not supported.")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/extensions")
@get op ListByDatabase is Azure.Core.Foundations.Operation<{@doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
@path
"resourceGroupName": string
@doc("The name of the server.")
@path
"serverName": string
@doc("The name of the database.")
@path
"databaseName": string
@doc("The subscription ID that identifies an Azure subscription.")
@path
"subscriptionId": string}, ImportExportExtensionsOperationListResult>;



@doc("Gets a list of operations performed on the database.")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/operations")
@get op ListByDatabase is Azure.Core.Foundations.Operation<{@doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
@path
"resourceGroupName": string
@doc("The name of the server.")
@path
"serverName": string
@doc("The name of the database.")
@path
"databaseName": string
@doc("The subscription ID that identifies an Azure subscription.")
@path
"subscriptionId": string}, DatabaseOperationListResult>;



@doc("Gets database usages.")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/usages")
@get op ListByDatabase is Azure.Core.Foundations.Operation<{@doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
@path
"resourceGroupName": string
@doc("The name of the server.")
@path
"serverName": string
@doc("The name of the database.")
@path
"databaseName": string
@doc("The subscription ID that identifies an Azure subscription.")
@path
"subscriptionId": string}, DatabaseUsageListResult>;



@doc("Gets the sensitivity labels of a given database")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/currentSensitivityLabels")
@get op ListCurrentByDatabase is Azure.Core.Foundations.Operation<{@doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
@path
"resourceGroupName": string
@doc("The name of the server.")
@path
"serverName": string
@doc("The name of the database.")
@path
"databaseName": string

@query("$skipToken")
"$skipToken"?: string

@query("$count")
"$count"?: boolean
@doc("An OData filter expression that filters elements in the collection.")
@query("$filter")
"$filter"?: string
@doc("The subscription ID that identifies an Azure subscription.")
@path
"subscriptionId": string}, SensitivityLabelListResult>;



@doc("Gets the sensitivity labels of a given database")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/recommendedSensitivityLabels")
@get op ListRecommendedByDatabase is Azure.Core.Foundations.Operation<{@doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
@path
"resourceGroupName": string
@doc("The name of the server.")
@path
"serverName": string
@doc("The name of the database.")
@path
"databaseName": string

@query("$skipToken")
"$skipToken"?: string
@doc("Specifies whether to include disabled recommendations or not.")
@query("includeDisabledRecommendations")
"includeDisabledRecommendations"?: boolean
@doc("An OData filter expression that filters elements in the collection.")
@query("$filter")
"$filter"?: string
@doc("The subscription ID that identifies an Azure subscription.")
@path
"subscriptionId": string}, SensitivityLabelListResult>;



@doc("Gets all synapselink workspaces for a database.")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/linkWorkspaces")
@get op ListByDatabase is Azure.Core.Foundations.Operation<{@doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
@path
"resourceGroupName": string
@doc("The name of the server.")
@path
"serverName": string
@doc("The name of the database.")
@path
"databaseName": string
@doc("The subscription ID that identifies an Azure subscription.")
@path
"subscriptionId": string}, SynapseLinkWorkspaceListResult>;



}