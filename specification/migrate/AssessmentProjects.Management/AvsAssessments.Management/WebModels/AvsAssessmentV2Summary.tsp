import "../../Common/StandardizedContracts/CommonModels.tsp";
import "../../Common/StandardizedContracts/SummaryProperties.tsp";
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;
namespace Microsoft.Migrate;

@doc("AVS Assessment Summary REST resource.")
@parentResource(AvsAssessmentV2)
model AvsAssessmentV2Summary
  is ProxyResource<AvsAssessmentSummaryPropertiesV2> {
  @doc("Gets the Name of the AVS Assessment Summary.")
  @key("summaryName")
  @segment("summaries")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@doc("Properties of the Machine Assessment V2 Summary.")
model AvsAssessmentSummaryPropertiesV2 is SummaryProperties {
  @doc("Gets or sets the Assessment cloud suitability.")
  @visibility(Lifecycle.Read)
  suitability?: CloudSuitability;

  @doc("Gets or sets the Assessment suitability explanation.")
  @visibility(Lifecycle.Read)
  suitabilityExplanation?: AzureAvsSuitabilityExplanation;

  @doc("Recommended number of nodes.")
  @visibility(Lifecycle.Read)
  numberOfNodes?: int32;

  @doc("Predicted CPU utilization.")
  @visibility(Lifecycle.Read)
  cpuUtilization?: float32;

  @doc("Predicted RAM utilization.")
  @visibility(Lifecycle.Read)
  ramUtilization?: float32;

  @doc("Predicted storage utilization.")
  @visibility(Lifecycle.Read)
  storageUtilization?: float32;

  @doc("Predicted total CPU cores used.")
  @visibility(Lifecycle.Read)
  totalCpuCores?: float32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Need to mention GigaBytes and hence used GB, Gb would give Gigabits"
  @doc("Predicted total RAM used in GB.")
  @visibility(Lifecycle.Read)
  totalRamInGB?: float32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Need to mention GigaBytes and hence used GB, Gb would give Gigabits"
  @doc("Predicted total Storage used in GB.")
  @visibility(Lifecycle.Read)
  totalStorageInGB?: float32;

  @doc("Estimated AVS SKU for Assessment.")
  @extension("x-ms-identifiers", #[])
  @visibility(Lifecycle.Read)
  avsEstimatedNodes?: AvsEstimatedNode[];

  @doc("Estimated External Storage for Assessment.")
  @extension("x-ms-identifiers", #[])
  @visibility(Lifecycle.Read)
  avsEstimatedExternalStorages?: AvsEstimatedExternalStorage[];

  @doc("Estimated External Storage for Assessment.")
  @extension("x-ms-identifiers", #[])
  @visibility(Lifecycle.Read)
  avsEstimatedNetworks?: AvsEstimatedNetwork[];

  @doc("Limiting factor.")
  @visibility(Lifecycle.Read)
  limitingFactor?: string;
}
