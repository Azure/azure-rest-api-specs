import "../../Common/StandardizedContracts/AssessmentProperties.tsp";
import "../../Common/StandardizedContracts/CommonAssessmentPropertiesEnums.tsp";
import "../../Common/StandardizedContracts/CostComponent.tsp";
import "../../Common/StandardizedContracts/Scope.tsp";
import "../../Common/ArmModels/AzureResourceProperties.tsp";
import "../../Common/StandardizedContracts/CommonEnums.tsp";
import "../../Common/ArmModels/AssessmentProjectV2.tsp";
import "../Common/CommonModels.tsp";
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;
namespace Microsoft.Migrate;
@doc("Machine assessment V2 resource.")
@parentResource(AssessmentProject)
model MachineAssessmentV2 is ProxyResource<MachineAssessmentV2Properties> {
  @doc("Machine Assessment V2 ARM name")
  @key("assessmentName")
  @segment("assessments")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

model MachineAssessmentV2Properties
  is AssessmentProperties<Scope, MachineAssessmentSettings, AssessmentDetails>;

@doc("Properties of an assessment.")
model MachineAssessmentSettings is AssessmentSettings {
  @doc("The azure security offering type.")
  azureSecurityOfferingType?: AzureSecurityOfferingType;

  @doc("The disk type for the assessment.")
  azureDiskTypes?: AzureDiskType[];

  @doc("Gets or sets Azure Pricing Tier - Free, Basic, etc.")
  azurePricingTier?: AzurePricingTier;

  @doc("Gets or sets the Azure Storage Redundancy. Example: Locally Redundant Storage.")
  azureStorageRedundancy?: AzureStorageRedundancy;

  @doc("""
    Gets or sets the user configurable setting to display the azure hybrid use
    benefit.
    """)
  azureHybridUseBenefit?: AzureHybridUseBenefit;

  @doc("""
    Gets or sets the user configurable setting to display the linux azure hybrid use
    benefit.
    """)
  linuxAzureHybridUseBenefit?: AzureHybridUseBenefit;

  @doc("Gets or sets the Azure VM families.")
  azureVmFamilies?: AzureVmFamily[];

  @doc("""
    Gets or sets the duration for which the VMs are up in the on-premises
    environment.
    """)
  vmUptime?: VmUptime;

  @doc("Gets or sets the Azure VM security options.")
  azureVmSecurityOptions?: AzureVmSecurityType[];
}
