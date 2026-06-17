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
* A database resource.
*/
@parentResource(Server)
model Database is TrackedResource<DatabaseProperties> {
/**
* The name of the database.
*/
@path
@key("databaseName")
@segment("databases")
"name": string;

...Azure.ResourceManager.ManagedServiceIdentity;

...Azure.ResourceManager.ResourceSku;

...Azure.ResourceManager.ResourceKind;

...Azure.ResourceManager.ManagedBy
}



@armResourceOperations
interface Databases {
/**
* Gets a database.
*/
get is ArmResourceRead<Database,{
    ...BaseParameters<Database>,
    /**
* The child resources to include in the response.
*/
@query("$expand")
"$expand"?: string;
/**
* An OData filter expression that filters elements in the collection.
*/
@query("$filter")
"$filter"?: string
    }>;

/**
* Creates a new database or updates an existing database.
*/
createOrUpdate is ArmResourceCreateOrReplaceAsync<Database,BaseParameters<Database>,ArmAsyncOperationHeader>;

/**
* Updates an existing database.
*/
@parameterVisibility("read")
update is ArmCustomPatchAsync<Database,DatabaseUpdate,BaseParameters<Database>,ArmLroLocationHeader>;

/**
* Deletes the database.
*/
delete is ArmResourceDeleteAsync<Database,BaseParameters<Database>,ArmLroLocationHeader>;

/**
* Gets a list of databases.
*/
@operationId("Databases_ListByServer")
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
listByServer is ArmResourceListByParent<Database,{
    ...BaseParameters<Database>,
    
@query("$skipToken")
"$skipToken"?: string
    }>;

/**
* Creates a restore point for a data warehouse.
*/
@operationId("RestorePoints_Create")
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
create is ArmResourceActionAsync<Database,CreateDatabaseRestorePointDefinition,RestorePoint>;

/**
* Cancels the asynchronous operation on the database.
*/
@operationId("DatabaseOperations_Cancel")
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
cancel is ArmResourceActionSync<Database,void,void,{
    ...BaseParameters<Database>,
    /**
* The operation identifier.
*/
@path
"operationId": string
    }>;

/**
* Revalidates an existing encryption protector for a particular database.
*/
@operationId("DatabaseEncryptionProtectors_Revalidate")
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
revalidate is ArmResourceActionAsync<Database,void,void,{
    ...BaseParameters<Database>,
    /**
* The name of the encryption protector to be updated.
*/
@path
"encryptionProtectorName": EncryptionProtectorName
    },ArmLroLocationHeader>;

/**
* Reverts an existing encryption protector for a particular database.
*/
@operationId("DatabaseEncryptionProtectors_Revert")
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
revert is ArmResourceActionAsync<Database,void,void,{
    ...BaseParameters<Database>,
    /**
* The name of the encryption protector to be updated.
*/
@path
"encryptionProtectorName": EncryptionProtectorName
    },ArmLroLocationHeader>;

/**
* Exports a database.
*/
export is ArmResourceActionAsync<Database,ExportDatabaseDefinition,ImportExportOperationResult>;

/**
* Failovers a database.
*/
failover is ArmResourceActionAsync<Database,void,void,{
    ...BaseParameters<Database>,
    /**
* The type of replica to be failed over.
*/
@query("replicaType")
"replicaType"?: ReplicaType
    }>

/**
* Imports a bacpac into a new database.
*/
import is ArmResourceActionAsync<Database,ImportExistingDatabaseDefinition,ImportExportOperationResult>

/**
* Renames a database.
*/
rename is ArmResourceActionSync<Database,ResourceMoveDefinition,void>

/**
* Pauses a database.
*/
pause is ArmResourceActionAsync<Database,void,Database>

/**
* Resumes a database.
*/
resume is ArmResourceActionAsync<Database,void,Database>

/**
* Upgrades a data warehouse.
*/
upgradeDataWarehouse is ArmResourceActionAsync<Database,void,void>

@operationId("Metrics_ListDatabase")
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
/**
* Returns database metrics.
*/
// FIXME: Metrics_ListDatabase could not be converted to a resource operation
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/metrics")
@get op `listDatabase` is Azure.Core.Foundations.Operation<{/**
* The subscription ID that identifies an Azure subscription.
*/
@path
"subscriptionId": string;
/**
* The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
*/
@path
"resourceGroupName": string;
/**
* The name of the server.
*/
@path
"serverName": string;
/**
* The name of the database.
*/
@path;
"databaseName": string;
/**
* An OData filter expression that describes a subset of metrics to return.
*/
@query("$filter")
"$filter": string}, MetricListResult>;




@operationId("MetricDefinitions_ListDatabase")
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
/**
* Returns database metric definitions.
*/
// FIXME: MetricDefinitions_ListDatabase could not be converted to a resource operation
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/metricDefinitions")
@get op `listDatabase` is Azure.Core.Foundations.Operation<{/**
* The subscription ID that identifies an Azure subscription.
*/
@path
"subscriptionId": string;
/**
* The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
*/
@path
"resourceGroupName": string;
/**
* The name of the server.
*/
@path
"serverName": string;
/**
* The name of the database.
*/
@path
"databaseName": string}, MetricDefinitionListResult>;




@operationId("DatabaseColumns_ListByDatabase")
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
/**
* List database columns
*/
// FIXME: DatabaseColumns_ListByDatabase could not be converted to a resource operation
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/columns")
@get op `listByDatabase` is Azure.Core.Foundations.Operation<{/**
* The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
*/
@path
"resourceGroupName": string;
/**
* The name of the server.
*/
@path
"serverName": string;
/**
* The name of the database.
*/
@path
"databaseName": string;

@query({name: "schema", format: "multi"})
"schema"?: string[];

@query({name: "table", format: "multi"})
"table"?: string[];

@query({name: "column", format: "multi"})
"column"?: string[];

@query({name: "orderBy", format: "multi"})
"orderBy"?: string[];
/**
* An opaque token that identifies a starting point in the collection.
*/
@query("$skiptoken")
"$skiptoken"?: string;
/**
* The subscription ID that identifies an Azure subscription.
*/
@path
"subscriptionId": string}, ResourceListResult<DatabaseColumn>>;




@operationId("DatabaseExtensions_ListByDatabase")
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
/**
* List database extension. This will return an empty list as it is not supported.
*/
// FIXME: DatabaseExtensions_ListByDatabase could not be converted to a resource operation
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/extensions")
@get op `listByDatabase` is Azure.Core.Foundations.Operation<{/**
* The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
*/
@path
"resourceGroupName": string;
/**
* The name of the server.
*/
@path
"serverName": string;
/**
* The name of the database.
*/
@path
"databaseName": string;
/**
* The subscription ID that identifies an Azure subscription.
*/
@path
"subscriptionId": string}, ImportExportExtensionsOperationListResult>;




@operationId("DatabaseOperations_ListByDatabase")
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
/**
* Gets a list of operations performed on the database.
*/
// FIXME: DatabaseOperations_ListByDatabase could not be converted to a resource operation
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/operations")
@get op `listByDatabase` is Azure.Core.Foundations.Operation<{/**
* The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
*/
@path
"resourceGroupName": string;
/**
* The name of the server.
*/
@path
"serverName": string;
/**
* The name of the database.
*/
@path
"databaseName": string
/**
* The subscription ID that identifies an Azure subscription.
*/
@path
"subscriptionId": string}, DatabaseOperationListResult>;




@operationId("DatabaseUsages_ListByDatabase")
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
/**
* Gets database usages.
*/
// FIXME: DatabaseUsages_ListByDatabase could not be converted to a resource operation
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/usages")
@get op `listByDatabase` is Azure.Core.Foundations.Operation<{/**
* The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
*/
@path
"resourceGroupName": string;
/**
* The name of the server.
*/
@path
"serverName": string;
/**
* The name of the database.
*/
@path
"databaseName": string;
/**
* The subscription ID that identifies an Azure subscription.
*/
@path
"subscriptionId": string}, DatabaseUsageListResult>;




@operationId("SensitivityLabels_ListCurrentByDatabase")
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
/**
* Gets the sensitivity labels of a given database
*/
// FIXME: SensitivityLabels_ListCurrentByDatabase could not be converted to a resource operation
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/currentSensitivityLabels")
@get op `listCurrentByDatabase` is Azure.Core.Foundations.Operation<{/**
* The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
*/
@path
"resourceGroupName": string;
/**
* The name of the server.
*/
@path
"serverName": string;
/**
* The name of the database.
*/
@path
"databaseName": string;

@query("$skipToken")
"$skipToken"?: string;

@query("$count")
"$count"?: boolean;
/**
* An OData filter expression that filters elements in the collection.
*/
@query("$filter")
"$filter"?: string;
/**
* The subscription ID that identifies an Azure subscription.
*/
@path
"subscriptionId": string}, SensitivityLabelListResult>;




@operationId("SensitivityLabels_ListRecommendedByDatabase")
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
/**
* Gets the sensitivity labels of a given database
*/
// FIXME: SensitivityLabels_ListRecommendedByDatabase could not be converted to a resource operation
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/recommendedSensitivityLabels")
@get op `listRecommendedByDatabase` is Azure.Core.Foundations.Operation<{/**
* The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
*/
@path
"resourceGroupName": string;
/**
* The name of the server.
*/
@path
"serverName": string;
/**
* The name of the database.
*/
@path
"databaseName": string;

@query("$skipToken")
"$skipToken"?: string;
/**
* Specifies whether to include disabled recommendations or not.
*/
@query("includeDisabledRecommendations")
"includeDisabledRecommendations"?: boolean;
/**
* An OData filter expression that filters elements in the collection.
*/
@query("$filter")
"$filter"?: string;
/**
* The subscription ID that identifies an Azure subscription.
*/
@path
"subscriptionId": string}, SensitivityLabelListResult>;




@operationId("SynapseLinkWorkspaces_ListByDatabase")
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
/**
* Gets all synapselink workspaces for a database.
*/
// FIXME: SynapseLinkWorkspaces_ListByDatabase could not be converted to a resource operation
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/linkWorkspaces")
@get op `listByDatabase` is Azure.Core.Foundations.Operation<{/**
* The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
*/
@path
"resourceGroupName": string;
/**
* The name of the server.
*/
@path
"serverName": string;
/**
* The name of the database.
*/
@path
"databaseName": string;
/**
* The subscription ID that identifies an Azure subscription.
*/
@path
"subscriptionId": string}, SynapseLinkWorkspaceListResult>;




}



