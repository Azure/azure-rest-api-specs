import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DenyAssignment;

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
 * The type of the principal such as user, group, servicePrincipal, etc.
 */
union DenyAssignmentPrincipalType {
  string,
}

/**
 * The effect of the deny assignment. 'enforced' blocks access, 'audit' logs without blocking.
 */
union DenyAssignmentEffect {
  string,

  /**
   * enforced
   */
  enforced: "enforced",

  /**
   * audit
   */
  audit: "audit",
}

/**
 * Deny assignment properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
  @visibility(Lifecycle.Read)
  scope?: string;

  /**
   * Determines if the deny assignment applies to child scopes. Default value is false.
   */
  doNotApplyToChildScopes?: boolean;

  /**
   * Array of principals to which the deny assignment applies.
   */
  principals?: DenyAssignmentPrincipal[];

  /**
   * Array of principals to which the deny assignment does not apply.
   */
  excludePrincipals?: DenyAssignmentPrincipal[];

  /**
   * Specifies whether this deny assignment was created by Azure and cannot be edited or deleted.
   */
  isSystemProtected?: boolean;

  /**
   * The effect of the deny assignment. 'enforced' blocks access, 'audit' logs without blocking.
   */
  denyAssignmentEffect?: DenyAssignmentEffect;

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
 * Deny assignment principal.
 */
model DenyAssignmentPrincipal {
  /**
   * The object ID of the principal.
   */
  id?: string;

  /**
   * The type of the principal such as user, group, servicePrincipal, etc.
   */
  type?: DenyAssignmentPrincipalType;
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
