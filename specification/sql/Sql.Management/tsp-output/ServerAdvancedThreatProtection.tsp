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
@doc("A server Advanced Threat Protection.")
@parentResource(SqlServer)
model ServerAdvancedThreatProtection
  is ProxyResource<AdvancedThreatProtectionProperties> {
  @doc("The name of the Advanced Threat Protection state.")
  @path
  @key("advancedThreatProtectionName")
  @segment("advancedThreatProtectionSettings")
  name: AdvancedThreatProtectionName;
}

@armResourceOperations
interface ServerAdvancedThreatProtections {
  @doc("Get a server's Advanced Threat Protection state.")
  get is ArmResourceRead<ServerAdvancedThreatProtection>;
  @doc("Creates or updates an Advanced Threat Protection state.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ServerAdvancedThreatProtection>;
  @doc("Get a list of the server's Advanced Threat Protection states.")
  listByServer is ArmResourceListByParent<ServerAdvancedThreatProtection>;
}
