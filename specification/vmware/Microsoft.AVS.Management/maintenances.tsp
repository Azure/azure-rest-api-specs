namespace Microsoft.AVS;

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armResourceOperations
interface Maintenances {
  @doc("List {name} resources by subscription ID", Maintenance)
  @segmentOf(Maintenance)
  @armResourceList(Maintenance)
  @added(Versions.v2024_09_01)
  @get
  list(
    ...ResourceParentParameters<Maintenance>,

    @query
    @doc("Filter maintenances based on state")
    stateName?: MaintenanceStateName,

    @query
    @doc("Filter active or inactive maintenances")
    status?: MaintenanceStatusFilter,

    @query
    @doc("date from which result should be returned. ie. scheduledStartTime >= from")
    from?: utcDateTime,

    @query
    @doc("date till which result should be returned. i.e. scheduledStartTime <= to")
    to?: utcDateTime,
  ): ArmResponse<ResourceListResult<Maintenance>> | ErrorResponse;
  @added(Versions.v2024_09_01)
  get is ArmResourceRead<Maintenance>;

  @doc("Reschedule a maintenance")
  @added(Versions.v2024_09_01)
  reschedule is ArmResourceActionSync<
    Maintenance,
    MaintenanceReschedule,
    Maintenance
  >;

  @doc("Schedule a maintenance")
  @added(Versions.v2024_09_01)
  schedule is ArmResourceActionSync<
    Maintenance,
    MaintenanceSchedule,
    Maintenance
  >;

  @doc("Initiate maintenance readiness checks")
  @added(Versions.v2024_09_01)
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

  @doc("Maintenance NotScheduled")
  NotScheduled: "NotScheduled",

  @doc("Maintenance Planned")
  Planned: "Planned",

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
  @visibility("read")
  component?: MaintenanceType;

  @doc("Display name for maintenance")
  @visibility("read")
  displayName?: string;

  @doc("Cluster ID for on which maintenance will be applied. Empty if maintenance is at private cloud level")
  @visibility("read")
  clusterId?: int32;

  @doc("Link to maintenance info")
  @visibility("read")
  infoLink?: string;

  @doc("Impact on the resource during maintenance period")
  @visibility("read")
  impact?: string;

  @doc("If maintenance is scheduled by Microsoft")
  @visibility("read")
  scheduledByMicrosoft?: boolean;

  @doc("The state of the maintenance")
  @visibility("read")
  state?: MaintenanceState;

  @doc("Scheduled maintenance start time")
  @visibility("read")
  scheduledStartTime?: utcDateTime;

  @doc("Estimated time maintenance will take in minutes")
  @visibility("read")
  estimatedDurationInMinutes?: int64;

  @doc("The provisioning state")
  @visibility("read")
  provisioningState?: MaintenanceProvisioningState;

  #suppress "deprecated" "Will be removed in next update"
  @doc("Constraints for rescheduling maintenance")
  @visibility("read")
  reschedule?: Reschedule;

  @doc("Operations on  maintenance")
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", [])
  operations?: MaintenanceManagementOperation[];

  @doc("Indicates whether the maintenance is ready to proceed")
  @visibility("read")
  maintenanceReadiness?: MaintenanceReadiness;
}

#deprecated "Use RescheduleOperation instead"
@doc("Constraints for rescheduling maintenance")
model Reschedule {
  @doc("If rescheduling is disabled")
  @visibility("read")
  isDisabled?: boolean;

  @doc("Reason for reschedule disabled")
  @visibility("read")
  disabledReason?: string;

  #suppress "deprecated" "Will be removed in next update"
  @doc("Constraints for rescheduling maintenance")
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", [])
  constraints?: RescheduleConstraint[];
}

#deprecated "Use RescheduleOperationConstraintKind instead"
@doc("Constraints for rescheduling of maintenance")
union RescheduleConstraintKind {
  string,

  @doc("Deadline constraint")
  Deadline: "Deadline",

  @doc("Freeze days constraint")
  FreezeDays: "FreezeDays",

  @doc("Blocked time range constraint")
  Blocked: "Blocked",
}

#deprecated "Use RescheduleOperationConstraint instead"
@doc("Constraint for rescheduling maintenance")
@discriminator("kind")
model RescheduleConstraint {
  @doc("The kind of constraint")
  @visibility("read")
  kind: RescheduleConstraintKind;
}

#deprecated "Use RescheduleOperationConstraint instead"
@doc("The deadline constraint for rescheduling maintenance")
model DeadlineRescheduleConstraint extends RescheduleConstraint {
  @doc("The kind of constraint")
  kind: RescheduleConstraintKind.Deadline;

  @doc("The deadline")
  @visibility("read")
  deadline: utcDateTime;
}

#deprecated "Use RescheduleOperationConstraint instead"
@doc("The deadline constraint for rescheduling maintenance")
model FreezeDaysRescheduleConstraint extends RescheduleConstraint {
  @doc("The kind of constraint")
  kind: RescheduleConstraintKind.FreezeDays;

  @doc("Freeze days")
  @visibility("read")
  freezeDays: plainDate[];
}

