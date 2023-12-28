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
@doc("Database-level Automatic Tuning.")
@singleton("current")
@parentResource(Database)
model DatabaseAutomaticTuning
  is ProxyResource<DatabaseAutomaticTuningProperties> {
  @key("current")
  @segment("automaticTuning")
  name: string;
}

@armResourceOperations
interface DatabaseAutomaticTuning {
  @doc("Gets a database's automatic tuning.")
  get is ArmResourceRead<DatabaseAutomaticTuning>;
  @doc("Update automatic tuning properties for target database.")
  update is ArmCustomPatchSync<
    DatabaseAutomaticTuning,
    DatabaseAutomaticTuning
  >;
}
