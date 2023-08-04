import "./Common/AzureResourceProperties.tsp";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("AVS Assessment options resource.")
@parentResource(AssessmentProject)
model AvsAssessmentOptions is ProxyResource<AvsAssessmentOptionsProperties> {
  @doc("AVS Assessment options ARM name. Accepted value is 'default'")
  @key("avsAssessmentOptionsName")
  @segment("avsAssessmentOptions")
  @path
  name: string;
}

@doc("AVS Assessment options properties.")
model AvsAssessmentOptionsProperties extends AzureResourceProperties {
  @doc("AVS SKU Nodes.")
  @extension("x-ms-identifiers", [])
  avsNodes?: AvsSkuOptions[];

  @doc("FTT and Raid level values.")
  failuresToTolerateAndRaidLevelValues?: FttAndRaidLevel[];

  @doc("List of AVS nodes for RI.")
  reservedInstanceAvsNodes?: AzureAvsNodeType[];

  @doc("List of supported Azure regions for reserved instances.")
  reservedInstanceSupportedLocations?: AzureLocation[];

  @doc("List of supported currencies for reserved instances.")
  reservedInstanceSupportedCurrencies?: AzureCurrency[];

  @doc("List of supported Azure offer codes for reserved instances.")
  reservedInstanceSupportedOffers?: AzureOfferCode[];
}

@doc("AVS SKU specific options.")
model AvsSkuOptions {
  @doc("AVS Node type.")
  nodeType?: AzureAvsNodeType;

  @doc("List of locations where this node type is available.")
  targetLocations?: AzureLocation[];
}
