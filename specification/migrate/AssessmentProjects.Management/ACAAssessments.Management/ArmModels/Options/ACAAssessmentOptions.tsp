import "../../Common/StandardizedContracts/CommonAssessmentPropertiesEnums.tsp";
import "../../Common/Enums/Enums.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("ARM model of ACA Assessment Options.")
@parentResource(AssessmentProject)
model ACAAssessmentOptions is ProxyResource<ACAAssessmentOptionsProperties> {
  @doc("ACA Assessment Options Name.")
  @segment("acaAssessmentOptions")
  @key("assessmentOptionsName")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  @visibility(Lifecycle.Read)
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Doesn't have a PUT and hence no need for provisioning state. It is always hydrated by the service."
@doc("ACA Assessment Options Properties.")
model ACAAssessmentOptionsProperties {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Singleton resource"
  @doc("Gets the mapping of Assessment Options in graph representation.")
  @visibility(Lifecycle.Read)
  edges: Record<ACAAssessmentOptionsOutboundEdgeGroup>;
}

@doc("A class that represents the outbound edges from a given node.")
model ACAAssessmentOptionsOutboundEdgeGroup {
  @doc("Gets or sets the Workload Profile SKU categories.")
  categories: ACAWorkloadProfileSku[];

  @doc("Gets or sets the Workload Profile Types.")
  workloadProfileTypes: ACAWorkloadProfileType[];

  @doc("Gets or sets the Pricing Tier.")
  tiers: PricingTier[];

  @doc("Gets or sets the Azure Locations.")
  targetLocations: azureLocation[];

  @doc("Gets or sets the Azure Currency.")
  currencies: AzureCurrency[];

  @doc("Gets or sets the Assessment Savings Options.")
  savingsOptions: SavingsOptions[];

  @doc("Gets or sets the Licensing Program.")
  licensingProgram: LicensingProgram[];
}
