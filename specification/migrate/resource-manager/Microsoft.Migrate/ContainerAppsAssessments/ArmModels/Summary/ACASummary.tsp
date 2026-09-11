import "../../Common/StandardizedContracts/SummaryProperties.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@doc("ARM model of Azure Container Apps Summary.")
@parentResource(ContainerAppsAssessment)
model ContainerAppsSummary is ProxyResource<ContainerAppsSummaryProperties> {
  @doc("Azure Container Apps Assessment Summary Name.")
  @segment("summaries")
  @key("summaryName")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  @visibility(Lifecycle.Read)
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Summary property doesn't have a PUT and hence no need for provisioning state. It is always hydrated by the service."
@doc("Azure Container Apps Summary Properties.")
model ContainerAppsSummaryProperties is SummaryProperties {
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
