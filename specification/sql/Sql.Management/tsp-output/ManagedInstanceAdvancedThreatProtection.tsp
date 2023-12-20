import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("A managed instance Advanced Threat Protection.")
@parentResource(ManagedInstance)
model ManagedInstanceAdvancedThreatProtection
  is ProxyResource<AdvancedThreatProtectionProperties> {
  @doc("The name of the Advanced Threat Protection state.")
  @path
  @key("advancedThreatProtectionName")
  @segment("advancedThreatProtectionSettings")
  name: AdvancedThreatProtectionName;
}

@armResourceOperations
interface ManagedInstanceAdvancedThreatProtections {
  @doc("Get a managed instance's Advanced Threat Protection state.")
  get is ArmResourceRead<ManagedInstanceAdvancedThreatProtection>;
  @doc("Creates or updates Advanced Threat Protection settings.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ManagedInstanceAdvancedThreatProtection>;
  @doc("Get the managed instance's Advanced Threat Protection settings.")
  listByInstance is ArmResourceListByParent<ManagedInstanceAdvancedThreatProtection>;
}
