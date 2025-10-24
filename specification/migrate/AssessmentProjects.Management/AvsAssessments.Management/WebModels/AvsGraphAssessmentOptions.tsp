import "../Normalized Contract/StandardizedContracts/CommonModels.tsp";
import "../Normalized Contract/StandardizedContracts/SummaryProperties.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("AVS Assessment Summary REST resource.")
@parentResource(AssessmentProject)
model AvsGraphAssessmentOptions
  is ProxyResource<AvsGraphAssessmentOptionsProperties> {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "Singleton resource"
  @doc("AVS Assessment Options")
  @key("assessmentOptionsName")
  @segment("avsAssessmentOptions")
  @path
  name: "default";
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Doesn't have a PUT and hence no need for provisioning state. It is always hydrated by the service."
@doc("The properties of the assessment options.")
model AvsGraphAssessmentOptionsProperties {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Singleton resource"
  @doc("Gets or sets the edges.")
  edges: Record<AvsAssessmentOptionsOutboundEdgeGroup>;
}

@doc("A class that represents the outbound edges from a given node.")
model AvsAssessmentOptionsOutboundEdgeGroup
  is AssessmentOptionsOutboundEdgeGroupBase {
  @doc("Gets or sets the Avs External Storage Type.")
  avsExternalStorageTypes: ExternalStorageType[];

  @doc("Gets or sets the Azure Avs Node Type.")
  avsNodes: AzureAvsNodeType[];

  @doc("Gets or sets the Azure SQL service tiers.")
  failuresToTolerateAndRaidLevelValues: FttAndRaidLevel[];
}
