import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";


using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;


namespace Microsoft.Sql;
/**
* A database resource.
*/
@parentResource(Server)
model Database is Azure.ResourceManager.TrackedResource<DatabaseProperties> {
...ResourceNameParameter<Resource = Database,KeyName = "databaseName",SegmentName = "databases",NamePattern = "">
/**
* The database SKU.
* 
* The list of SKUs may vary by region and support offer. To determine the SKUs (including the SKU name, tier/edition, family, and capacity) that are available to your subscription in an Azure region, use the `Capabilities_ListByLocation` REST API or one of the following commands:
* 
* ```azurecli
* az sql db list-editions -l <location> -o table
* ````
* 
* ```powershell
* Get-AzSqlServerServiceObjective -Location <location>
* ````
* 
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
"sku"?: Sku;
/**
* Kind of database. This is metadata used for the Azure portal experience.
*/
@visibility(Lifecycle.Read)
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
"kind"?: string;
/**
* Resource that manages the database.
*/
@visibility(Lifecycle.Read)
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
"managedBy"?: string;
/**
* The Azure Active Directory identity of the database.
*/
@visibility(Lifecycle.Read, Lifecycle.Create)
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
"identity"?: DatabaseIdentity;
}



@armResourceOperations
interface Databases {
/**
* Gets a database.
*/
get is ArmResourceRead<Database, Parameters = { /**
* The child resources to include in the response.
*/
@query("$expand")
"$expand"?: string,
/**
* An OData filter expression that filters elements in the collection.
*/
@query("$filter")
"$filter"?: string }
        >;


/**
* Creates a new database or updates an existing database.
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
createOrUpdate is ArmResourceCreateOrReplaceAsync<Database, Response = ArmResourceUpdatedResponse<Database> | ArmResourceCreatedResponse<Database> | ArmAcceptedLroResponse
        >;


/**
* Updates an existing database.
*/
@patch(#{ implicitOptionality: false })
update is ArmCustomPatchAsync<Database, PatchModel = DatabaseUpdate
        >;


/**
* Deletes the database.
*/
#suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
delete is ArmResourceDeleteWithoutOkAsync<Database, Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
        >;


/**
* Gets a list of databases.
*/
listByServer is ArmResourceListByParent<Database, Parameters = { 
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
@query("$skipToken")
"$skipToken"?: string }
        >;


/**
* List database columns
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("DatabaseColumns_ListByDatabase")
@list
@get
@action("columns")
listByDatabase is ArmResourceActionSync<Database, void, ArmResponse<ResourceListResult<DatabaseColumn>>, Parameters = { 
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-query-explode" "For backward compatibility"
@query(#{ name: "schema", explode: true })
"schema"?: string[],

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-query-explode" "For backward compatibility"
@query(#{ name: "table", explode: true })
"table"?: string[],

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-query-explode" "For backward compatibility"
@query(#{ name: "column", explode: true })
"column"?: string[],

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-query-explode" "For backward compatibility"
@query(#{ name: "orderBy", explode: true })
"orderBy"?: string[],
/**
* An opaque token that identifies a starting point in the collection.
*/
@query("$skiptoken")
"$skiptoken"?: string }>;


/**
* Revalidates an existing encryption protector for a particular database.
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("DatabaseEncryptionProtectors_Revalidate")
revalidate is ArmResourceActionAsync<Database, void, OkResponse, Parameters = { /**
* The name of the encryption protector to be updated.
*/
@path
"encryptionProtectorName": EncryptionProtectorName }>;


/**
* Reverts an existing encryption protector for a particular database.
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("DatabaseEncryptionProtectors_Revert")
revert is ArmResourceActionAsync<Database, void, OkResponse, Parameters = { /**
* The name of the encryption protector to be updated.
*/
@path
"encryptionProtectorName": EncryptionProtectorName }>;


/**
* Gets a list of operations performed on the database.
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("DatabaseOperations_ListByDatabase")
@list
@get
@action("operations")
databaseOperationsListByDatabase is ArmResourceActionSync<Database, void, ArmResponse<ResourceListResult<DatabaseOperation>>>;


/**
* Cancels the asynchronous operation on the database.
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("DatabaseOperations_Cancel")
cancel is ArmResourceActionSync<Database, void, OkResponse, Parameters = { /**
* The operation identifier.
*/
#suppress "@azure-tools/typespec-azure-core/no-format"
@format("uuid")
@path
"operationId": string }>;


/**
* Exports a database.
*/
export is ArmResourceActionAsync<Database, ExportDatabaseDefinition, ArmResponse<ImportExportOperationResult>>;


/**
* Failovers a database.
*/
failover is ArmResourceActionAsync<Database, void, OkResponse, Parameters = { /**
* The type of replica to be failed over.
*/
@query("replicaType")
"replicaType"?: ReplicaType }>;


