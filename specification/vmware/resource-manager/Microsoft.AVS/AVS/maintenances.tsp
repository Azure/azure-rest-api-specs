namespace Microsoft.AVS;

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armResourceOperations
@added(Versions.v2025_09_01)
interface Maintenances {
  @doc("List {name} resources by subscription ID", Maintenance)
  list is ArmResourceListByParent<
    Maintenance,
    Parameters = {
      @query
      @doc("Filter maintenances based on state")
      stateName?: MaintenanceStateName;

      @query
      @doc("Filter active or inactive maintenances")
      status?: MaintenanceStatusFilter;

      @query
      @doc("date from which result should be returned. ie. scheduledStartTime >= from")
      from?: utcDateTime;

      @query
      @doc("date till which result should be returned. i.e. scheduledStartTime <= to")
      to?: utcDateTime;
    },
    Response = ArmResponse<ResourceListResult<Maintenance>>
  >;
  @added(Versions.v2025_09_01)
  get is ArmResourceRead<Maintenance>;

  @doc("Reschedule a maintenance")
  reschedule is ArmResourceActionSync<
    Maintenance,
    MaintenanceReschedule,
    Maintenance
  >;

  @doc("Schedule a maintenance")
  schedule is ArmResourceActionSync<
    Maintenance,
    MaintenanceSchedule,
    Maintenance
  >;

  @doc("Initiate maintenance readiness checks")
  initiateChecks is ArmResourceActionSyncNoRequestBody<
    Maintenance,
    Maintenance
  >;
}

@doc("reschedule a maintenance")
model MaintenanceReschedule {
  @doc("reschedule time")
  rescheduleTime?: utcDateTime;

  @doc("rescheduling reason")
  message?: string;
}

@doc("schedule a maintenance")
model MaintenanceSchedule {
  @doc("schedule time")
  scheduleTime?: utcDateTime;

  @doc("scheduling message")
  message?: string;
}

@doc("A cluster resource")
@parentResource(PrivateCloud)
model Maintenance is ProxyResource<MaintenanceProperties> {
  @doc("Name of the maintenance")
  @pattern("^[-\\w\\._]+$")
  @key("maintenanceName")
  @path
  @segment("maintenances")
  name: string;
}

@doc("status filter for the maintenance")
union MaintenanceStatusFilter {
  string,

  @doc("is active")
  Active: "Active",

  @doc("is inactive")
  Inactive: "Inactive",
}

@doc("provisioning state of the maintenance")
union MaintenanceProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("is updating")
  Updating: "Updating",
}

@doc("type of the maintenance")
union MaintenanceType {
  string,

  @doc("maintenance for vCenter Server Appliance")
  VCSA: "VCSA",

  @doc("maintenance for ESXi")
  ESXI: "ESXI",

  @doc("maintenance for NSX-T")
  NSXT: "NSXT",
}

@doc("state of the maintenance")
model MaintenanceState {
  @doc("Customer presentable maintenance state")
  name?: MaintenanceStateName;

  @doc("Failure/Success info")
  message?: string;

  @doc("Time when current state started")
  startedAt?: utcDateTime;

  @doc("Time when current state ended")
  endedAt?: utcDateTime;
}

@doc("Customer presentable maintenance state")
union MaintenanceStateName {
  string,

  @doc("Maintenance Not Scheduled")
  NotScheduled: "NotScheduled",

  @doc("Maintenance Scheduled")
  Scheduled: "Scheduled",

  @doc("Maintenance In Progress")
  InProgress: "InProgress",

  @doc("Maintenance Succeeded")
  Success: "Success",

  @doc("Maintenance Failed")
  Failed: "Failed",

  @doc("Maintenance Cancelled")
  Canceled: "Canceled",
}

