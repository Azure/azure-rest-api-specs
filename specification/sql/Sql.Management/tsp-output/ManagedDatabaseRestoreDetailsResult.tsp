import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedDatabase.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("A managed database restore details.")
@parentResource(ManagedDatabase)
model ManagedDatabaseRestoreDetailsResult
  is ProxyResource<ManagedDatabaseRestoreDetailsProperties> {
  @doc("The name of the restore details to retrieve.")
  @path
  @key("restoreDetailsName")
  @segment("restoreDetails")
  name: RestoreDetailsName;
}

@armResourceOperations
interface ManagedDatabaseRestoreDetails {
  @doc("Gets managed database restore details.")
  get is ArmResourceRead<ManagedDatabaseRestoreDetailsResult>;
}
