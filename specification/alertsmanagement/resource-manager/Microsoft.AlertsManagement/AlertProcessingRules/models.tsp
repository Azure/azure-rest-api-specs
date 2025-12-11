import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.AlertsManagement;

/**
 * Field for a given condition.
 */
union Field {
  string,

  /**
   * Severity
   */
  Severity: "Severity",

  /**
   * MonitorService
   */
  MonitorService: "MonitorService",

  /**
   * MonitorCondition
   */
  MonitorCondition: "MonitorCondition",

  /**
   * SignalType
   */
  SignalType: "SignalType",

  /**
   * TargetResourceType
   */
  TargetResourceType: "TargetResourceType",

  /**
   * TargetResource
   */
  TargetResource: "TargetResource",

  /**
   * TargetResourceGroup
   */
  TargetResourceGroup: "TargetResourceGroup",

  /**
   * AlertRuleId
   */
  AlertRuleId: "AlertRuleId",

  /**
   * AlertRuleName
   */
  AlertRuleName: "AlertRuleName",

  /**
   * Description
   */
  Description: "Description",

  /**
   * AlertContext
   */
  AlertContext: "AlertContext",
}

/**
 * Operator for a given condition.
 */
union Operator {
  string,

  /**
   * Equals
   */
  Equals: "Equals",

  /**
   * NotEquals
   */
  NotEquals: "NotEquals",

  /**
   * Contains
   */
  Contains: "Contains",

  /**
   * DoesNotContain
   */
  DoesNotContain: "DoesNotContain",
}

/**
 * Specifies when the recurrence should be applied.
 */
union RecurrenceType {
  string,

  /**
   * Daily
   */
  Daily: "Daily",

  /**
   * Weekly
   */
  Weekly: "Weekly",

  /**
   * Monthly
   */
  Monthly: "Monthly",
}

/**
 * Action that should be applied.
 */
union ActionType {
  string,

  /**
   * AddActionGroups
   */
  AddActionGroups: "AddActionGroups",

  /**
   * RemoveAllActionGroups
   */
  RemoveAllActionGroups: "RemoveAllActionGroups",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * Days of week.
 */
union DaysOfWeek {
  string,

  /**
   * Sunday
   */
  Sunday: "Sunday",

  /**
   * Monday
   */
  Monday: "Monday",

  /**
   * Tuesday
   */
  Tuesday: "Tuesday",

  /**
   * Wednesday
   */
  Wednesday: "Wednesday",

  /**
   * Thursday
   */
  Thursday: "Thursday",

  /**
   * Friday
   */
  Friday: "Friday",

  /**
   * Saturday
   */
  Saturday: "Saturday",
}

/**
 * List of alert processing rules.
 */
model AlertProcessingRulesList is Azure.Core.Page<AlertProcessingRule>;

/**
 * Alert processing rule properties defining scopes, conditions and scheduling logic for alert processing rule.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AlertProcessingRuleProperties {
  /**
   * Scopes on which alert processing rule will apply.
   */
  scopes: string[];

  /**
   * Conditions on which alerts will be filtered.
   */
  @identifiers(#[])
  conditions?: Condition[];

  /**
   * Scheduling for alert processing rule.
   */
  schedule?: Schedule;

  /**
   * Actions to be applied.
   */
  @identifiers(#[])
  actions: Action[];

  /**
   * Actions to be applied.
   */
  /**
   * Description of alert processing rule.
   */
  description?: string;

  /**
   * Indicates if the given alert processing rule is enabled or disabled.
   */
  enabled?: boolean = true;
}

/**
 * Condition to trigger an alert processing rule.
 */
model Condition {
  /**
   * Field for a given condition.
   */
  field?: Field;

  /**
   * Operator for a given condition.
   */
  operator?: Operator;

  /**
   * List of values to match for a given condition.
   */
  values?: string[];
}

/**
 * Scheduling configuration for a given alert processing rule.
 */
model Schedule {
  /**
   * Scheduling effective from time. Date-Time in ISO-8601 format without timezone suffix.
   */
  @pattern("^(?:(\\d{4}-\\d{2}-\\d{2})T(\\d{2}:\\d{2}:\\d{2}(?:\\.\\d+)?))$")
  effectiveFrom?: string;

  /**
   * Scheduling effective until time. Date-Time in ISO-8601 format without timezone suffix.
   */
  @pattern("^(?:(\\d{4}-\\d{2}-\\d{2})T(\\d{2}:\\d{2}:\\d{2}(?:\\.\\d+)?))$")
  effectiveUntil?: string;

  /**
   * Scheduling time zone.
   */
  timeZone?: string;

  /**
   * List of recurrences.
   */
  @identifiers(#[])
  recurrences?: Recurrence[];
}

/**
 * Recurrence object.
 */
@discriminator("recurrenceType")
model Recurrence {
  /**
   * Specifies when the recurrence should be applied.
   */
  recurrenceType: RecurrenceType;

  /**
   * Start time for recurrence.
   */
  startTime?: string;

  /**
   * End time for recurrence.
   */
  endTime?: string;
}

/**
 * Action to be applied.
 */
@discriminator("actionType")
model Action {
  /**
   * Action that should be applied.
   */
  actionType: ActionType;
}

/**
 * An azure managed resource object.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedResource extends Resource {
  /**
   * Resource location
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * An azure resource object
 */
model Resource {
  /**
   * Azure resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Azure resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Azure resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;
}

/**
 * An error response from the service.
 */
@error
model ErrorResponse {
  /**
   * Details of error response.
   */
  error?: ErrorResponseBody;
}

/**
 * Details of error response.
 */
model ErrorResponseBody {
  /**
   * Error code, intended to be consumed programmatically.
   */
  code?: string;

  /**
   * Description of the error, intended for display in user interface.
   */
  message?: string;

  /**
   * Target of the particular error, for example name of the property.
   */
  target?: string;

  /**
   * A list of additional details about the error.
   */
  @identifiers(#[])
  details?: ErrorResponseBody[];
}

/**
 * Data contract for patch.
 */
model PatchObject {
  /**
   * Properties supported by patch operation.
   */
  properties?: PatchProperties;

  /**
   * Tags to be updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Alert processing rule properties supported by patch.
 */
model PatchProperties {
  /**
   * Indicates if the given alert processing rule is enabled or disabled.
   */
  enabled?: boolean;
}

/**
 * Daily recurrence object.
 */
model DailyRecurrence extends Recurrence {
  /**
   * Specifies when the recurrence should be applied.
   */
  recurrenceType: "Daily";
}

/**
 * Weekly recurrence object.
 */
model WeeklyRecurrence extends Recurrence {
  /**
   * Specifies the values for weekly recurrence pattern.
   */
  daysOfWeek: DaysOfWeek[];

  /**
   * Specifies when the recurrence should be applied.
   */
  recurrenceType: "Weekly";
}

/**
 * Monthly recurrence object.
 */
model MonthlyRecurrence extends Recurrence {
  /**
   * Specifies the values for monthly recurrence pattern.
   */
  daysOfMonth: int32[];

  /**
   * Specifies when the recurrence should be applied.
   */
  recurrenceType: "Monthly";
}

/**
 * Add action groups to alert processing rule.
 */
model AddActionGroups extends Action {
  /**
   * List of action group Ids to add to alert processing rule.
   */
  actionGroupIds: string[];

  /**
   * Action that should be applied.
   */
  actionType: "AddActionGroups";
}

/**
 * Indicates if all action groups should be removed.
 */
model RemoveAllActionGroups extends Action {
  /**
   * Action that should be applied.
   */
  actionType: "RemoveAllActionGroups";
}
