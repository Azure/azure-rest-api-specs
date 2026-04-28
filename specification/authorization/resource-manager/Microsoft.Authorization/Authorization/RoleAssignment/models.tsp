import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "../Common/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Microsoft.Common;

namespace Microsoft.RoleAssignment;

/**
 * Role assignment properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RoleAssignmentProperties {
  /**
   * The role assignment scope.
   */
  @visibility(Lifecycle.Read)
  scope?: string;

  /**
   * The role definition ID.
   */
  roleDefinitionId: string;

  /**
   * The principal ID.
   */
  principalId: string;

  /**
   * The principal type of the assigned principal ID.
   */
  principalType?: PrincipalType = PrincipalType.User;

  /**
   * Description of role assignment
   */
  description?: string;

  @doc("The conditions on the role assignment. This limits the resources it can be assigned to. e.g.: @Resource[Microsoft.Storage/storageAccounts/blobServices/containers:ContainerName] StringEqualsIgnoreCase 'foo_storage_container'")
  condition?: string;

  /**
   * Version of the condition. Currently the only accepted value is '2.0'
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
   * Id of the delegated managed identity resource
   */
  delegatedManagedIdentityResourceId?: string;
}

/**
 * Role assignment create parameters.
 */
model RoleAssignmentCreateParameters {
  /**
   * Role assignment properties.
   */
  properties: RoleAssignmentProperties;
}

/**
 * Failed validation result details
 */
model ValidationResponseErrorInfo {
  /**
   * Error code indicating why validation failed
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Message indicating why validation failed
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Validation response
 */
model ValidationResponse {
  /**
   * Whether or not validation succeeded
   */
  @visibility(Lifecycle.Read)
  isValid?: boolean;

  /**
   * Failed validation result details
   */
  errorInfo?: ValidationResponseErrorInfo;
}

/**
 * Role assignment list operation result.
 */
model RoleAssignmentListResult is Azure.Core.Page<RoleAssignment>;

/**
 * Role Assignments filter
 */
model RoleAssignmentFilter {
  /**
   * Returns role assignment of the specific principal.
   */
  principalId?: string;
}
