import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("A logical database transparent data encryption state.")
@parentResource(Database)
model LogicalDatabaseTransparentDataEncryption
  is ProxyResource<TransparentDataEncryptionProperties> {
  @doc("The name of the transparent data encryption configuration.")
  @path
  @key("tdeName")
  @segment("transparentDataEncryption")
  name: TransparentDataEncryptionName;
}

@armResourceOperations
interface TransparentDataEncryptions {
  @doc("Gets a logical database's transparent data encryption.")
  get is ArmResourceRead<LogicalDatabaseTransparentDataEncryption>;
  @doc("Updates a logical database's transparent data encryption configuration.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LogicalDatabaseTransparentDataEncryption>;
  @doc("Gets a list of the logical database's transparent data encryption.")
  listByDatabase is ArmResourceListByParent<LogicalDatabaseTransparentDataEncryption>;
}
