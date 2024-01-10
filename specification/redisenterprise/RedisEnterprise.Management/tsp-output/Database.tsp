import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";


using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;


namespace Microsoft.Cache;
@doc("Describes a database on the RedisEnterprise cluster")
@parentResource(Cluster)
model Database is ProxyResource<DatabaseProperties> {
@doc("The name of the database.")
@key("databaseName")
@segment("databases")
"name": string;
}



@armResourceOperations
interface Databases {
@doc("Gets information about a database in a RedisEnterprise cluster.")
get is ArmResourceRead<Database>

@doc("Creates a database")
create is ArmResourceCreateOrUpdateAsync<Database>

@doc("Updates a database")
update is ArmCustomPatchAsync<Database,DatabaseUpdate>

@doc("Deletes a single database")
delete is ArmResourceDeleteAsync<Database>

@doc("Gets all databases in the specified RedisEnterprise cluster.")
listByCluster is ArmResourceListByParent<Database>

@doc("Retrieves the access keys for the RedisEnterprise database.")
listKeys is ArmResourceActionSync<Database,void,AccessKeys>

@doc("Regenerates the RedisEnterprise database's access keys.")
regenerateKey is ArmResourceActionAsync<Database,RegenerateKeyParameters,AccessKeys>

@doc("Imports database files to target database.")
import is ArmResourceActionAsync<Database,ImportClusterParameters,void>

@doc("Exports a database file from target database.")
export is ArmResourceActionAsync<Database,ExportClusterParameters,void>

@doc("Forcibly removes the link to the specified database resource.")
forceUnlink is ArmResourceActionAsync<Database,ForceUnlinkParameters,void>

@doc("Flushes all the keys in this database and also from its linked databases.")
flush is ArmResourceActionAsync<Database,FlushParameters,void>

}
