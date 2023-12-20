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
@doc("Database-level Automatic Tuning.")
@parentResource(SqlDatabase)
@singleton("current")
model SqlDatabaseAutomaticTuning
  is ProxyResource<DatabaseAutomaticTuningProperties> {
  @key("current")
  @segment("automaticTuning")
  name: string;
}

@armResourceOperations
interface SqlDatabaseAutomaticTunings {
  @doc("Gets a database's automatic tuning.")
  get is ArmResourceRead<SqlDatabaseAutomaticTuning>;
  @doc("Update automatic tuning properties for target database.")
  update is ArmResourcePatchSync<
    SqlDatabaseAutomaticTuning,
    DatabaseAutomaticTuningProperties
  >;
}
