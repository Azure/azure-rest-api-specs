import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Http;

namespace KeyVault;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
interface RoleDefinitions {
  /**
   * Deletes a custom role definition.
   */
  @route("/{+scope}/providers/Microsoft.Authorization/roleDefinitions/{roleDefinitionName}")
  @delete
  delete is KeyVaultOperation<
    {
      /**
       * The scope of the role definition to delete. Managed HSM only supports '/'.
       */
      scope: string;

      /**
       * The name (GUID) of the role definition to delete.
       */
      @path
      roleDefinitionName: string;
    },
    RoleDefinition
  >;

  /**
   * Creates or updates a custom role definition.
   */
  @route("/{+scope}/providers/Microsoft.Authorization/roleDefinitions/{roleDefinitionName}")
  @put
  createOrUpdate is KeyVaultOperation<
    {
      /**
       * The scope of the role definition to create or update. Managed HSM only supports '/'.
       */
      scope: string;

      /**
       * The name of the role definition to create or update. It can be any valid GUID.
       */
      @path
      roleDefinitionName: string;

      /**
       * Parameters for the role definition.
       */
      @body
      parameters: RoleDefinitionCreateParameters;
    },
    CreatedResponse & RoleDefinition
  >;

  /**
   * Get the specified role definition.
   */
  @route("/{+scope}/providers/Microsoft.Authorization/roleDefinitions/{roleDefinitionName}")
  @get
  get is KeyVaultOperation<
    {
      /**
       * The scope of the role definition to get. Managed HSM only supports '/'.
       */
      scope: string;

      /**
       * The name of the role definition to get.
       */
      @path
      roleDefinitionName: string;
    },
    RoleDefinition
  >;

  /**
   * Get all role definitions that are applicable at scope and above.
   */
  @route("/{+scope}/providers/Microsoft.Authorization/roleDefinitions")
  @get
  list is KeyVaultOperation<
    {
      /**
       * The scope of the role definition.
       */
      scope: string;

      /**
       * The filter to apply on the operation. Use atScopeAndBelow filter to search below the given scope as well.
       */
      @query("$filter")
      $filter?: string;
    },
    RoleDefinitionListResult
  >;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
interface RoleAssignments {
  /**
   * Deletes a role assignment.
   */
  @route("/{+scope}/providers/Microsoft.Authorization/roleAssignments/{roleAssignmentName}")
  @delete
  delete is KeyVaultOperation<
    {
      /**
       * The scope of the role assignment to delete.
       */
      scope: string;

      /**
       * The name of the role assignment to delete.
       */
      @path
      roleAssignmentName: string;
    },
    RoleAssignment
  >;

  /**
   * Creates a role assignment.
   */
  @route("/{+scope}/providers/Microsoft.Authorization/roleAssignments/{roleAssignmentName}")
  @put
  create is KeyVaultOperation<
    {
      /**
       * The scope of the role assignment to create.
       */
      scope: string;

      /**
       * The name of the role assignment to create. It can be any valid GUID.
       */
      @path
      roleAssignmentName: string;

      /**
       * Parameters for the role assignment.
       */
      @body
      parameters: RoleAssignmentCreateParameters;
    },
    CreatedResponse & RoleAssignment
  >;

  /**
   * Get the specified role assignment.
   */
  @route("/{+scope}/providers/Microsoft.Authorization/roleAssignments/{roleAssignmentName}")
  @get
  get is KeyVaultOperation<
    {
      /**
       * The scope of the role assignment.
       */
      scope: string;

      /**
       * The name of the role assignment to get.
       */
      @path
      roleAssignmentName: string;
    },
    RoleAssignment
  >;

  /**
   * Gets role assignments for a scope.
   */
  @route("/{+scope}/providers/Microsoft.Authorization/roleAssignments")
  @get
  listForScope is KeyVaultOperation<
    {
      /**
       * The scope of the role assignments.
       */
      scope: string;

      /**
       * The filter to apply on the operation. Use $filter=atScope() to return all role assignments at or above the scope. Use $filter=principalId eq {id} to return all role assignments at, above or below the scope for the specified principal.
       */
      @query("$filter")
      $filter?: string;
    },
    RoleAssignmentListResult
  >;
}
