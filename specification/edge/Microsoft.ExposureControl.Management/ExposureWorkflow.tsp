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

  @doc("Feature Name.")
  @visibility("read")
  exposureFeatureId: string;

  @doc("Workflow descriminator.")
  discriminator: string;

  @doc("Workflow manifest Id.")
  @visibility("read")
  exposureWorkflowManifestId: string;

  @doc("Ring configuration details.")
  @visibility("read")
  rings: Array<ExposureWorkflowRingConfigurationProperties>;

  @doc("Default start Ring.")
  @visibility("read")
  overrideDefaultStartRing: string;

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