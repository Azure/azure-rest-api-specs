import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("Server-level Automatic Tuning.")
@singleton("current")
@parentResource(Server)
model ServerAutomaticTuning is ProxyResource<AutomaticTuningServerProperties> {
  @key("current")
  @segment("automaticTuning")
  name: string;
}

@armResourceOperations
interface ServerAutomaticTuning {
  @doc("Retrieves server automatic tuning options.")
  get is ArmResourceRead<ServerAutomaticTuning>;
  @doc("Update automatic tuning options on server.")
  update is ArmCustomPatchSync<ServerAutomaticTuning, ServerAutomaticTuning>;
}
