using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Monitor;

/**
 * Inputs for advisory inspection of the Monitoring Contributor role at subscription scope.
 * No observability agent is created or modified, and no role assignments are changed.
 */
model ObservabilityAgentIdentityAccessContent {
  /**
   * Resource ID of the existing user-assigned managed identity to inspect.
   * The ID must reference Microsoft.ManagedIdentity/userAssignedIdentities in a subscription.
   * Its hosting subscription is not automatically included among the target subscriptions.
   */
  @minLength(1)
  @maxLength(2048)
  userAssignedIdentityResourceId: armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;

  /**
   * Resource ID of an Azure Monitor account whose subscription is also checked.
   * Omission or null adds no subscription. An empty string is invalid.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The existing POST accepts explicit null as omission; optionality alone would reject a supported request."
  @minLength(1)
  @maxLength(2048)
  monitoringAccountId?:
    | armResourceIdentifier<[
        {
          type: "Microsoft.Monitor/accounts";
        }
      ]>
    | null;

  /**
   * Resource IDs whose subscriptions are also checked, deduplicated with the route and
   * monitoring account subscriptions. Omission, null, or an empty array adds no subscriptions.
   * Each item must be a nonempty subscription-scoped ARM resource ID; null items are invalid.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The existing POST accepts explicit null as an empty target list; optionality alone would reject a supported request."
  @maxItems(10)
  monitoredResourceIds?: ObservabilityAgentIdentityAccessResourceId[] | null;
}

/**
 * A subscription-scoped ARM resource ID with a valid subscription GUID and a nonempty resource name.
 * The value must start with a slash and must not contain double slashes, backslashes, query
 * strings, fragments, or dot path segments. A trailing slash is accepted and removed.
 */
@minLength(1)
@maxLength(2048)
scalar ObservabilityAgentIdentityAccessResourceId extends armResourceIdentifier;

/** Outcome of an advisory check for the recommended role, not an effective-permissions evaluation. */
union ObservabilityAgentIdentityAccessStatus {
  /** An unconditional applicable Monitoring Contributor assignment was found. */
  RecommendedRolePresent: "RecommendedRolePresent",

  /** No applicable Monitoring Contributor assignment was found in the completed inspection. */
  RecommendedRoleMissing: "RecommendedRoleMissing",

  /** The inspection could not conclusively determine whether the recommended role is present. */
  UnableToVerify: "UnableToVerify",

  string,
}

/** Reason the recommended role could not be verified. */
union ObservabilityAgentIdentityAccessReason {
  /** Delegated caller authorization was unavailable. */
  CallerAuthorizationUnavailable: "CallerAuthorizationUnavailable",

  /** The identity could not be retrieved using the caller's authorization. */
  IdentityLookupFailed: "IdentityLookupFailed",

  /** The target subscription's tenant could not be determined. */
  TargetTenantUnavailable: "TargetTenantUnavailable",

  /** The identity and target subscription belong to different tenants. */
  IdentityTenantMismatch: "IdentityTenantMismatch",

  /** The caller could not read the relevant role assignments. */
  RoleAssignmentsReadDenied: "RoleAssignmentsReadDenied",

  /** Role assignment inspection failed. */
  RoleAssignmentsReadFailed: "RoleAssignmentsReadFailed",

  /** A dependency returned an invalid or incomplete response. */
  InvalidArmResponse: "InvalidArmResponse",

  /** Only conditional matching assignments were found; their conditions were not evaluated. */
  ConditionalRoleAssignment: "ConditionalRoleAssignment",

  /** The role assignment listing exceeded the inspection's pagination limit. */
  IncompleteRoleAssignmentListing: "IncompleteRoleAssignmentListing",

  /** A dependency operation timed out. */
  ValidationTimedOut: "ValidationTimedOut",

  string,
}

/** The advisory role inspection result for a target subscription. */
model ObservabilityAgentIdentitySubscriptionAccess {
  /** The target subscription ID, formatted as a GUID. */
  @visibility(Lifecycle.Read)
  subscriptionId: string;

  /** Whether an applicable recommended role assignment was found for this subscription. */
  @visibility(Lifecycle.Read)
  status: ObservabilityAgentIdentityAccessStatus;

  /** Present when the status is UnableToVerify; otherwise omitted. */
  @visibility(Lifecycle.Read)
  reasonCode?: ObservabilityAgentIdentityAccessReason;
}

/**
 * Advisory role inspection result. Presence of Monitoring Contributor is not a guarantee
 * that every future operation will succeed; absence does not exclude sufficient permissions
 * through other roles. The result does not enforce observability agent creation.
 */
model ObservabilityAgentIdentityAccessResult {
  /**
   * Overall outcome. UnableToVerify takes precedence over RecommendedRoleMissing,
   * which takes precedence over RecommendedRolePresent.
   */
  @visibility(Lifecycle.Read)
  status: ObservabilityAgentIdentityAccessStatus;

  /** The inspected user-assigned managed identity resource ID, with a trailing slash removed. */
  @visibility(Lifecycle.Read)
  userAssignedIdentityResourceId: armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;

  /** The recommended role display name: Monitoring Contributor. */
  @visibility(Lifecycle.Read)
  recommendedRole: string;

  /** The Monitoring Contributor role definition GUID: 749f88d5-cbae-40b8-bcfc-e573ddc772fa. */
  @visibility(Lifecycle.Read)
  recommendedRoleDefinitionId: string;

  /**
   * One result per distinct target subscription, sorted by subscription ID.
   * The route subscription is always included. Account and monitored resource subscriptions
   * are added when supplied. Assignments must apply to the subscription, including applicable
   * inherited root or management-group assignments and group membership returned by ARM.
   * Resource-group-only and resource-only assignments do not satisfy this check.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["subscriptionId"])
  @minItems(1)
  @maxItems(12)
  subscriptions: ObservabilityAgentIdentitySubscriptionAccess[];
}

/**
 * An error from the resource provider or ARM gateway. Invalid input returns HTTP 400
 * with top-level code and message and no error envelope. ARM gateway failures use
 * the common ARM error object and omit the top-level code and message.
 * The properties are optional in this shared schema because neither shape contains
 * the other's fields; this does not change either component's error format.
 */
@error
model ObservabilityAgentIdentityAccessError {
  ...ErrorResponse;

  /** Present with message for invalid preflight input; the code is InvalidIdentityPreflightRequest. */
  @visibility(Lifecycle.Read)
  code?: string;

  /** Present with code for invalid preflight input; describes the invalid input. */
  @visibility(Lifecycle.Read)
  message?: string;
}
