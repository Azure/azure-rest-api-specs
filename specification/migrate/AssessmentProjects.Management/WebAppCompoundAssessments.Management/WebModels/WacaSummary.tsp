import "../../Common/StandardizedContracts/SummaryProperties.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("WebApp compound assessment summary resource.")
@parentResource(CompoundAssessment)
model WebAppCompoundAssessmentSummary
  is ProxyResource<WebAppCompoundAssessmentSummaryProperties> {
  @doc("Gets the Name of the WebApp compound assessment summary.")
  @key("summaryName")
  @segment("summaries")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Doesn't have a PUT and hence no need for provisioning state. It is always hydrated by the service."
@doc("WebApp compound assessment summary properties class.")
model WebAppCompoundAssessmentSummaryProperties is SummaryProperties {
  @doc("Name of the assessment.")
  assessmentName?: string;

  @doc("Light summary of the compound assessment.")
  discoveredLightSummary?: DiscoveredLightSummary;
}

@doc("Summary of the compound assessment.")
model DiscoveredLightSummary {
  @doc("Number of web apps.")
  numberOfWebApps: int32;

  @doc("Number of web apps per type.")
  @extension("x-ms-identifiers", #[])
  numberOfWebAppsPerType?: WebAppsPerType[];

  @doc("Number of web servers per type.")
  @extension("x-ms-identifiers", #[])
  numberOfWebServersPerType?: WebServersPerType[];

  @doc("Number of web servers.")
  numberOfWebServers: int32;

  @doc("Number of servers.")
  numberOfServers: int32;
}

@doc("Number of web servers per type.")
model WebServersPerType {
  @doc("Name of the web app type.")
  webServerType: WebServerType;

  @doc("Count of the web app type.")
  count: int32;
}

@doc("Number of web apps per type.")
model WebAppsPerType {
  @doc("Name of the web app type.")
  webAppType: WebAppType;

  @doc("Count of the web app type.")
  count: int32;
}
