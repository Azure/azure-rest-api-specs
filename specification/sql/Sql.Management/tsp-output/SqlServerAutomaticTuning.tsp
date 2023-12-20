import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SqlServer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("Server-level Automatic Tuning.")
@parentResource(SqlServer)
@singleton("current")
model SqlServerAutomaticTuning
  is ProxyResource<AutomaticTuningServerProperties> {
  @key("current")
  @segment("automaticTuning")
  name: string;
}

@armResourceOperations
interface SqlServerAutomaticTunings {
  @doc("Retrieves server automatic tuning options.")
  get is ArmResourceRead<SqlServerAutomaticTuning>;
  @doc("Update automatic tuning options on server.")
  update is ArmResourcePatchSync<
    SqlServerAutomaticTuning,
    AutomaticTuningServerProperties
  >;
}
