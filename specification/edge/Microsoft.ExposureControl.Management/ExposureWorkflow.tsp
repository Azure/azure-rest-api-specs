import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";

import "./CommonResources.tsp";
import "./ExposureWorkflowManifest.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@doc("Exposure Control Resource Provider Service API.")
namespace Microsoft.Edge;

@doc("A exposure workflow resource")
model ExposureWorkflow is ProxyResource<ExposureWorkflowProperties> {
  @doc("Name of Exposure Workflow")
  @pattern("^[-\\w\\._]+$")
  @key("exposureWorkflowName")
  @path
  @segment("exposureWorkflows")
  name: string;
}

@doc("Exposure workflow Properties")
model ExposureWorkflowProperties {
  @doc("Feature unique Id.")
  exposureFeatureId? : string;

  @doc("Workflow discriminator.")
  discriminator: string;

  @doc("Workflow manifest Id.")
  exposureWorkflowManifestId? : string;

  #suppress "@azure-tools/typespec-providerhub/no-identifier-property-in-array-item" "Error items have no unique identifier."
  @doc("Ring configuration details.")
  @visibility("read")
  rings: Array<ExposureWorkflowRingConfigurationProperties>;

  @doc("Default start Ring.")
  overrideDefaultStartRing? : string;

  @doc("Exposure workflow current ring status.")
  currentRingStatus? : RingStatus;

  @doc("Exposure workflow status.")
  @visibility("read")
  workflowStatus: ExposureWorkflowStatus;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("Exposure Workflow Status")
enum ExposureWorkflowStatus {
  @doc("Workflow waiting.")
  Waiting,

  @doc("Workflow active.")
  Active,

  @doc("Workflow completed.")
  Succeeded,

  @doc("Workflow cancelled.")
  Cancelled,

  @doc("workflow Failed.")
  Failed,
}

@doc("Exposure workflow ring configuration Properties")
model ExposureWorkflowRingConfigurationProperties {
  @doc("Ring name.")
  @visibility("read")
  name: string;

  #suppress "@azure-tools/typespec-providerhub/no-identifier-property-in-array-item" "Error items have no unique identifier."
  @doc("Group Properties.")
  @visibility("read")
  exposureGroupProperties: Array<ExposureGroupProperties>;

  @doc("Ring status.")
  status: RingStatus;

  @doc("Retry times.")
  @visibility("read")
  retryTimes: int32;

  @doc("Progression settings.")
  @visibility("read")
  progressionSetting: ProgressionSetting;
}

@doc("Exposure workflow update object.")
model ExposureWorkflowUpdate {
  @doc("Exposure workflow update properties")
  properties: ExposureWorkflowUpdateProperties;
}

@doc("Exposure workflow update properties")
model ExposureWorkflowUpdateProperties {
  @doc("Current Ring status")
  currentRingStatus: RingStatus;
}
