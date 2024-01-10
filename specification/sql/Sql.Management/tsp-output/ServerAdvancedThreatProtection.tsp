import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Sql;
@doc("A server Advanced Threat Protection.")
@parentResource(Server)
model ServerAdvancedThreatProtection
  is ProxyResource<AdvancedThreatProtectionProperties> {
  @doc("The name of the Advanced Threat Protection state.")
  @key("advancedThreatProtectionName")
  @segment("advancedThreatProtectionSettings")
  name: AdvancedThreatProtectionName;
}

@armResourceOperations
@projectedName("client", "ServerAdvancedThreatProtectionSettings")
interface ServerAdvancedThreatProtections_ServerAdvancedThreatProtectionSettings {
  @doc("Get a server's Advanced Threat Protection state.")
  get is ArmResourceRead<ServerAdvancedThreatProtection>;

  @doc("Creates or updates an Advanced Threat Protection state.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ServerAdvancedThreatProtection>;

  @doc("Get a list of the server's Advanced Threat Protection states.")
  listByServer is ArmResourceListByParent<ServerAdvancedThreatProtection>;
}
