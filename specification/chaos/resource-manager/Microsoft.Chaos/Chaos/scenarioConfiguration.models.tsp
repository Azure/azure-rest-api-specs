import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./scenario.models.tsp";
import "./common.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.Core;
using Azure.Core.Traits;

namespace Microsoft.Chaos;

/**
 * Model that represents the scenario.
 */
@parentResource(Scenario)
model ScenarioConfiguration
  is Azure.ResourceManager.ProxyResource<ScenarioConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = ScenarioConfiguration,
    KeyName = "scenarioConfigurationName",
    SegmentName = "configurations",
    NamePattern = "^[^<>%&:?#/\\\\]+$"
  >;
}

/**
 * Model that represents the properties of the scenario configuration.
 */
model ScenarioConfigurationProperties {
  /**
   * Resource ID of the scenario this configuration applies to.
   */
  scenarioId: Azure.Core.armResourceIdentifier;

  /**
   * Runtime parameter values for the scenario. Keys must match parameter names defined in the scenario.
   */
  @identifiers(#["key"])
  parameters?: KeyValuePair[];

  /**
   * Exclusion criteria for protecting resources from fault injection.
   */
  exclusions?: ConfigurationExclusions;

  /**
   * Most recent provisioning state for the given scenario resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Filter criteria used to constrain which discovered resources participate in fault injection.
   */
  filters?: ConfigurationFilters;
}

/**
 * Model that represents exclusion criteria for protecting resources from fault injection.
 * Uses union (OR) logic - a resource is excluded if it matches ANY criteria.
 */
model ConfigurationExclusions {
  /**
   * Array of specific resource IDs to exclude from fault injection.
   */
  resources?: Azure.Core.armResourceIdentifier[];

  /**
   * Array of tag key-value pairs. Resources with matching tags are excluded.
   */
  @identifiers(#["key"])
  tags?: KeyValuePair[];

  /**
   * Array of resource types. All resources of these types are excluded.
   */
  types?: string[];
}

/**
 * Model that represents filter criteria for constraining which discovered
 * resources participate in fault injection.
 *
 * Uses intersection (AND) logic — a resource is included only if it matches all criteria.
 */
model ConfigurationFilters {
  /**
   * Array of Azure location strings. Only resources in these locations are included.
   *
   * Null or omitted means all locations (no filter). Empty array means include nothing.
   */
  locations?: string[];

  /**
   * Array of availability zone identifiers ("1", "2", "3", "zone-redundant").
   * Only resources whose zones intersect this list are included.
   *
   * Null or omitted means all zones (including non-zonal). Empty array means include nothing.
   *
   * Mutually exclusive with `physicalZones` — set one or the other, not both.
   */
  zones?: string[];

  /**
   * Array of physical availability zone identifiers in `{region}-az{N}` format
   * (e.g., `"westus2-az1"`). Only resources in the corresponding logical zone
   * for each subscription are included.
   *
   * At execution time, each physical zone is resolved to per-subscription
   * logical zones via the ARM locations API. The resolved mapping is surfaced
   * on the scenario run response (`zoneResolution`).
   *
   * Null or omitted means physical zone targeting is not used.
   * Only one physical zone is supported in preview.
   *
   * Mutually exclusive with `zones` — set one or the other, not both.
   */
  physicalZones?: string[];
}

@parentResource(ScenarioConfiguration)
@singleton("latest")
model Validation is ProxyResource<ValidationProperties> {
  ...ResourceNameParameter<Validation>;
}

/**
 * Model that represents the properties of the scenario validation.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "kinda resource"
model ValidationProperties {
  /**
   * The scenario validation status.
   */
  @visibility(Lifecycle.Read)
  @lroStatus
  status: ScenarioValidationState;

  /**
   * The scenario validation UTC start time.
   */
  @visibility(Lifecycle.Read)
  startTime: utcDateTime;

  /**
   * Execution plan created from validation. This plan will be executed as-is on next scenario execution.
   */
  executionPlanJson?: string;

  /**
   * The scenario validation UTC end time.
   */
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

  /**
   * System or infrastructure errors encountered during validation.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  errors?: OperationError[];

  /**
   * Business errors from validation — permission and resource state issues.
   */
  validationErrors?: ScenarioErrors;
}

/**
 * Model that represents the scenario run result.
 */
model ScenarioRunResult {
  /**
   * The resource id of the latest scenario run.
   */
  @visibility(Lifecycle.Read)
  runResourceId: string;

  /**
   * The time when the last scenario run was started.
   */
  @visibility(Lifecycle.Read)
  startedAt: utcDateTime;
}

/**
 * Model that represents the scenario run errors.
 */
model ScenarioErrors {
  /**
   * Error code for internal server errors.
   */
  errorCode?: string;

  /**
   * Error message for internal server errors.
   */
  errorMessage?: string;

  /**
   * Any permission errors associated with the scenario run.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["resourceId"])
  permission: PermissionError[];

  /**
   * Any resource state errors associated with the scenario run.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["resourceId"])
  resource: ResourceStateError[];
}

/**
 * Model that represents the permission error.
 */
model PermissionError {
  /**
   * The resource id for the affected resource.
   */
  @visibility(Lifecycle.Read)
  resourceId: string;

  /**
   * The missing permissions.
   */
  @visibility(Lifecycle.Read)
  missingPermissions: string[];

  /**
   * The required permissions.
   */
  @visibility(Lifecycle.Read)
  requiredPermissions: string[];

  /**
   * The recommended roles.
   */
  @visibility(Lifecycle.Read)
  recommendedRoles: string[];

  /**
   * The identity.
   */
  @visibility(Lifecycle.Read)
  identity?: EntraIdentity;
}

/**
 * Model that represents the Azure Entra identity.
 */
model EntraIdentity {
  /**
   * The identity object id.
   */
  @visibility(Lifecycle.Read)
  objectId: string;

  /**
   * The identity tenant id.
   */
  @visibility(Lifecycle.Read)
  tenantId: string;
}

/**
 * Model that represents the resource state error.
 */
model ResourceStateError {
  /**
   * The resource id for the affected resource.
   */
  @visibility(Lifecycle.Read)
  resourceId: string;

  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  errorCode: int32;

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  errorMessage: string;

  /**
   * The remediation uri.
   */
  @visibility(Lifecycle.Read)
  remediationUri: string;
}

/**
 * Enum of the scenario validation state.
 */
union ScenarioValidationState {
  string,

  /**
   * The scenario validation is in a resolving state.
   */
  Resolving: "Resolving",

  /**
   * The scenario validation is in a generating state.
   */
  Generating: "Generating",

  /**
   * The scenario validation is in a validating state.
   */
  Validating: "Validating",

  /**
   * The scenario validation has been accepted.
   */
  Accepted: "Accepted",

  /**
   * The scenario validation has not yet started.
   */
  NotStarted: "NotStarted",

  /**
   * The scenario validation reflects a state that requires attention.
   * This is a terminal failure state indicating validation issues were found.
   */
  @lroFailed
  RequiresAttention: "RequiresAttention",

  /**
   * The scenario validation found no valid resources to perform fault behaviors against.
   * This is a terminal failure state.
   */
  @lroFailed
  NoResolvedResources: "NoResolvedResources",

  /**
   * The scenario validation completed successfully and the scenario is ready to execute.
   */
  @lroSucceeded
  Succeeded: "Succeeded",
}

/**
 * Model that represents a list of scenario configurations and a link for pagination.
 */
model ScenarioConfigurationListResult is Azure.Core.Page<ScenarioConfiguration>;

/**
 * Model that represents the fix resource permissions result.
 */
@parentResource(ScenarioConfiguration)
@singleton("latest")
model PermissionsFix is ProxyResource<PermissionsFixProperties> {
  ...ResourceNameParameter<
    Resource = PermissionsFix,
    KeyName = "PermissionsFixName",
    SegmentName = "fixResourcePermissions",
    NamePattern = ""
  >;
}

/**
 * Model that represents the properties of the permission fix operation.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Uses state property instead"
model PermissionsFixProperties {
  /**
   * The permission fix state.
   */
  @visibility(Lifecycle.Read)
  state: PermissionsFixState;

  /**
   * The permission fix UTC start time.
   */
  @visibility(Lifecycle.Read)
  startedAt: utcDateTime;

  /**
   * The permission fix UTC end time.
   */
  @visibility(Lifecycle.Read)
  completedAt?: utcDateTime;

  /**
   * Whether this was a what-if (dry run) operation.
   */
  @visibility(Lifecycle.Read)
  whatIfMode: boolean;

  /**
   * The list of role assignment results.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  roleAssignments: RoleAssignmentResult[];

  /**
   * Summary of the permission fix operation.
   */
  @visibility(Lifecycle.Read)
  summary: PermissionsFixSummary;
}

/**
 * Result of a single role assignment operation.
 */
model RoleAssignmentResult {
  /**
   * The target Azure resource ID.
   */
  @visibility(Lifecycle.Read)
  targetResourceId: string;

  /**
   * The managed identity principal ID.
   */
  @visibility(Lifecycle.Read)
  principalId: string;

  /**
   * The Azure RBAC role definition ID.
   */
  @visibility(Lifecycle.Read)
  roleDefinitionId: string;

  /**
   * Human-readable role name.
   */
  @visibility(Lifecycle.Read)
  roleDefinitionName: string;

  /**
   * The scope at which the role was/will be assigned.
   */
  @visibility(Lifecycle.Read)
  scope: string;

  /**
   * The status of the role assignment operation.
   */
  @visibility(Lifecycle.Read)
  status: RoleAssignmentStatus;

  /**
   * The created role assignment resource ID (null if failed or what-if mode).
   */
  @visibility(Lifecycle.Read)
  roleAssignmentId?: string;

  /**
   * Error details if the assignment failed.
   */
  @visibility(Lifecycle.Read)
  error?: RoleAssignmentError;
}

/**
 * Error details for a failed role assignment.
 */
model RoleAssignmentError {
  /**
   * Azure error code.
   */
  @visibility(Lifecycle.Read)
  code: string;

  /**
   * Error message.
   */
  @visibility(Lifecycle.Read)
  message: string;
}

/**
 * Summary of the permission fix operation.
 */
model PermissionsFixSummary {
  /**
   * Total number of role assignments required.
   */
  @visibility(Lifecycle.Read)
  totalRequired: int32;

  /**
   * Number of successful role assignments.
   */
  @visibility(Lifecycle.Read)
  succeeded: int32;

  /**
   * Number of failed role assignments.
   */
  @visibility(Lifecycle.Read)
  failed: int32;

  /**
   * Number of skipped role assignments (already existed).
   */
  @visibility(Lifecycle.Read)
  skipped: int32;
}

/**
 * Enum of the permission fix state.
 */
union PermissionsFixState {
  string,

  /**
   * The permission fix has not started.
   */
  NotStarted: "NotStarted",

  /**
   * The permission fix is in progress.
   */
  InProgress: "InProgress",

  /**
   * All role assignments succeeded.
   */
  Succeeded: "Succeeded",

  /**
   * All role assignments failed.
   */
  Failed: "Failed",

  /**
   * Some role assignments succeeded and some failed.
   */
  PartiallySucceeded: "PartiallySucceeded",

  /**
   * What-if analysis completed (no changes made).
   */
  WhatIfCompleted: "WhatIfCompleted",
}

/**
 * Enum of the role assignment status.
 */
union RoleAssignmentStatus {
  string,

  /**
   * The role assignment succeeded.
   */
  Succeeded: "Succeeded",

  /**
   * The role assignment failed.
   */
  Failed: "Failed",

  /**
   * The role assignment was skipped (already exists).
   */
  Skipped: "Skipped",

  /**
   * The role assignment is pending (what-if mode).
   */
  Pending: "Pending",
}

/**
 * Request body for fixing resource permissions.
 */
model FixResourcePermissionsRequest {
  /**
   * Optional value that indicates whether to run a "dry run" of fixing resource permissions.
   */
  whatIf?: boolean;
}
