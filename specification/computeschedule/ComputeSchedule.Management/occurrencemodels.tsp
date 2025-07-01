import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./autoactionmodels.tsp";
import "./scheduledactionmodels.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.ComputeSchedule;

@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@doc("The status of the resources")
model ResourceResultSummary {
  @doc("The error code for those resources. In case of success, code is populated with Success.")
  code: string;

  @doc("The number of resources that the code applies to.")
  count: int32;

  @doc("The error details for the resources. Not populated on success cases.")
  errorDetails?: Azure.Core.Foundations.Error;
}

@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@doc("The summarized provisioning result of an occurrence")
model OccurrenceResultSummary {
  @doc("The total number of resources that the occurrence was supposed to act on.")
  total: int32;

  @doc("The summarized status of the resources.")
  @Azure.ResourceManager.identifiers(#["code"])
  statuses: ResourceResultSummary[];
}

@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@doc("Properties for an occurrence")
model OccurrenceProperties {
  @doc("The time the occurrence is scheduled for. This value can be changed by calling the delay API")
  @visibility(Lifecycle.Read)
  @added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
  scheduledTime: utcDateTime;

  @doc("The time the occurrence is scheduled for. This value can be changed by calling the delay API")
  @removed(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
  initialScheduledTime: utcDateTime;

  @doc("The result for occurrences that achieved a terminal state")
  @visibility(Lifecycle.Read)
  resultSummary: OccurrenceResultSummary;

  @doc("The aggregated provisioning state of the occurrence")
  @visibility(Lifecycle.Read)
  provisioningState?: OccurrenceState;
}

@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@parentResource(ScheduledAction)
model Occurrence is ProxyResource<OccurrenceProperties> {
  ...ResourceNameParameter<
    Occurrence,
    KeyName = "occurrenceId",
    NamePattern = "[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}"
  >;
}

@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@parentResource(Occurrence)
model OccurrenceResource is ScheduledActionResource {
  @doc("The time the occurrence is scheduled for the resource.")
  @visibility(Lifecycle.Read)
  scheduledTime: utcDateTime;

  @doc("The current state of the resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  @doc("Error details for the resource. Only populated if resource is in failed state.")
  @visibility(Lifecycle.Read)
  errorDetails?: Azure.Core.Foundations.Error;
}

@@identifiers(OccurrenceResourceListResponse.value, #[]);
@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
model OccurrenceResourceListResponse is Azure.Core.Page<OccurrenceResource>;

@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@doc("Request to ask for a delay in an occurrence, delay should be set to client local time eg (ACST) 2025-05-30T22:03:00+09:30, (PST) 2025-05-30T06:35:00-07:00")
model DelayRequest {
  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Prefer using `utcDateTime` when representing a datetime unless an offset is necessary."
  @doc("The exact time to delay the operations to")
  delay: offsetDateTime;

  @doc("The resources that should be delayed. If empty, the delay will apply to the all resources in the occurrence.")
  resourceIds: Array<ValidScheduledActionResourceId>;
}

@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
scalar ScheduledActionsId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.ComputeSchedule/scheduledActions",
    }
  ]>;

@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@doc("The properties of the occurrence extension")
model OccurrenceExtensionProperties {
  @doc("""
    The ARM Id of the resource.
    "subscriptions/{subId}/resourceGroups/{rgName}/providers/Microsoft.Compute/virtualMachines/{vmName}"
    """)
  resourceId: ValidScheduledActionResourceId;

  @doc("The desired notification settings for the specified resource.")
  @Azure.ResourceManager.identifiers(#["destination"])
  notificationSettings?: Array<NotificationProperties>;

  @doc("The time the occurrence is scheduled for the resource. Specified in UTC.")
  @visibility(Lifecycle.Read)
  scheduledTime: utcDateTime;

  @doc("The current state of the resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  @doc("Error details for the resource. Only populated if resource is in failed state.")
  @visibility(Lifecycle.Read)
  errorDetails?: Azure.Core.Foundations.Error;

  @doc("The arm identifier of the scheduled action the occurrence belongs to")
  scheduledActionId: ScheduledActionsId;
}

@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@doc("The scheduled action extension")
model OccurrenceExtensionResource
  is ExtensionResource<OccurrenceExtensionProperties> {
  ...ResourceNameParameter<
    OccurrenceProperties,
    SegmentName = "associatedOccurrences"
  >;
}
