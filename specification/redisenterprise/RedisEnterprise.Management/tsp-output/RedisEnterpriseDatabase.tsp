import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./RedisEnterpriseCluster.tsp";


using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;


namespace Azure.ResourceManager.RedisEnterprise;
@doc("Describes a database on the RedisEnterprise cluster")
@parentResource(RedisEnterpriseCluster)
model RedisEnterpriseDatabase is ProxyResource<DatabaseProperties> {
@doc("The name of the database.")
@path
@key("databaseName")
@segment("databases")
"name": string;
}



@armResourceOperations
interface RedisEnterpriseDatabases {
@doc("Gets information about a database in a RedisEnterprise cluster.")
get is ArmResourceRead<RedisEnterpriseDatabase>
@doc("Creates a database")
create is ArmResourceCreateOrUpdateAsync<RedisEnterpriseDatabase>
@doc("Updates a database")
update is ArmResourcePatchAsync<RedisEnterpriseDatabase,DatabaseProperties>
@doc("Deletes a single database")
delete is ArmResourceDeleteAsync<RedisEnterpriseDatabase>
@doc("Gets all databases in the specified RedisEnterprise cluster.")
listByCluster is ArmResourceListByParent<RedisEnterpriseDatabase>
@doc("Retrieves the access keys for the RedisEnterprise database.")
listKeys is ArmResourceActionSync<RedisEnterpriseDatabase,void,AccessKeys>
@doc("Regenerates the RedisEnterprise database's access keys.")
regenerateKey is ArmResourceActionAsync<RedisEnterpriseDatabase,RegenerateKeyParameters,AccessKeys>
@doc("Imports database files to target database.")
import is ArmResourceActionAsync<RedisEnterpriseDatabase,ImportClusterParameters,void>
@doc("Exports a database file from target database.")
export is ArmResourceActionAsync<RedisEnterpriseDatabase,ExportClusterParameters,void>
@doc("Forcibly removes the link to the specified database resource.")
forceUnlink is ArmResourceActionAsync<RedisEnterpriseDatabase,ForceUnlinkParameters,void>
@doc("Flushes all the keys in this database and also from its linked databases.")
flush is ArmResourceActionAsync<RedisEnterpriseDatabase,FlushParameters,void>
}