import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.RoleDefinitions;

/**
 * Permissions information.
 */
model PermissionGetResult is Azure.Core.Page<Permission>;

/**
 * Role definition permissions.
 */
model Permission {
  /**
   * Allowed actions.
   */
  actions?: string[];

  /**
   * Denied actions.
   */
  notActions?: string[];

  /**
   * Allowed Data actions.
   */
  dataActions?: string[];

  /**
   * Denied Data actions.
   */
  notDataActions?: string[];

  @doc("The conditions on the role definition. This limits the resources it can be assigned to. e.g.: @Resource[Microsoft.Storage/storageAccounts/blobServices/containers:ContainerName] StringEqualsIgnoreCase 'foo_storage_container'")
  @visibility(Lifecycle.Read)
  condition?: string;

  /**
   * Version of the condition. Currently the only accepted value is '2.0'
   */
  @visibility(Lifecycle.Read)
  conditionVersion?: string;
}

/**
 * Role definition properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RoleDefinitionProperties {
  /**
   * The role name.
   */
  roleName?: string;

  /**
   * The role definition description.
   */
  description?: string;

  /**
   * The role type.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type?: string;

  /**
   * Role definition permissions.
   */
  @identifiers(#[])
  permissions?: Permission[];

  /**
   * Role definition assignable scopes.
   */
  assignableScopes?: string[];

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
 * Role Definitions filter
 */
model RoleDefinitionFilter {
  /**
   * Returns role definition with the specific name.
   */
  roleName?: string;

  /**
   * Returns role definition with the specific type.
   */
  type?: string;
}
