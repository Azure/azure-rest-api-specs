import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace KeyVaultClient;

/**
 * Creates a full backup using a user-provided SAS token to an Azure blob storage
 * container.
 */
@route("/backup")
@post
op fullBackup is Azure.Core.Foundations.Operation<
  SASTokenParameter,
  FullBackupOperation
>;

/**
 * Pre-backup operation for checking whether the customer can perform a full
 * backup operation.
 */
@route("/prebackup")
@post
op preFullBackup is Azure.Core.Foundations.Operation<
  PreBackupOperationParameters,
  FullBackupOperation
>;

/**
 * Returns the status of full backup operation
 */
@route("/backup/{jobId}/pending")
@get
op fullBackupStatus is Azure.Core.Foundations.Operation<
  {
    /**
     * The id returned as part of the backup request
     */
    @path
    jobId: string;
  },
  FullBackupOperation
>;

/**
 * Pre-restore operation for checking whether the customer can perform a full
 * restore operation.
 */
@route("/prerestore")
@put
op preFullRestoreOperation is Azure.Core.Foundations.Operation<
  PreRestoreOperationParameters,
  RestoreOperation
>;

/**
 * Restores all key materials using the SAS token pointing to a previously stored
 * Azure Blob storage backup folder
 */
@route("/restore")
@put
op fullRestoreOperation is Azure.Core.Foundations.Operation<
  RestoreOperationParameters,
  RestoreOperation
>;

/**
 * Returns the status of restore operation
 */
@route("/restore/{jobId}/pending")
@get
op restoreStatus is Azure.Core.Foundations.Operation<
  {
    /**
     * The Job Id returned part of the restore operation
     */
    @path
    jobId: string;
  },
  RestoreOperation
>;

/**
 * Restores all key versions of a given key using user supplied SAS token pointing
 * to a previously stored Azure Blob storage backup folder
 */
@route("/keys/{keyName}/restore")
@put
op selectiveKeyRestoreOperation is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the key to be restored from the user supplied backup
     */
    @path
    keyName: string;

    /**
     * The Azure blob SAS token pointing to a folder where the previous successful
     * full backup was stored
     */
    @body
    restoreBlobDetails?: SelectiveKeyRestoreOperationParameters;
  },
  SelectiveKeyRestoreOperation
>;

/**
 * Description of the pool setting to be updated
 */
@summary("""
  Updates key vault account setting, stores it, then returns the setting name and
  value to the client.
  """)
@route("/settings/{setting-name}")
@patch
op updateSetting is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the account setting. Must be a valid settings option.
     */
    @path
    `setting-name`: string;

    /**
     * The parameters to update an account setting.
     */
    @body
    parameters: UpdateSettingRequest;
  },
  Setting
>;

/**
 * Retrieves the setting object of a specified setting name.
 */
@summary("Get specified account setting object.")
@route("/settings/{setting-name}")
@get
op getSetting is Azure.Core.Foundations.Operation<
  {
    /**
     * The name of the account setting. Must be a valid settings option.
     */
    @path
    `setting-name`: string;
  },
  Setting
>;

/**
 * Retrieves a list of all the available account settings that can be configured.
 */
@summary("List account settings.")
@route("/settings")
@get
op getSettings is Azure.Core.Foundations.Operation<{}, SettingsListResult>;

interface RoleDefinitionsOperations {
  /**
   * Deletes a custom role definition.
   */
  @route("/{scope}/providers/Microsoft.Authorization/roleDefinitions/{roleDefinitionName}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * The scope of the role definition to delete. Managed HSM only supports '/'.
       */
      @path
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
  @route("/{scope}/providers/Microsoft.Authorization/roleDefinitions/{roleDefinitionName}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      /**
       * The scope of the role definition to create or update. Managed HSM only supports
       * '/'.
       */
      @path
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
    RoleDefinition
  >;

  /**
   * Get the specified role definition.
   */
  @route("/{scope}/providers/Microsoft.Authorization/roleDefinitions/{roleDefinitionName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The scope of the role definition to get. Managed HSM only supports '/'.
       */
      @path
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
  @route("/{scope}/providers/Microsoft.Authorization/roleDefinitions")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The scope of the role definition.
       */
      @path
      scope: string;

      /**
       * The filter to apply on the operation. Use atScopeAndBelow filter to search
       * below the given scope as well.
       */
      @query("$filter")
      $filter?: string;
    },
    RoleDefinitionListResult
  >;
}

interface RoleAssignmentsOperations {
  /**
   * Deletes a role assignment.
   */
  @route("/{scope}/providers/Microsoft.Authorization/roleAssignments/{roleAssignmentName}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * The scope of the role assignment to delete.
       */
      @path
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
  @route("/{scope}/providers/Microsoft.Authorization/roleAssignments/{roleAssignmentName}")
  @put
  create is Azure.Core.Foundations.Operation<
    {
      /**
       * The scope of the role assignment to create.
       */
      @path
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
    RoleAssignment
  >;

  /**
   * Get the specified role assignment.
   */
  @route("/{scope}/providers/Microsoft.Authorization/roleAssignments/{roleAssignmentName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The scope of the role assignment.
       */
      @path
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
  @route("/{scope}/providers/Microsoft.Authorization/roleAssignments")
  @get
  listForScope is Azure.Core.Foundations.Operation<
    {
      /**
       * The scope of the role assignments.
       */
      @path
      scope: string;

      /**
       * The filter to apply on the operation. Use $filter=atScope() to return all role
       * assignments at or above the scope. Use $filter=principalId eq {id} to return
       * all role assignments at, above or below the scope for the specified principal.
       */
      @query("$filter")
      $filter?: string;
    },
    RoleAssignmentListResult
  >;
}