/**
* Imports a bacpac into a new database.
*/
import is ArmResourceActionAsync<Database, ImportExistingDatabaseDefinition, ArmResponse<ImportExportOperationResult>>;


/**
* Renames a database.
*/
@action("move")
rename is ArmResourceActionSync<Database, ResourceMoveDefinition, OkResponse>;


/**
* Pauses a database.
*/
pause is ArmResourceActionAsync<Database, void, ArmResponse<Database>>;


/**
* Resumes a database.
*/
resume is ArmResourceActionAsync<Database, void, ArmResponse<Database>>;


/**
* Upgrades a data warehouse.
*/
upgradeDataWarehouse is ArmResourceActionAsync<Database, void, OkResponse>;


/**
* Gets database usages.
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("DatabaseUsages_ListByDatabase")
@list
@get
@action("usages")
databaseUsagesListByDatabase is ArmResourceActionSync<Database, void, ArmResponse<ResourceListResult<DatabaseUsage>>>;


/**
* Creates a restore point for a data warehouse.
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("RestorePoints_Create")
@action("restorePoints")
create is ArmResourceActionAsync<Database, CreateDatabaseRestorePointDefinition, ArmResponse<RestorePoint> | ArmResourceCreatedResponse<RestorePoint>>;


/**
* Gets the sensitivity labels of a given database
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("SensitivityLabels_ListCurrentByDatabase")
@list
@get
@action("currentSensitivityLabels")
listCurrentByDatabase is ArmResourceActionSync<Database, void, ArmResponse<ResourceListResult<SensitivityLabel>>, Parameters = { 
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
@query("$skipToken")
"$skipToken"?: string,

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
@query("$count")
"$count"?: boolean,
/**
* An OData filter expression that filters elements in the collection.
*/
@query("$filter")
"$filter"?: string }>;


/**
* Update sensitivity labels of a given database using an operations batch.
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("SensitivityLabels_Update")
@patch
@action("currentSensitivityLabels")
sensitivityLabelsUpdate is ArmResourceActionSync<Database, SensitivityLabelUpdateList, OkResponse>;


/**
* Gets the sensitivity labels of a given database
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("SensitivityLabels_ListRecommendedByDatabase")
@list
@get
@action("recommendedSensitivityLabels")
listRecommendedByDatabase is ArmResourceActionSync<Database, void, ArmResponse<ResourceListResult<SensitivityLabel>>, Parameters = { 
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
@query("$skipToken")
"$skipToken"?: string,
/**
* Specifies whether to include disabled recommendations or not.
*/
@query("includeDisabledRecommendations")
"includeDisabledRecommendations"?: boolean,
/**
* An OData filter expression that filters elements in the collection.
*/
@query("$filter")
"$filter"?: string }>;


/**
* Update recommended sensitivity labels states of a given database using an operations batch.
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("RecommendedSensitivityLabels_Update")
@patch
@action("recommendedSensitivityLabels")
recommendedSensitivityLabelsUpdate is ArmResourceActionSync<Database, RecommendedSensitivityLabelUpdateList, OkResponse>;


/**
* Gets the sensitivity labels of a given database
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("SensitivityLabels_ListByDatabase")
@list
@get
@action("sensitivityLabels")
sensitivityLabelsListByDatabase is ArmResourceActionSync<Database, void, ArmResponse<ResourceListResult<SensitivityLabel>>, Parameters = { /**
* An OData filter expression that filters elements in the collection.
*/
@query("$filter")
"$filter"?: string }>;


/**
* Gets all synapselink workspaces for a database.
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("SynapseLinkWorkspaces_ListByDatabase")
@list
@get
@action("linkWorkspaces")
synapseLinkWorkspacesListByDatabase is ArmResourceActionSync<Database, void, ArmResponse<ResourceListResult<SynapseLinkWorkspace>>>;


}


@@doc(Database.name, "The name of the database.")
@@doc(Database.properties, "Resource properties.")
@@doc(Databases.`createOrUpdate`::parameters.resource, "The requested database resource state.");
@@doc(Databases.`update`::parameters.properties, "The requested database resource state.");
@@doc(Databases.`export`::parameters.body, "The database export request parameters.");
@@doc(Databases.`import`::parameters.body, "The database import request parameters.");
@@doc(Databases.`rename`::parameters.body, "The resource move definition for renaming this database.");
@@doc(Databases.`create`::parameters.body, "The definition for creating the restore point of this database.");
@@doc(Databases.`sensitivityLabelsUpdate`::parameters.body, "");
@@doc(Databases.`recommendedSensitivityLabelsUpdate`::parameters.body, "");