import "../../../Common/StandardizedContracts/CommonAssessmentPropertiesEnums.tsp";
import "../../../Common/Enums/Enums.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("ARM model of AKS Assessment Options.")
@parentResource(AssessmentProject)
model AKSAssessmentOptions is ProxyResource<AKSAssessmentOptionsProperties> {
  @doc("AKS Assessment Options Name.")
  @segment("aksAssessmentOptions")
  @key("assessmentOptionsName")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  @visibility(Lifecycle.Read)
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Doesn't have a PUT and hence no need for provisioning state. It is always hydrated by the service."
@doc("AKS Assessment Options Properties.")
model AKSAssessmentOptionsProperties {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Singleton resource"
  @doc("Gets the mapping of Assessment Options in graph representation.")
  @visibility(Lifecycle.Read)
  edges: Record<AKSAssessmentOptionsOutboundEdgeGroup>;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("A class that represents the outbound edges from a given node.")
model AKSAssessmentOptionsOutboundEdgeGroup {
  @doc("Gets or sets the Azure VM Category.")
  categories: AzureVmCategory[];

  @doc("Gets or sets the Consolidation Type.")
  consolidations: ConsolidationType[];

  @doc("Gets or sets the Pricing Tier.")
  tiers: PricingTier[];

  @doc("Gets or sets the Azure Locations.")
  targetLocations: AzureLocation[];

  @doc("Gets or sets the Azure Currency.")
  currencies: AzureCurrency[];

  @doc("Gets or sets the Assessment Savings Options.")
  savingsOptions: SavingsOptions[];

  @doc("Gets or sets the Licensing Program.")
  licensingProgram: LicensingProgram[];
}
