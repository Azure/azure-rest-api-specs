import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";


using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;


namespace Azure.ResourceManager.Sql;
@doc("A database resource.")
@parentResource(Server)
model Database is TrackedResource<DatabaseProperties> {
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
interface Databases {
@doc("Gets a database.")
get is ArmResourceRead<Database,{
    ...BaseParameters<Database>,
    @doc("The child resources to include in the response.")
@query("$expand")
"$expand"?: string
@doc("An OData filter expression that filters elements in the collection.")
@query("$filter")
"$filter"?: string
    }>
@doc("Creates a new database or updates an existing database.")
createOrUpdate is ArmResourceCreateOrUpdateAsync<Database>
@doc("Updates an existing database.")
update is ArmResourcePatchAsync<Database,DatabaseProperties>
@doc("Deletes the database.")
delete is ArmResourceDeleteAsync<Database>
@doc("Gets a list of databases.")
listByServer is ArmResourceListByParent<Database,{
    ...BaseParameters<Database>,
    
@query("$skipToken")
"$skipToken"?: string
    }>
@doc("Exports a database.")
export is ArmResourceActionAsync<Database,ExportDatabaseDefinition,ImportExportOperationResult>
@doc("Failovers a database.")
failover is ArmResourceActionAsync<Database,void,void,{
    ...BaseParameters<Database>,
    @doc("The type of replica to be failed over.")
@query("replicaType")
"replicaType"?: ReplicaType
    }>
@doc("Imports a bacpac into a new database.")
import is ArmResourceActionAsync<Database,ImportExistingDatabaseDefinition,ImportExportOperationResult>
@doc("Renames a database.")
rename is ArmResourceActionSync<Database,ResourceMoveDefinition,void>
@doc("Pauses a database.")
pause is ArmResourceActionAsync<Database,void,Database>
@doc("Resumes a database.")
resume is ArmResourceActionAsync<Database,void,Database>
@doc("Upgrades a data warehouse.")
upgradeDataWarehouse is ArmResourceActionAsync<Database,void,void>
}

@armResourceOperations
interface RestorePoints {
@doc("Creates a restore point for a data warehouse.")
create is ArmResourceActionAsync<Database,CreateDatabaseRestorePointDefinition,RestorePoint>
}

@armResourceOperations
interface DatabaseOperations {
@doc("Cancels the asynchronous operation on the database.")
cancel is ArmResourceActionSync<Database,void,void,{
    ...BaseParameters<Database>,
    @doc("The operation identifier.")
@path
"operationId": string
    }>
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



}

@armResourceOperations
interface DatabaseEncryptionProtectors {
@doc("Revalidates an existing encryption protector for a particular database.")
revalidate is ArmResourceActionAsync<Database,void,void,{
    ...BaseParameters<Database>,
    @doc("The name of the encryption protector to be updated.")
@path
"encryptionProtectorName": EncryptionProtectorName
    }>
@doc("Reverts an existing encryption protector for a particular database.")
revert is ArmResourceActionAsync<Database,void,void,{
    ...BaseParameters<Database>,
    @doc("The name of the encryption protector to be updated.")
@path
"encryptionProtectorName": EncryptionProtectorName
    }>
}

@armResourceOperations
interface Metrics {
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



}

@armResourceOperations
interface MetricDefinitions {
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



}

@armResourceOperations
interface DatabaseColumns {
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



}

@armResourceOperations
interface DatabaseExtensions {
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



}

@armResourceOperations
interface DatabaseUsages {
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



}

@armResourceOperations
interface SensitivityLabels {
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



}

@armResourceOperations
interface SynapseLinkWorkspaces {
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
