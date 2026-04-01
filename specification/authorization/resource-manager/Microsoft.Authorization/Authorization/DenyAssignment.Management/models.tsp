import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "../Common/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Microsoft.Common;

namespace Microsoft.DenyAssignment;

/**
 * The deny assignment effect type.
 */
@added(Versions.v2024_07_01_preview)
union DenyAssignmentEffect {
  string,

  /** The deny assignment is enforced. */
  Enforced: "enforced",

  /** The deny assignment is audited but not enforced. */
  Audit: "audit",
}

/**
 * Deny assignment properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DenyAssignmentProperties {
  /**
   * The display name of the deny assignment.
   */
  denyAssignmentName?: string;

  /**
   * The description of the deny assignment.
   */
  description?: string;

  /**
   * An array of permissions that are denied by the deny assignment.
   */
  @identifiers(#[])
  permissions?: DenyAssignmentPermission[];

  /**
   * The deny assignment scope.
   */
  scope?: string;

  /**
   * Determines if the deny assignment applies to child scopes. Default value is false.
   */
  doNotApplyToChildScopes?: boolean;

  /**
   * Array of principals to which the deny assignment applies.
   */
  principals?: Principal[];

  /**
   * Array of principals to which the deny assignment does not apply.
   */
  excludePrincipals?: Principal[];

  /**
   * Specifies whether this deny assignment was created by Azure and cannot be edited or deleted.
   */
  isSystemProtected?: boolean;

  @doc("The conditions on the deny assignment. This limits the resources it can be assigned to. e.g.: @Resource[Microsoft.Storage/storageAccounts/blobServices/containers:ContainerName] StringEqualsIgnoreCase 'foo_storage_container'")
  condition?: string;

  /**
   * Version of the condition.
   */
  conditionVersion?: string;

  /**
   * Time it was created
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  /**
   * Time it was updated
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedOn?: utcDateTime;

  /**
   * Id of the user who created the assignment
   */
  @visibility(Lifecycle.Read)
  createdBy?: string;

  /**
   * Id of the user who updated the assignment
   */
  @visibility(Lifecycle.Read)
  updatedBy?: string;

  /**
   * The deny assignment effect.
   */
  @added(Versions.v2024_07_01_preview)
  denyAssignmentEffect?: DenyAssignmentEffect;
}

/**
 * Deny assignment permissions.
 */
model DenyAssignmentPermission {
  /**
   * Actions to which the deny assignment does not grant access.
   */
  actions?: string[];

  /**
   * Actions to exclude from that the deny assignment does not grant access.
   */
  notActions?: string[];

  /**
   * Data actions to which the deny assignment does not grant access.
   */
  dataActions?: string[];

  /**
   * Data actions to exclude from that the deny assignment does not grant access.
   */
  notDataActions?: string[];

  /**
   * The conditions on the Deny assignment permission. This limits the resources it applies to.
   */
  condition?: string;

  /**
   * Version of the condition.
   */
  conditionVersion?: string;
}

/**
 * Deny Assignments filter
 */
model DenyAssignmentFilter {
  /**
   * Return deny assignment with specified name.
   */
  denyAssignmentName?: string;

  /**
   * Return all deny assignments where the specified principal is listed in the principals list of deny assignments.
   */
  principalId?: string;

  /**
   * Return all deny assignments where the specified principal is listed either in the principals list or exclude principals list of deny assignments.
   */
  gdprExportPrincipalId?: string;
}
