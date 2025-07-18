import "../Common/StandardizedContracts/CommonAssessmentPropertiesEnums.tsp";
import "../Common/Enums/Enums.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("WebApp assessment resource.")
@parentResource(AssessmentProject)
model WepAppGraphAssessmentOptions
  is ProxyResource<WepAppGraphAssessmentOptionsProperties> {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "Singleton resource"
  @doc("WebApp Assessment options.")
  @key("assessmentOptionsName")
  @segment("webAppAssessmentOptions")
  @path
  name: "default";
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Doesn't have a PUT and hence no need for provisioning state. It is always hydrated by the service."
@doc("The properties of the assessment options.")
model WepAppGraphAssessmentOptionsProperties {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Singleton resource"
  @doc("Gets or sets the edges.")
  edges: Record<WepAppAssessmentOptionsOutboundEdgeGroup>;
}

@doc("A class that represents the outbound edges from a given node.")
model WepAppAssessmentOptionsOutboundEdgeGroup
  is AssessmentOptionsOutboundEdgeGroupBase {
  @doc("Gets or sets the Azure WepApp Tier.")
  webAppTier: AzureWebAppTier[];
}
