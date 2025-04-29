import "../../../Common/StandardizedContracts/SummaryProperties.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("ARM model of AKS Summary.")
@parentResource(AKSAssessment)
model AKSSummary is ProxyResource<AKSSummaryProperties> {
  @doc("AKS Assessment Summary Name.")
  @segment("summaries")
  @key("summaryName")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  @visibility(Lifecycle.Read)
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Summary property doesn't have a PUT and hence no need for provisioning state. It is always hydrated by the service."
@doc("AKS Summary Properties.")
model AKSSummaryProperties is SummaryProperties {
  @doc("Gets the number of web apps.")
  @visibility(Lifecycle.Read)
  webAppCount: int32;

  @doc("Gets the number of web servers.")
  @visibility(Lifecycle.Read)
  webServerCount: int32;

  @doc("Gets the number of machines.")
  @visibility(Lifecycle.Read)
  machineCount: int32;
}
