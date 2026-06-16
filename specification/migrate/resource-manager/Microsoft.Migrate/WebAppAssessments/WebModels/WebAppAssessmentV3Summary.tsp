import "../Common/StandardizedContracts/SummaryProperties.tsp";
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@doc("WebApp assessment summary resource.")
@parentResource(WebAppAssessmentV3)
model WebAppAssessmentV3Summary is ProxyResource<WebAppSummaryProperties> {
  @doc("Gets the Name of the WebApp assessment Summary.")
  @key("summaryName")
  @segment("summaries")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Summary property doesn't have a PUT and hence no need for provisioning state. It is always hydrated by the service."
@doc("WebApp assessment summary resource properties.")
model WebAppSummaryProperties is SummaryProperties {
  @doc("Light summary of the discovered entity.")
  @visibility(Lifecycle.Read)
  discoveredEntityLightSummary?: DiscoveredEntityLightSummary;
}
