import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SqlDatabase.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("Database restore points.")
@parentResource(SqlDatabase)
model SqlServerDatabaseRestorePoint is ProxyResource<RestorePointProperties> {
  @doc("The name of the restore point.")
  @path
  @key("restorePointName")
  @segment("restorePoints")
  name: string;
}

@armResourceOperations
interface SqlServerDatabaseRestorePoints {
  @doc("Gets a restore point.")
  get is ArmResourceRead<SqlServerDatabaseRestorePoint>;
  @doc("Deletes a restore point.")
  delete is ArmResourceDeleteSync<SqlServerDatabaseRestorePoint>;
  @doc("Gets a list of database restore points.")
  listByDatabase is ArmResourceListByParent<SqlServerDatabaseRestorePoint>;
}
