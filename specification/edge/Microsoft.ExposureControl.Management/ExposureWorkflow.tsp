import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";
import "@typespec/openapi";

import "./CommonResources.tsp";
import "./ExposureWorkflowManifest.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

@doc("Exposure Control Resource Provider Service API.")
namespace Microsoft.Edge;

@parentResource(ExposureFeature)
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
  @doc("Workflow manifest identifier expression.")
  manifestDiscriminator: string;

  @doc("Workflow manifest Id.")
  exposureWorkflowManifestId?: string;

  @extension("x-ms-identifiers", ["ringName"])
  @doc("Ring configuration details.")
  @visibility("read")
  rings: Array<ExposureWorkflowRingConfigurationProperties>;

  @doc("overrides default start Ring.")
  overrideDefaultStartRing?: string;

  @doc("Exposure workflow current ring status.")
  currentRingStatus?: RingStatus;

  @doc("Exposure workflow status.")
  @visibility("read")
  workflowStatus: ExposureWorkflowStatus;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("Exposure Workflow Status")
union ExposureWorkflowStatus {
  string,

  @doc("Workflow status is waiting.")
  Waiting: "Waiting",

  @doc("Workflow started or in-progress.")
  Active: "Active",

  @doc("Workflow reached completion successfully.")
  Succeeded: "Succeeded",

  @doc("Workflow is cancelled.")
  Cancelled: "Cancelled",

  @doc("workflow reached completion with Failed status.")
  Failed: "Failed",
}

@doc("Exposure workflow ring configuration Properties")
model ExposureWorkflowRingConfigurationProperties {
  @doc("Unique ring identifier.")
  @visibility("read")
  ringName: string;

  @extension("x-ms-identifiers", [])
  @doc("Exposure Group Properties.")
  @visibility("read")
  exposureGroupProperties: Array<ExposureGroupProperties>;

  @doc("Ring status.")
  status: RingStatus;

  @doc("Number of retries attempted. Retry policy is service configured")
  @visibility("read")
  retryAttempts: int32;

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