@doc("properties of a maintenance")
model MaintenanceProperties {
  @doc("type of maintenance")
  @visibility(Lifecycle.Read)
  component?: MaintenanceType;

  @doc("Display name for maintenance")
  @visibility(Lifecycle.Read)
  displayName?: string;

  @doc("Cluster ID for on which maintenance will be applied. Empty if maintenance is at private cloud level")
  @visibility(Lifecycle.Read)
  clusterId?: int32;

  @doc("Link to maintenance info")
  @visibility(Lifecycle.Read)
  infoLink?: string;

  @doc("Impact on the resource during maintenance period")
  @visibility(Lifecycle.Read)
  impact?: string;

  @doc("If maintenance is scheduled by Microsoft")
  @visibility(Lifecycle.Read)
  scheduledByMicrosoft?: boolean;

  @doc("The state of the maintenance")
  @visibility(Lifecycle.Read)
  state?: MaintenanceState;

  @doc("Scheduled maintenance start time")
  @visibility(Lifecycle.Read)
  scheduledStartTime?: utcDateTime;

  @doc("Estimated time maintenance will take in minutes")
  @visibility(Lifecycle.Read)
  estimatedDurationInMinutes?: int64;

  @doc("The provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: MaintenanceProvisioningState;

  @doc("Operations on  maintenance")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  operations?: MaintenanceManagementOperation[];

  @doc("Indicates whether the maintenance is ready to proceed")
  @visibility(Lifecycle.Read)
  maintenanceReadiness?: MaintenanceReadiness;
}

@doc("Reason for blocking operation on maintenance")
union BlockedDatesConstraintCategory {
  string,

  @doc("Hi-Priority Event")
  HiPriorityEvent: "HiPriorityEvent",

  @doc("Quota Exhausted")
  QuotaExhausted: "QuotaExhausted",

  @doc("Holidays")
  Holiday: "Holiday",
}

@doc("Blocked Time range Constraints for maintenance")
model BlockedDatesConstraintTimeRange {
  @doc("Start date time")
  @visibility(Lifecycle.Read)
  startsAt: utcDateTime;

  @doc("End date Time")
  @visibility(Lifecycle.Read)
  endsAt: utcDateTime;

  @doc("Reason category for blocking maintenance reschedule")
  @visibility(Lifecycle.Read)
  reason?: string;
}

@doc("Defines the type of maintenance readiness check")
union MaintenanceCheckType {
  string,

  @doc("Pre-check maintenance readiness")
  Precheck: "Precheck",

  @doc("Pre-flight maintenance readiness")
  Preflight: "Preflight",
}

@doc("Defines the readiness status of maintenance")
union MaintenanceReadinessStatus {
  string,

  @doc("The system is ready for maintenance")
  Ready: "Ready",

  @doc("The system is not ready for maintenance")
  NotReady: "NotReady",

  @doc("Data is not available to determine readiness")
  DataNotAvailable: "DataNotAvailable",

  @doc("Readiness check is not applicable")
  NotApplicable: "NotApplicable",
}

@doc("Maintenance readiness details")
model MaintenanceReadiness {
  @doc("The type of maintenance readiness check")
  @visibility(Lifecycle.Read)
  type: MaintenanceCheckType;

  @doc("The current readiness status of maintenance")
  @visibility(Lifecycle.Read)
  status: MaintenanceReadinessStatus;

  @doc("A summary message of the readiness check result")
  @visibility(Lifecycle.Read)
  message?: string;

  @doc("A list of failed checks, if any")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  failedChecks?: MaintenanceFailedCheck[];

  @doc("The timestamp of the last readiness update")
  @visibility(Lifecycle.Read)
  lastUpdated?: utcDateTime;
}

@doc("Details about a failed maintenance check")
model MaintenanceFailedCheck {
  @doc("The name of the failed check")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("A list of resources impacted by the failed check")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  impactedResources?: ImpactedMaintenanceResource[];
}

@doc("Details about a resource impacted by a failed check")
model ImpactedMaintenanceResource {
  @doc("The ID of the impacted resource")
  @visibility(Lifecycle.Read)
  id?: string;

  @doc("A list of errors associated with the impacted resource")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  errors?: ImpactedMaintenanceResourceError[];
}

@doc("Details about an error affecting a resource")
model ImpactedMaintenanceResourceError {
  @doc("The error code")
  @visibility(Lifecycle.Read)
  errorCode?: string;

  @doc("The name of the error")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("Additional details about the error")
  @visibility(Lifecycle.Read)
  details?: string;

  @doc("Steps to resolve the error")
  @visibility(Lifecycle.Read)
  resolutionSteps?: string[];

  @doc("Indicates whether action is required by the customer")
  @visibility(Lifecycle.Read)
  actionRequired?: boolean;
}

//Define constraints common across maintenance operations in section below

@doc("Time window in which Customer can schedule maintenance")
model AvailableWindowForMaintenance {
  @doc("Start date time")
  @visibility(Lifecycle.Read)
  startsAt: utcDateTime;

  @doc("End date Time")
  @visibility(Lifecycle.Read)
  endsAt: utcDateTime;
}

@doc("Time ranges blocked for operation on maintenance")
model BlockedMaintenanceWindow {
  @doc("Category of blocked date")
  @visibility(Lifecycle.Read)
  category: BlockedDatesConstraintCategory;

  @doc("Date ranges blocked for schedule")
  @visibility(Lifecycle.Read)
  @identifiers(#["startsAt", "endsAt"])
  timeRanges?: BlockedDatesConstraintTimeRange[];
}

// Define operations on maintenance in section below

@doc("Defines the type of operation")
union MaintenanceManagementOperationKind {
  string,

  @doc("Represents a scheduling operation")
  Schedule: "Schedule",

  @doc("Represents a rescheduling operation")
  Reschedule: "Reschedule",

  @doc("Represents a maintenance readiness refresh operation")
  MaintenanceReadinessRefresh: "MaintenanceReadinessRefresh",
}

@doc("Defines operations that can be performed on maintenance")
@discriminator("kind")
model MaintenanceManagementOperation {
  @doc("The kind of operation")
  @visibility(Lifecycle.Read)
  kind: MaintenanceManagementOperationKind;
}

@doc("Scheduling window constraint")
model ScheduleOperation extends MaintenanceManagementOperation {
  @doc("The kind of operation")
  kind: MaintenanceManagementOperationKind.Schedule;

  @doc("If scheduling is disabled")
  @visibility(Lifecycle.Read)
  isDisabled?: boolean;

  @doc("Reason for schedule disabled")
  @visibility(Lifecycle.Read)
  disabledReason?: string;

  @doc("Constraints for scheduling maintenance")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  constraints?: ScheduleOperationConstraint[];
}

@doc("Constraints for scheduling of maintenance")
union ScheduleOperationConstraintKind {
  string,

  @doc("Time window in which Customer has option to schedule maintenance")
  SchedulingWindow: "SchedulingWindow",

  @doc("Time window in which maintenance can be scheduled")
  AvailableWindowForMaintenanceWhileScheduleOperation: "AvailableWindowForMaintenance",

  @doc("Blocked time range constraint")
  BlockedWhileScheduleOperation: "Blocked",
}

@doc("Defines constraints for schedule operation on maintenance")
@discriminator("kind")
model ScheduleOperationConstraint {
  @doc("The kind of operation")
  @visibility(Lifecycle.Read)
  kind: ScheduleOperationConstraintKind;
}

@doc("Time window in which Customer has option to schedule maintenance")
model SchedulingWindow extends ScheduleOperationConstraint {
  @doc("The kind of constraint")
  kind: ScheduleOperationConstraintKind.SchedulingWindow;

  @doc("Start date time")
  @visibility(Lifecycle.Read)
  startsAt: utcDateTime;

  @doc("End date Time")
  @visibility(Lifecycle.Read)
  endsAt: utcDateTime;
}

@doc("Time window in which Customer can to schedule maintenance")
model AvailableWindowForMaintenanceWhileScheduleOperation
  extends ScheduleOperationConstraint {
  @doc("The kind of constraint")
  kind: ScheduleOperationConstraintKind.AvailableWindowForMaintenanceWhileScheduleOperation;

  ...AvailableWindowForMaintenance;
}

@doc("Time ranges blocked for scheduling maintenance")
model BlockedWhileScheduleOperation extends ScheduleOperationConstraint {
  @doc("The kind of constraint")
  kind: ScheduleOperationConstraintKind.BlockedWhileScheduleOperation;

  ...BlockedMaintenanceWindow;
}

@doc("Constraints for rescheduling maintenance")
model RescheduleOperation extends MaintenanceManagementOperation {
  @doc("The kind of operation")
  kind: MaintenanceManagementOperationKind.Reschedule;

  @doc("If rescheduling is disabled")
  @visibility(Lifecycle.Read)
  isDisabled?: boolean;

  @doc("Reason for reschedule disabled")
  @visibility(Lifecycle.Read)
  disabledReason?: string;

  @doc("Constraints for rescheduling maintenance")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  constraints?: RescheduleOperationConstraint[];
}

@doc("Constraints for rescheduling of maintenance")
union RescheduleOperationConstraintKind {
  string,

  @doc("Time window in which maintenance can be rescheduled")
  AvailableWindowForMaintenanceWhileRescheduleOperation: "AvailableWindowForMaintenance",

  @doc("Blocked time range constraint")
  BlockedWhileRescheduleOperation: "Blocked",
}

@doc("Defines constraints for reschedule operation on maintenance")
@discriminator("kind")
model RescheduleOperationConstraint {
  @doc("The kind of operation")
  @visibility(Lifecycle.Read)
  kind: RescheduleOperationConstraintKind;
}

@doc("Time window in which Customer can reschedule maintenance")
model AvailableWindowForMaintenanceWhileRescheduleOperation
  extends RescheduleOperationConstraint {
  @doc("The kind of constraint")
  kind: RescheduleOperationConstraintKind.AvailableWindowForMaintenanceWhileRescheduleOperation;

  ...AvailableWindowForMaintenance;
}

@doc("Time ranges blocked for rescheduling maintenance")
model BlockedWhileRescheduleOperation extends RescheduleOperationConstraint {
  @doc("The kind of constraint")
  kind: RescheduleOperationConstraintKind.BlockedWhileRescheduleOperation;

  ...BlockedMaintenanceWindow;
}

@doc("Refresh MaintenanceReadiness status")
model MaintenanceReadinessRefreshOperation
  extends MaintenanceManagementOperation {
  @doc("The kind of operation")
  kind: MaintenanceManagementOperationKind.MaintenanceReadinessRefresh;

  @doc("If maintenanceReadiness refresh is disabled")
  @visibility(Lifecycle.Read)
  isDisabled?: boolean;

  @doc("Reason disabling refresh for maintenanceReadiness")
  @visibility(Lifecycle.Read)
  disabledReason?: string;

  @doc("Status of the operation")
  @visibility(Lifecycle.Read)
  status?: MaintenanceReadinessRefreshOperationStatus;

  @doc("Indicates if the operation was refreshed by Microsoft")
  @visibility(Lifecycle.Read)
  refreshedByMicrosoft?: boolean;

  @doc("Additional message about the operation")
  @visibility(Lifecycle.Read)
  message?: string;
}

@doc("The status of an MaintenanceReadinessRefresh operation")
union MaintenanceReadinessRefreshOperationStatus {
  string,

  @doc("Operation is in progress")
  InProgress: "InProgress",

  @doc("Operation has not started")
  NotStarted: "NotStarted",

  @doc("Operation has failed")
  Failed: "Failed",

  @doc("Operation is not applicable")
  NotApplicable: "NotApplicable",
}
