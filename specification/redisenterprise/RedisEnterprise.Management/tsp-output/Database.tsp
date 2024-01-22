import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";


using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;


namespace Microsoft.Cache;
/**
* Describes a database on the RedisEnterprise cluster
*/
@parentResource(Cluster)
model Database is ProxyResource<DatabaseProperties> {
/**
* The name of the database.
*/
@path
@key("databaseName")
@segment("databases")
"name": string;
}



@armResourceOperations
interface Databases {
/**
* Gets information about a database in a RedisEnterprise cluster.
*/
get is ArmResourceRead<Database>

/**
* Creates a database
*/
create is ArmResourceCreateOrReplaceAsync<Database>

/**
* Updates a database
*/
@parameterVisibility("read")
update is ArmCustomPatchAsync<Database,DatabaseUpdate,BaseParameters<Database>,ArmAsyncOperationHeader>

/**
* Deletes a single database
*/
delete is ArmResourceDeleteAsync<Database,BaseParameters<Database>,ArmAsyncOperationHeader>

/**
* Gets all databases in the specified RedisEnterprise cluster.
*/
@operationId("Databases_ListByCluster")
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
listByCluster is ArmResourceListByParent<Database>

/**
* Retrieves the access keys for the RedisEnterprise database.
*/
listKeys is ArmResourceActionSync<Database,void,AccessKeys>

/**
* Regenerates the RedisEnterprise database's access keys.
*/
regenerateKey is ArmResourceActionAsync<Database,RegenerateKeyParameters,AccessKeys,BaseParameters<Database>,ArmLroLocationHeader>

/**
* Imports database files to target database.
*/
import is ArmResourceActionAsync<Database,ImportClusterParameters,void,BaseParameters<Database>,ArmAsyncOperationHeader>

/**
* Exports a database file from target database.
*/
export is ArmResourceActionAsync<Database,ExportClusterParameters,void,BaseParameters<Database>,ArmAsyncOperationHeader>

/**
* Forcibly removes the link to the specified database resource.
*/
forceUnlink is ArmResourceActionAsync<Database,ForceUnlinkParameters,void,BaseParameters<Database>,ArmAsyncOperationHeader>

/**
* Flushes all the keys in this database and also from its linked databases.
*/
flush is ArmResourceActionAsync<Database,FlushParameters,void,BaseParameters<Database>,ArmLroLocationHeader>

}



@@projectedName(Databases.create::parameters.resource, "json", "parameters");
@@extension(Databases.create::parameters.resource, "x-ms-client-name", "parameters");
@@doc(Databases.create::parameters.resource, "Parameters supplied to the create or update database operation.");
@@projectedName(Databases.update::parameters.properties, "json", "parameters");
@@extension(Databases.update::parameters.properties, "x-ms-client-name", "parameters");
@@doc(Databases.update::parameters.properties, "Parameters supplied to the create or update database operation.");
@@projectedName(Databases.regenerateKey::parameters.body, "json", "parameters");
@@extension(Databases.regenerateKey::parameters.body, "x-ms-client-name", "parameters");
@@doc(Databases.regenerateKey::parameters.body, "Specifies which key to regenerate.");
@@projectedName(Databases.import::parameters.body, "json", "parameters");
@@extension(Databases.import::parameters.body, "x-ms-client-name", "parameters");
@@doc(Databases.import::parameters.body, "Storage information for importing into the cluster");
@@projectedName(Databases.export::parameters.body, "json", "parameters");
@@extension(Databases.export::parameters.body, "x-ms-client-name", "parameters");
@@doc(Databases.export::parameters.body, "Storage information for exporting into the cluster");
@@projectedName(Databases.forceUnlink::parameters.body, "json", "parameters");
@@extension(Databases.forceUnlink::parameters.body, "x-ms-client-name", "parameters");
@@doc(Databases.forceUnlink::parameters.body, "Information identifying the database to be unlinked.");
@@projectedName(Databases.flush::parameters.body, "json", "parameters");
@@extension(Databases.flush::parameters.body, "x-ms-client-name", "parameters");
@@doc(Databases.flush::parameters.body, "Information identifying the databases to be flushed");