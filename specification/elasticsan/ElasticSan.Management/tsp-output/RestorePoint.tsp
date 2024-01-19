import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
@doc("Database restore points.")
@parentResource(Database)
model RestorePoint is ProxyResource<RestorePointProperties> {
  @doc("The name of the restore point.")
  @path
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
