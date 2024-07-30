import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./autoactionmodels.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;

namespace Microsoft.ComputeSchedule;

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@doc("The status of the resources")
model ResourceResultSummary {
  @doc("The error code for those resources. In case of success, code is populated with Success.")
  code : string;

  @doc("The number of resources that the code applies to.")
  count : int32;

  @doc("The error details for the resources. Not populated on success cases.")
  errorDetails? : Azure.Core.Foundations.Error;
}

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@doc("The summarized provisioning result of an occurrence")
model OccurrenceResultSummary {
  @doc("The total number of resources that the occurrence was supposed to act on.")
  total : int32;

  @doc("The summarized status of the resources.")
  @OpenAPI.extension("x-ms-identifiers", ["code"])
  statuses : ResourceResultSummary[];
}

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@doc("Properties for an occurrence")
model OccurrenceProperties {
  @doc("The time the occurrence was initial scheduled for. Actual scheduled time for resources can change by calling the delay API")
  @visibility("read")
  initialScheduledTime: utcDateTime;

  @doc("The result for occurrences that achieved a terminal state")
  @visibility("read")
  resultSummary: OccurrenceResultSummary;

  @doc("The aggregated provisioning state of the occurrence")
  @visibility("read")
  provisioningState?: OccurrenceState;
}

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@parentResource(AutoAction)
model Occurrence is ProxyResource<OccurrenceProperties>{
  ...ResourceNameParameter<
  Occurrence,
  KeyName="occurrenceId",
  NamePattern="[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}",
  Type=uuid>
}

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
model OccurrenceResource is AutoActionResource {
  @doc("The time the occurrence is schedulded for the resource.")
  @visibility("read")
  scheduledTime : utcDateTime;

  @doc("The current state of the resource")
  @visibility("read")
  provisioningState? : ResourceProvisioningState;

  @doc("Error details for the resource. Only populated if resource is in failed state.")
  @visibility("read")
  errorDetails? : Azure.Core.Foundations.Error;
}

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@doc("Request to ask for a delay in an occurrence")
model DelayRequest {
  @doc("The amount of delay the occurrence should have")
  delay : duration;

  @doc("The resources that should be delayed. If empty, the delay will apply to the whole occurrence.")
  @OpenAPI.extension("x-ms-identifiers", ["resourceId"])
  resources : OccurrenceResource[];
}