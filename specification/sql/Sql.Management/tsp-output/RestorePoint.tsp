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
@doc("Database restore points.")
@parentResource(Database)
model RestorePoint is ProxyResource<RestorePointProperties> {
  @doc("The name of the restore point.")
  @key("restorePointName")
  @segment("restorePoints")
  name: string;
}

@armResourceOperations
interface RestorePoints {
  @doc("Gets a restore point.")
  get is ArmResourceRead<RestorePoint>;
  @doc("Deletes a restore point.")
  delete is ArmResourceDeleteSync<RestorePoint>;
  @doc("Gets a list of database restore points.")
  listByDatabase is ArmResourceListByParent<RestorePoint>;
}
