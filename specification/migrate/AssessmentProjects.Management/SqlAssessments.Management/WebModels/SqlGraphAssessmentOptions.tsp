import "../Common/SqlEnums.tsp";
import "../Common/CommonModels.tsp";
import "../Normalized Contract/StandardizedContracts/CommonAssessmentPropertiesEnums.tsp";
import "../Normalized Contract/ArmModels/AzureResourceProperties.tsp";
import "../Normalized Contract/StandardizedContracts/CommonEnums.tsp";
import "../Normalized Contract/Enums/Enums.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("SQL Assessment REST resource.")
@parentResource(AssessmentProject)
model SqlGraphAssessmentOptions
  is ProxyResource<SqlGraphAssessmentOptionsProperties> {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "Singleton resource"
  @doc("SQL Assessment options.")
  @key("assessmentOptionsName")
  @segment("sqlAssessmentOptions")
  @path
  name: "default";
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Doesn't have a PUT and hence no need for provisioning state. It is always hydrated by the service."
@doc("The properties of the assessment options.")
model SqlGraphAssessmentOptionsProperties {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Singleton resource"
  @doc("Gets or sets the edges.")
  edges: Record<SqlAssessmentOptionsOutboundEdgeGroup>;
}

@doc("A class that represents the outbound edges from a given node.")
model SqlAssessmentOptionsOutboundEdgeGroup
  is AssessmentOptionsOutboundEdgeGroupBase {
  @doc("Gets or sets the Azure SQL Compute tiers.")
  computeTiers: ComputeTier[];

  @doc("Gets or sets the Azure SQL Hardware generations.")
  hardwareGenerations: HardwareGeneration[];

  @doc("Gets or sets the Azure SQL target types.")
  targetTypes: TargetType[];

  @doc("Gets or sets the Azure SQL service tiers.")
  serviceTiers: AzureSqlServiceTier[];

  @doc("Gets or sets the Azure VM families.")
  azureVmFamilies: AzureVmFamily[];

  @doc("Gets or sets the Azure VM family categories.")
  azureVmFamilyCategories: VmFamilyCategoryItem[];

  @doc("Gets or sets the premium disk support.")
  premiumDiskSupport: PremiumDiskSupport[];

  @doc("Gets or sets the Azure Offer Code.")
  azureOfferCode: AzureOffer[];

  @doc("Gets or sets the Azure Offer Code.")
  azureOfferCodeForVm: AzureOffer[];
}
