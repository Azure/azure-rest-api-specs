import "../../Common/StandardizedContracts/AssessmentProperties.tsp";
import "../../Common/StandardizedContracts/CommonAssessmentPropertiesEnums.tsp";
import "../Common/AvsEnums.tsp";
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
@doc("AVS assessment V2 resource.")
@parentResource(AssessmentProject)
model AvsAssessmentV2 is ProxyResource<AvsAssessmentPropertiesV2> {
  @doc("AVS Assessment ARM name")
  @key("assessmentName")
  @segment("avsAssessments")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

model AvsAssessmentPropertiesV2
  is AssessmentProperties<Scope, AvsAssessmentSettings, AssessmentDetails> {
  @doc("Gets or sets the machine assessment ARM ID for VM fallback.")
  fallbackMachineAssessmentArmId?: string;
}

@doc("Properties of the AVS assessment.")
model AvsAssessmentSettings is AssessmentSettings {
  @doc("List of Failures to tolerate and RAID levels in a common property.")
  failuresToTolerateAndRaidLevelList?: FttAndRaidLevel[];

  @doc("VCPU over subscription.")
  vcpuOversubscription?: float32;

  @doc("AVS node types.")
  nodeTypes?: AzureAvsNodeType[];

  @doc("AVS Assessment Scenario.")
  avsAssessmentScenario?: AvsAssessmentScenario;

  @doc("List of AVS external storage types.")
  externalStorageTypes?: ExternalStorageType[];

  @doc("Gets or sets the CPU headroom.")
  cpuHeadroom?: float32;

  @doc("Is VCF license applied")
  isVcfByolEnabled?: boolean;

  @doc("Memory overcommit.")
  memOvercommit?: float32;

  @doc("De-duplication compression.")
  dedupeCompression?: float32;

  @doc("Is Stretch Cluster Enabled.")
  isStretchClusterEnabled?: boolean;
}