#deprecated "Use RescheduleOperationConstraint instead"
@doc("Time ranges blocked for rescheduling maintenance")
model BlockedRescheduleConstraint extends RescheduleConstraint {
  @doc("The kind of constraint")
  kind: RescheduleConstraintKind.Blocked;

  @doc("Start date time")
  @visibility("read")
  category: BlockedDatesConstraintCategory;

  #suppress "deprecated" "Will be removed in next update"
  @doc("Date ranges blocked for reschedule")
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["startAt", "endAt"])
  timeRanges?: BlockedRescheduleConstraintTimeRange[];
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

#deprecated "Use BlockedDatesConstraintTimeRange instead"
@doc("Blocked Time range Constraints for maintenance")
model BlockedRescheduleConstraintTimeRange {
  @doc("Start date time")
  @visibility("read")
  startAt: utcDateTime;

  @doc("End date Time")
  @visibility("read")
  endAt: utcDateTime;

  @doc("Reason category for blocking maintenance reschedule")
  @visibility("read")
  reason?: string;
}

@doc("Blocked Time range Constraints for maintenance")
model BlockedDatesConstraintTimeRange {
  @doc("Start date time")
  @visibility("read")
  startsAt: utcDateTime;

  @doc("End date Time")
  @visibility("read")
  endsAt: utcDateTime;

  @doc("Reason category for blocking maintenance reschedule")
  @visibility("read")
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
  @visibility("read")
  type: MaintenanceCheckType;

  @doc("The current readiness status of maintenance")
  @visibility("read")
  status: MaintenanceReadinessStatus;

  @doc("A summary message of the readiness check result")
  @visibility("read")
  message?: string;

  @doc("A list of failed checks, if any")
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", [])
  failedChecks?: MaintenanceFailedCheck[];

  @doc("The timestamp of the last readiness update")
  @visibility("read")
  lastUpdated?: utcDateTime;
}

@doc("Details about a failed maintenance check")
model MaintenanceFailedCheck {
  @doc("The name of the failed check")
  @visibility("read")
  name?: string;

  @doc("A list of resources impacted by the failed check")
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", [])
  impactedResources?: ImpactedMaintenanceResource[];
}

@doc("Details about a resource impacted by a failed check")
model ImpactedMaintenanceResource {
  @doc("The ID of the impacted resource")
  @visibility("read")
  id?: string;

  @doc("A list of errors associated with the impacted resource")
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", [])
  errors?: ImpactedMaintenanceResourceError[];
}

@doc("Details about an error affecting a resource")
model ImpactedMaintenanceResourceError {
  @doc("The error code")
  @visibility("read")
  errorCode?: string;

  @doc("The name of the error")
  @visibility("read")
  name?: string;

  @doc("Additional details about the error")
  @visibility("read")
  details?: string;

  @doc("Steps to resolve the error")
  @visibility("read")
  resolutionSteps?: string[];

  @doc("Indicates whether action is required by the customer")
  @visibility("read")
  actionRequired?: boolean;
}

//Define constraints common across maintenance operations in section below

@doc("Time window in which Customer can schedule maintenance")
model AvailableWindowForMaintenance {
  @doc("Start date time")
  @visibility("read")
  startsAt: utcDateTime;

  @doc("End date Time")
  @visibility("read")
  endsAt: utcDateTime;
}

@doc("Time ranges blocked for operation on maintenance")
model BlockedMaintenanceWindow {
  @doc("Category of blocked date")
  @visibility("read")
  category: BlockedDatesConstraintCategory;

  @doc("Date ranges blocked for schedule")
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["startsAt", "endsAt"])
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
  @visibility("read")
  kind: MaintenanceManagementOperationKind;
}

@doc("Scheduling window constraint")
model ScheduleOperation extends MaintenanceManagementOperation {
  @doc("The kind of operation")
  kind: MaintenanceManagementOperationKind.Schedule;

  @doc("If scheduling is disabled")
  @visibility("read")
  isDisabled?: boolean;

  @doc("Reason for schedule disabled")
  @visibility("read")
  disabledReason?: string;

  @doc("Constraints for scheduling maintenance")
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", [])
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
  @visibility("read")
  kind: ScheduleOperationConstraintKind;
}

@doc("Time window in which Customer has option to schedule maintenance")
model SchedulingWindow extends ScheduleOperationConstraint {
  @doc("The kind of constraint")
  kind: ScheduleOperationConstraintKind.SchedulingWindow;

  @doc("Start date time")
  @visibility("read")
  startsAt: utcDateTime;

  @doc("End date Time")
  @visibility("read")
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
  @visibility("read")
  isDisabled?: boolean;

  @doc("Reason for reschedule disabled")
  @visibility("read")
  disabledReason?: string;

  @doc("Constraints for rescheduling maintenance")
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", [])
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
  @visibility("read")
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
  @visibility("read")
  isDisabled?: boolean;

  @doc("Reason disabling refresh for maintenanceReadiness")
  @visibility("read")
  disabledReason?: string;

  @doc("Status of the operation")
  @visibility("read")
  status?: MaintenanceReadinessRefreshOperationStatus;

  @doc("Indicates if the operation was refreshed by Microsoft")
  @visibility("read")
  refreshedByMicrosoft?: boolean;

  @doc("Additional message about the operation")
  @visibility("read")
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
