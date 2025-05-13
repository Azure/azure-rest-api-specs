import "../../Common/StandardizedContracts/CommonAssessmentPropertiesEnums.tsp";
import "../../Common/Enums/Enums.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Machine Assessment REST resource.")
@parentResource(AssessmentProject)
model MachineGraphAssessmentOptions
  is ProxyResource<MachineGraphAssessmentOptionsProperties> {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "Singleton resource"
  @doc("Machine Assessment options.")
  @key("assessmentOptionsName")
  @segment("assessmentOptions")
  @path
  name: "default";
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Doesn't have a PUT and hence no need for provisioning state. It is always hydrated by the service."
@doc("The properties of the assessment options.")
model MachineGraphAssessmentOptionsProperties {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Singleton resource"
  @doc("Gets or sets the edges.")
  edges: Record<MachineAssessmentOptionsOutboundEdgeGroup>;
}

@doc("A class that represents the outbound edges from a given node.")
model MachineAssessmentOptionsOutboundEdgeGroup
  is AssessmentOptionsOutboundEdgeGroupBase {
  @doc("Gets or sets the Azure VM families.")
  azureVmFamilies: AzureVmFamily[];

  @doc("Gets or sets the Azure VM family categories.")
  azureVmFamilyCategories: VmFamilyCategoryItem[];

  @doc("Gets or sets the premium disk support.")
  premiumDiskSupport: PremiumDiskSupport[];

  @doc("Gets or sets the premium disk support.")
  ultraDiskSupport: UltraDiskSupport[];

  @doc("Gets or sets the Azure Offer Code.")
  azureOfferCode: AzureOffer[];

  @doc("Gets or sets the Azure VM security options.")
  azureVmSecurityOptions?: AzureVmSecurityType[];
}
