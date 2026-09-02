import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.HorizonDb;

@added(Versions.v2026_10_01)
@doc("Represents a maintenance event for a HorizonDB pool.")
@parentResource(Pool)
model MaintenanceEvent
  is Azure.ResourceManager.ProxyResource<MaintenanceEventProperties> {
  @doc("The identifier of the maintenance event.")
  @pattern("^[A-Z0-9]{4}-[A-Z0-9]{3}$")
  @minLength(8)
  @maxLength(8)
  @key("maintenanceEventId")
  @path
  @segment("maintenanceEvents")
  name: string;
}

@added(Versions.v2026_10_01)
@doc("The scheduled maintenance configuration for a HorizonDB pool.")
@discriminator("maintenanceManagementType")
model ScheduledMaintenanceProperties {
  @doc("Specifies whether scheduled maintenance is managed by the system or by the user.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  maintenanceManagementType: ScheduledMaintenanceManagementType;
}

@added(Versions.v2026_10_01)
@doc("The system-managed scheduled maintenance configuration for a HorizonDB pool. User-managed schedule properties must be absent.")
model SystemScheduledMaintenanceProperties
  extends ScheduledMaintenanceProperties {
  @added(Versions.v2026_10_01)
  @doc("Specifies that scheduled maintenance is managed by the system.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  maintenanceManagementType: "System";
}

@added(Versions.v2026_10_01)
@doc("The user-managed weekly scheduled maintenance configuration for a HorizonDB pool.")
model UserScheduledMaintenanceProperties
  extends ScheduledMaintenanceProperties {
  @added(Versions.v2026_10_01)
  @doc("Specifies that scheduled maintenance is managed by the user.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  maintenanceManagementType: "User";

  @added(Versions.v2026_10_01)
  @doc("The day of the week on which user-managed maintenance starts.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  dayOfWeek: ScheduledMaintenanceDayOfWeek;

  @added(Versions.v2026_10_01)
  @minValue(0)
  @maxValue(23)
  @doc("The hour, in UTC, at which user-managed maintenance starts. Valid values range from 0 through 23.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  startHourUtc: int32;

  @added(Versions.v2026_10_01)
  @minValue(0)
  @maxValue(59)
  @doc("The minute, in UTC, at which user-managed maintenance starts. Valid values range from 0 through 59.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  startMinuteUtc: int32;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Maintenance events are read-only resources that do not have a provisioning lifecycle."
@added(Versions.v2026_10_01)
@doc("Properties of a maintenance event resource.")
model MaintenanceEventProperties {
  @doc("A service-generated identifier for this maintenance event, assigned by the platform. The format is not contractual, and clients should not attempt to parse or construct this value.")
  @visibility(Lifecycle.Read)
  maintenanceEventId?: string;

  @doc("The maintenance type.")
  @visibility(Lifecycle.Read)
  maintenanceType: MaintenanceType;

  @doc("The human-readable description of the maintenance event.")
  @visibility(Lifecycle.Read)
  description?: string;

  @doc("The customer-facing status of the maintenance event.")
  @visibility(Lifecycle.Read)
  status: MaintenanceEventStatus;

  @doc("The scheduled start time of the maintenance event in UTC.")
  @visibility(Lifecycle.Read)
  startTimeUtc: utcDateTime;

  @doc("The scheduled end time of the maintenance event in UTC.")
  @visibility(Lifecycle.Read)
  endTimeUtc: utcDateTime;

  @doc("The estimated downtime as an ISO 8601 duration string, for example, 'PT60S' for 60 seconds.")
  @visibility(Lifecycle.Read)
  estimatedDowntime?: string;

  @doc("Indicates whether the customer can reschedule this maintenance event.")
  @visibility(Lifecycle.Read)
  deferrable: boolean;

  @doc("The latest date and time to which this maintenance event can be postponed, in UTC. This property is present only when deferrable is true.")
  @visibility(Lifecycle.Read)
  deferralDeadlineUtc?: utcDateTime;

  @doc("The scheduled start time before the most recent reschedule, in UTC. This property is absent if the event has never been rescheduled.")
  @visibility(Lifecycle.Read)
  rescheduledFromUtc?: utcDateTime;

  @doc("The time when this maintenance event record was last updated, in UTC.")
  @visibility(Lifecycle.Read)
  lastUpdatedTimeUtc?: utcDateTime;

  @doc("The initially scheduled start time before any reschedule, in UTC. This value equals startTimeUtc when the event has never been rescheduled.")
  @visibility(Lifecycle.Read)
  originalStartTimeUtc: utcDateTime;
}

@added(Versions.v2026_10_01)
@doc("Parameters for rescheduling a maintenance event.")
model MaintenanceEventRescheduleRequest {
  @doc("The new start time in RFC 3339 format.")
  postponeToDateTimeUtc: utcDateTime;
}

@added(Versions.v2026_10_01)
@doc("The response from a maintenance event reschedule or apply-now action.")
model MaintenanceEventActionResponse {
  @doc("The maintenance event identifier.")
  maintenanceEventId?: string;

  @doc("The full Azure resource ID of the HorizonDB pool.")
  poolResourceId?: armResourceIdentifier<[
    {
      type: "Microsoft.HorizonDb/clusters/pools";
    }
  ]>;

  @doc("The status of the maintenance event.")
  status?: MaintenanceEventStatus;

  @doc("The planned start time of the maintenance event in UTC.")
  plannedStartTimeUtc?: utcDateTime;

  @doc("The planned end time of the maintenance event in UTC.")
  plannedEndTimeUtc?: utcDateTime;

  @doc("Indicates whether the maintenance event was requested to be applied immediately. The value is true for apply-now and false for reschedule.")
  appliedNow?: boolean;

  @doc("The time when this maintenance event record was last updated, in UTC.")
  lastUpdatedTimeUtc?: utcDateTime;
}

@added(Versions.v2026_10_01)
@doc("Specifies who manages scheduled maintenance for a HorizonDB pool.")
union ScheduledMaintenanceManagementType {
  string,

  /** Scheduled maintenance is managed by the system. */
  System: "System",

  /** Scheduled maintenance is managed by the user. */
  User: "User",
}

@added(Versions.v2026_10_01)
@doc("The day of the week for user-managed scheduled maintenance.")
union ScheduledMaintenanceDayOfWeek {
  string,

  /** Sunday. */
  Sunday: "Sunday",

  /** Monday. */
  Monday: "Monday",

  /** Tuesday. */
  Tuesday: "Tuesday",

  /** Wednesday. */
  Wednesday: "Wednesday",

  /** Thursday. */
  Thursday: "Thursday",

  /** Friday. */
  Friday: "Friday",

  /** Saturday. */
  Saturday: "Saturday",
}

@added(Versions.v2026_10_01)
@doc("The status of a maintenance event.")
union MaintenanceEventStatus {
  string,

  /** The maintenance event is scheduled and has not yet started. */
  Planned: "Planned",

  /** The maintenance event is currently in progress. */
  InProgress: "InProgress",

  /** The maintenance event completed successfully. */
  Complete: "Complete",

  /** The customer rescheduled the maintenance event. */
  Rescheduled: "Rescheduled",

  /** The maintenance event was canceled, failed, or timed out. */
  Canceled: "Canceled",
}

@added(Versions.v2026_10_01)
@doc("The type of a maintenance event.")
union MaintenanceType {
  string,

  /** A planned maintenance event. */
  PlannedMaintenance: "PlannedMaintenance",
}

@added(Versions.v2026_10_01)
@doc("A filter for maintenance event status.")
union MaintenanceEventStatusFilter {
  string,

  /** Return events that have a scheduled or in-progress status. */
  Upcoming: "Upcoming",

  /** Return events that have a completed status. */
  Past: "Past",
}

@added(Versions.v2026_10_01)
@doc("Maintenance event operations for HorizonDB pools.")
@armResourceOperations
interface MaintenanceEvents {
  @doc("Gets information about a maintenance event for a HorizonDB pool.")
  get is ArmResourceRead<MaintenanceEvent>;

  @doc("Lists maintenance events for a HorizonDB pool.")
  list is ArmResourceListByParent<
    MaintenanceEvent,
    Parameters = {
      @doc("Filters maintenance events by status.")
      @query("maintenanceStatus")
      maintenanceStatus?: MaintenanceEventStatusFilter;
    }
  >;

  @doc("Reschedules a maintenance event to a new date and time.")
  reschedule is ArmResourceActionAsyncBase<
    MaintenanceEvent,
    MaintenanceEventRescheduleRequest,
    | ArmResponse<MaintenanceEventActionResponse>
    | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = MaintenanceEventActionResponse> &
        Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<MaintenanceEvent>
  >;

  @doc("Applies the maintenance event immediately.")
  applyNow is ArmResourceActionAsyncBase<
    MaintenanceEvent,
    void,
    | ArmResponse<MaintenanceEventActionResponse>
    | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = MaintenanceEventActionResponse> &
        Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<MaintenanceEvent>
  >;
}
