import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedDatabase.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Sql;
@doc("A managed database transparent data encryption state.")
@parentResource(ManagedDatabase)
model ManagedTransparentDataEncryption
  is ProxyResource<ManagedTransparentDataEncryptionProperties> {
  @doc("The name of the transparent data encryption configuration.")
  @key("tdeName")
  @segment("transparentDataEncryption")
  name: TransparentDataEncryptionName;
}

@armResourceOperations
@projectedName("client", "ManagedDatabaseTransparentDataEncryption")
interface ManagedTransparentDataEncryptions_ManagedDatabaseTransparentDataEncryption {
  @doc("Gets a managed database's transparent data encryption.")
  get is ArmResourceRead<ManagedTransparentDataEncryption>;

  @doc("Updates a database's transparent data encryption configuration.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ManagedTransparentDataEncryption>;

  @doc("Gets a list of managed database's transparent data encryptions.")
  listByDatabase is ArmResourceListByParent<ManagedTransparentDataEncryption>;
}
