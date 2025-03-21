import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";
import "@typespec/openapi";

import "./CommonResources.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

@doc("Exposure Control Resource Provider Service API.")
namespace Microsoft.Edge;

@doc("Exposure workflow manifest definition Properties")
model ExposureWorkflowManifestProperties {
  @doc("Manifest identifier expression.")
  manifestDiscriminator: string;

  @doc("Overrides default start ring.")
  overrideDefaultStartRing?: string;

  @Azure.ResourceManager.identifiers(#["ringName"])
  @doc("ring configuration properties.")
  ringConfigurations: Array<RingConfigurationProperties>;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@parentResource(ExposureFeature)
@doc("A exposure control manifest resource")
model ExposureWorkflowManifest
  is ProxyResource<ExposureWorkflowManifestProperties> {
  @doc("Name of exposure control manifest")
  @pattern("^[-\\w\\._]+$")
  @key("exposureWorkflowManifestName")
  @path
  @segment("exposureWorkflowManifests")
  name: string;
}

@doc("Configuration for Ring Progression.")
model ProgressionSetting {
  @doc("Different types of progression method supported.")
  method: ProgressionMethod;

  @doc("Ring progression Gate Status.")
  gateStatus: GateStatus;

  @doc("Specifies the next ring to be transitioned on success.")
  onSuccessRing: string;

  @doc("Specifies the next ring to be transitioned on failure.")
  onFailureRing: string;
}

@doc("Ring progression method.")
model ProgressionMethod {
  @doc("Operation type.")
  operationType: ProgressionType;

  @doc("Gate delay.")
  gateDelay: duration;

  @doc("Defines interval for status polling.")
  statusPollingInterval: duration;
}

@doc("Progression type enum.")
union ProgressionType {
  string,

  @doc("Fixed time based progression.")
  TimeBased: "TimeBased",

  @doc("Custom defined progression.")
  Custom: "Custom",
}

@doc("Progression Gate status enum.")
union GateStatus {
  string,

  @doc("Gate status Open when ring is started/active.")
  Open: "Open",

  @doc("Gate status Closed when ring is completed.")
  Closed: "Closed",
}

@doc("Ring configuration Properties")
model RingConfigurationProperties {
  @doc("unique ring identifier.")
  ringName: string;

  @doc("Exposure Group ARM Id's.")
  exposureGroupResourceIds: Array<string>;

  @doc("Ring status.")
  status: RingStatus;

  @doc("Ring Progression settings.")
  progressionSetting: ProgressionSetting;
}