@@projectedName(Databases.createOrUpdate::parameters.resource, "json", "parameters");
@@extension(Databases.createOrUpdate::parameters.resource, "x-ms-client-name", "parameters");
@@doc(Databases.createOrUpdate::parameters.resource, "The requested database resource state.");
@@projectedName(Databases.update::parameters.properties, "json", "parameters");
@@extension(Databases.update::parameters.properties, "x-ms-client-name", "parameters");
@@doc(Databases.update::parameters.properties, "The requested database resource state.");
@@projectedName(Databases.create::parameters.body, "json", "parameters");
@@extension(Databases.create::parameters.body, "x-ms-client-name", "parameters");
@@doc(Databases.create::parameters.body, "The definition for creating the restore point of this database.");
@@projectedName(Databases.export::parameters.body, "json", "parameters");
@@extension(Databases.export::parameters.body, "x-ms-client-name", "parameters");
@@doc(Databases.export::parameters.body, "The database export request parameters.");
@@projectedName(Databases.import::parameters.body, "json", "parameters");
@@extension(Databases.import::parameters.body, "x-ms-client-name", "parameters");
@@doc(Databases.import::parameters.body, "The database import request parameters.");
@@projectedName(Databases.rename::parameters.body, "json", "parameters");
@@extension(Databases.rename::parameters.body, "x-ms-client-name", "parameters");
@@doc(Databases.rename::parameters.body, "The resource move definition for renaming this database.");