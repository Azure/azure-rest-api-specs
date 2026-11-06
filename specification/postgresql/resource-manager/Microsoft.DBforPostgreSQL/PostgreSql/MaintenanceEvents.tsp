import "./Server.tsp";
import "./shared.tsp";
import "@typespec/versioning";
import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Versioning;
using Azure.Core;

namespace Microsoft.DBforPostgreSQL;

@doc("The status of a maintenance event.")
@added(Versions.v2026_04_01)
union MaintenanceEventStatus {
  string,

  @doc("The maintenance event is scheduled and has not yet started.")
  Planned: "Planned",

  @doc("The maintenance event is currently in progress.")
  InProgress: "InProgress",

  @doc("The maintenance event has completed successfully.")
  Complete: "Complete",

  @doc("The maintenance event has been rescheduled (postponed) by the customer.")
  Rescheduled: "Rescheduled",

  @doc("The maintenance event was canceled, failed, or timed out.")
  Canceled: "Canceled",
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Maintenance events are read-only resources that do not have a provisioning lifecycle."
@doc("Properties of a maintenance event resource.")
@added(Versions.v2026_04_01)
model MaintenanceEventResourceProperties {
  @doc("A service-generated identifier for this maintenance event, assigned by the platform (e.g., 'YL1T-HFG'). The format is not contractual and clients should not attempt to parse or construct this value.")
  @visibility(Lifecycle.Read)
  maintenanceEventId?: string;

  @doc("The maintenance type (e.g., 'PlannedMaintenance').")
  @visibility(Lifecycle.Read)
  maintenanceType: MaintenanceType;

  @doc("The human-readable description of the maintenance event.")
  @visibility(Lifecycle.Read)
  description?: string;

  @doc("The customer-facing status of the maintenance event.")
  @visibility(Lifecycle.Read)
  status: MaintenanceEventStatus;

  @doc("The scheduled start time of the maintenance event (UTC).")
  @visibility(Lifecycle.Read)
  startTime: utcDateTime;

  @doc("The scheduled end time of the maintenance event (UTC).")
  @visibility(Lifecycle.Read)
  endTime: utcDateTime;

  @doc("The estimated downtime as an ISO 8601 duration string (e.g., 'PT60S' = 60 seconds).")
  @visibility(Lifecycle.Read)
  estimatedDowntime?: string;

  @doc("A value indicating whether this maintenance event can be rescheduled by the customer.")
  @visibility(Lifecycle.Read)
  deferrable: boolean;

  @doc("The latest date/time this maintenance event can be postponed to (UTC). Present only when deferrable is true.")
  @visibility(Lifecycle.Read)
  deferralDeadline?: utcDateTime;

  @doc("The previous scheduled start time before the most recent reschedule (UTC). Null if the event has never been rescheduled.")
  @visibility(Lifecycle.Read)
  rescheduledFrom?: utcDateTime;

  @doc("The time this maintenance event record was last updated (UTC).")
  @visibility(Lifecycle.Read)
  lastUpdatedTime?: utcDateTime;

  @doc("The initial scheduled start time before any reschedule (UTC). Equals startTime when the event has never been rescheduled.")
  @visibility(Lifecycle.Read)
  originalStartTime: utcDateTime;
}

@doc("Type of a maintenance event resource.")
@added(Versions.v2026_04_01)
union MaintenanceType {
  string,

  @doc("Planned maintenance event.")
  PlannedMaintenance: "PlannedMaintenance",
}

@doc("Maintenance event resource for a PostgreSQL flexible server.")
@parentResource(Server)
@added(Versions.v2026_04_01)
model MaintenanceEventResource
  is Azure.ResourceManager.ProxyResource<MaintenanceEventResourceProperties> {
  ...ResourceNameParameter<
    MaintenanceEventResource,
    KeyName = "maintenanceEventId",
    SegmentName = "maintenanceEvents",
    NamePattern = "^[A-Z0-9]{4}-[A-Z0-9]{3}$"
  >;
}

@doc("Filter for maintenance event status.")
@added(Versions.v2026_04_01)
union MaintenanceEventStatusFilter {
  string,

  @doc("Return events that have a scheduled or in progress status.")
  Upcoming: "Upcoming",

  @doc("Return events that have a completed status.")
  Past: "Past",
}

@doc("Parameters to reschedule a maintenance event.")
@added(Versions.v2026_04_01)
model MaintenanceEventRescheduleRequest {
  @doc("New start time in RFC3339 format.")
  postponeToDateTime: utcDateTime;
}

@doc("Response model for maintenance event reschedule and apply-now actions.")
@added(Versions.v2026_04_01)
model MaintenanceEventActionResponse {
  @doc("The maintenance event name (maintenance ID).")
  maintenanceEventId?: string;

  @doc("The full Azure resource ID of the server.")
  serverId?: armResourceIdentifier;

  @doc("The status of the maintenance event.")
  status?: MaintenanceEventStatus;

  @doc("The planned start time of the maintenance event (UTC).")
  plannedStartTime?: utcDateTime;

  @doc("The planned end time of the maintenance event (UTC).")
  plannedEndTime?: utcDateTime;

  @doc("A value indicating whether this was an apply-now (immediate) action. True for ApplyNow; false for Reschedule.")
  appliedNow?: boolean;

  @doc("The time this maintenance event record was last updated (UTC).")
  lastUpdatedTime?: utcDateTime;
}

@doc("Maintenance event operations for PostgreSQL flexible servers.")
@armResourceOperations
@added(Versions.v2026_04_01)
interface MaintenanceEvents {
  @doc("Gets information about a maintenance event for a flexible server.")
  get is ArmResourceRead<MaintenanceEventResource>;

  @doc("Lists all maintenance events for a flexible server.")
  list is ArmResourceListByParent<
    MaintenanceEventResource,
    Parameters = {
      @doc("Filter maintenance events by status.")
      @query("maintenanceStatus")
      maintenanceStatus?: MaintenanceEventStatusFilter;
    }
  >;

  @doc("Reschedules a maintenance event to a new date and time.")
  reschedule is ArmResourceActionAsyncBase<
    MaintenanceEventResource,
    MaintenanceEventRescheduleRequest,
    | ArmResponse<MaintenanceEventActionResponse>
    | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = MaintenanceEventActionResponse> &
        Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<MaintenanceEventResource>
  >;

  @doc("Applies the maintenance event immediately.")
  applyNow is ArmResourceActionAsyncBase<
    MaintenanceEventResource,
    void,
    | ArmResponse<MaintenanceEventActionResponse>
    | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = MaintenanceEventActionResponse> &
        Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<MaintenanceEventResource>
  >;
}
