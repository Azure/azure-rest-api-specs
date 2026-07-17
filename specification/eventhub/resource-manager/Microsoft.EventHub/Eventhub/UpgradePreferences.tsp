import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.EventHub;

/**
 * Upgrade preferences for an Event Hubs Dedicated cluster.
 */
@added(Versions.v2026_07_01_preview)
@singleton("default")
@parentResource(Cluster)
model UpgradePreferences
  is Azure.ResourceManager.ProxyResource<UpgradePreferencesProperties> {
  ...ResourceNameParameter<
    Resource = UpgradePreferences,
    KeyName = "upgradePreferencesName",
    SegmentName = "upgradePreferences",
    NamePattern = ""
  >;
}

/**
 * Upgrade preference properties for an Event Hubs Dedicated cluster.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "The service does not expose a provisioning state for this proxy resource."
@added(Versions.v2026_07_01_preview)
model UpgradePreferencesProperties {
  /**
   * Recurring weekly maintenance windows in UTC. At least one window must be supplied when preferences are created or updated. A maximum of two windows can be configured, and their combined duration must be at least 16 hours per week.
   */
  @minItems(1)
  @maxItems(2)
  @identifiers(#[])
  maintenanceWindows?: MaintenanceWindow[];

  /**
   * Date-specific exceptions to the recurring maintenance windows.
   */
  @identifiers(#[])
  exceptionWindows?: ExceptionWindow[];

  /**
   * The current cluster upgrade status.
   */
  @visibility(Lifecycle.Read)
  upgradeStatus?: UpgradeStatus;
}

/**
 * A recurring weekly maintenance window in UTC.
 */
@added(Versions.v2026_07_01_preview)
model MaintenanceWindow {
  /**
   * The UTC day of the week on which the maintenance window starts.
   */
  dayOfWeek: UpgradePreferenceDayOfWeek;

  /**
   * The UTC time of day at which the maintenance window starts, represented as an ISO 8601 duration since midnight.
   */
  startTimeOfDay: duration;

  /**
   * The maintenance window duration in minutes. The value must be between 480 and 1440 in 60-minute increments.
   */
  @minValue(480)
  @maxValue(1440)
  durationMinutes: int32;
}

/**
 * A date-specific exception to the recurring maintenance windows.
 */
@added(Versions.v2026_07_01_preview)
model ExceptionWindow {
  /**
   * The UTC date on which the exception starts.
   */
  date: plainDate;

  /**
   * Whether the exception blocks or allows upgrades.
   */
  action: ExceptionWindowAction;

  /**
   * The UTC time of day at which the exception starts, represented as an ISO 8601 duration since midnight.
   */
  startTimeOfDay: duration;

  /**
   * The exception duration in minutes. Allow exceptions must be between 480 and 1440 minutes in 60-minute increments. Block exceptions must be 1440 minutes.
   */
  @minValue(480)
  @maxValue(1440)
  durationMinutes: int32;
}

/**
 * The current upgrade orchestration state for the cluster.
 */
@added(Versions.v2026_07_01_preview)
model UpgradeStatus {
  /**
   * Whether at least one deferred upgrade is waiting for the cluster.
   */
  pendingUpgrade: boolean;

  /**
   * Whether an upgrade-now override is currently active.
   */
  inProgress: boolean;

  /**
   * The estimated UTC time when the current upgrade will complete.
   */
  completesAt?: utcDateTime;
}

/**
 * A day of the week.
 */
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "The service validates the value against this fixed set and rejects unknown values."
@added(Versions.v2026_07_01_preview)
union UpgradePreferenceDayOfWeek {
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

/**
 * The action performed by an exception window.
 */
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "The service validates the value against this fixed set and rejects unknown values."
@added(Versions.v2026_07_01_preview)
union ExceptionWindowAction {
  /**
   * Prevent upgrades during the exception window.
   */
  Block: "Block",

  /**
   * Allow upgrades during the exception window.
   */
  Allow: "Allow",
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Upgrade preferences are a singleton resource that does not support deletion."
@added(Versions.v2026_07_01_preview)
@armResourceOperations
interface UpgradePreferencesOperations {
  /**
   * Gets the upgrade preferences for an Event Hubs Dedicated cluster.
   */
  get is ArmResourceRead<UpgradePreferences, Error = ErrorResponse>;

  /**
   * Creates or updates the upgrade preferences for an Event Hubs Dedicated cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "The service returns 200 for both create and update."
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    UpgradePreferences,
    Response = ArmResourceUpdatedResponse<UpgradePreferences>,
    Error = ErrorResponse
  >;

  /**
   * Starts an immediate eight-hour upgrade override when an upgrade is pending.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "The service returns 200 when an upgrade starts and 204 when no upgrade is pending."
  @action("upgradeNow")
  upgradeNow is ArmResourceActionSync<
    UpgradePreferences,
    void,
    ArmResponse<UpgradePreferences> | NoContentResponse,
    Error = ErrorResponse
  >;
}

@@doc(UpgradePreferences.name, "The upgrade preferences resource name.");
@@doc(
  UpgradePreferences.properties,
  "Upgrade preference properties for the Event Hubs Dedicated cluster."
);
@@doc(
  UpgradePreferencesOperations.createOrUpdate::parameters.resource,
  "The upgrade preferences."
);
