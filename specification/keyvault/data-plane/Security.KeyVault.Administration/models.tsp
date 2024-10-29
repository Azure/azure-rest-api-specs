import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

namespace KeyVault;

/**
 * The role definition type.
 */
union RoleDefinitionType {
  string,

  /**
   * Microsoft-defined role definitions.
   */
  `Microsoft.Authorization/roleDefinitions`: "Microsoft.Authorization/roleDefinitions",
}

/**
 * The role type.
 */
union RoleType {
  string,

  /**
   * Built in role.
   */
  BuiltInRole: "AKVBuiltInRole",

  /**
   * Custom role.
   */
  CustomRole: "CustomRole",
}

/**
 * Supported permissions for data actions.
 */
union DataAction {
  string,

  /**
   * Read HSM key metadata.
   */
  ReadHsmKey: "Microsoft.KeyVault/managedHsm/keys/read/action",

  /**
   * Update an HSM key.
   */
  WriteHsmKey: "Microsoft.KeyVault/managedHsm/keys/write/action",

  /**
   * Read deleted HSM key.
   */
  ReadDeletedHsmKey: "Microsoft.KeyVault/managedHsm/keys/deletedKeys/read/action",

  /**
   * Recover deleted HSM key.
   */
  RecoverDeletedHsmKey: "Microsoft.KeyVault/managedHsm/keys/deletedKeys/recover/action",

  /**
   * Backup HSM keys.
   */
  BackupHsmKeys: "Microsoft.KeyVault/managedHsm/keys/backup/action",

  /**
   * Restore HSM keys.
   */
  RestoreHsmKeys: "Microsoft.KeyVault/managedHsm/keys/restore/action",

  /**
   * Delete role assignment.
   */
  DeleteRoleAssignment: "Microsoft.KeyVault/managedHsm/roleAssignments/delete/action",

  /**
   * Get role assignment.
   */
  GetRoleAssignment: "Microsoft.KeyVault/managedHsm/roleAssignments/read/action",

  /**
   * Create or update role assignment.
   */
  WriteRoleAssignment: "Microsoft.KeyVault/managedHsm/roleAssignments/write/action",

  /**
   * Get role definition.
   */
  ReadRoleDefinition: "Microsoft.KeyVault/managedHsm/roleDefinitions/read/action",

  /**
   * Create or update role definition.
   */
  WriteRoleDefinition: "Microsoft.KeyVault/managedHsm/roleDefinitions/write/action",

  /**
   * Delete role definition.
   */
  DeleteRoleDefinition: "Microsoft.KeyVault/managedHsm/roleDefinitions/delete/action",

  /**
   * Encrypt using an HSM key.
   */
  EncryptHsmKey: "Microsoft.KeyVault/managedHsm/keys/encrypt/action",

  /**
   * Decrypt using an HSM key.
   */
  DecryptHsmKey: "Microsoft.KeyVault/managedHsm/keys/decrypt/action",

  /**
   * Wrap using an HSM key.
   */
  WrapHsmKey: "Microsoft.KeyVault/managedHsm/keys/wrap/action",

  /**
   * Unwrap using an HSM key.
   */
  UnwrapHsmKey: "Microsoft.KeyVault/managedHsm/keys/unwrap/action",

  /**
   * Sign using an HSM key.
   */
  SignHsmKey: "Microsoft.KeyVault/managedHsm/keys/sign/action",

  /**
   * Verify using an HSM key.
   */
  VerifyHsmKey: "Microsoft.KeyVault/managedHsm/keys/verify/action",

  /**
   * Create an HSM key.
   */
  CreateHsmKey: "Microsoft.KeyVault/managedHsm/keys/create",

  /**
   * Delete an HSM key.
   */
  DeleteHsmKey: "Microsoft.KeyVault/managedHsm/keys/delete",

  /**
   * Export an HSM key.
   */
  ExportHsmKey: "Microsoft.KeyVault/managedHsm/keys/export/action",

  /**
   * Release an HSM key using Secure Key Release.
   */
  ReleaseKey: "Microsoft.KeyVault/managedHsm/keys/release/action",

  /**
   * Import an HSM key.
   */
  ImportHsmKey: "Microsoft.KeyVault/managedHsm/keys/import/action",

  /**
   * Purge a deleted HSM key.
   */
  PurgeDeletedHsmKey: "Microsoft.KeyVault/managedHsm/keys/deletedKeys/delete",

  /**
   * Download an HSM security domain.
   */
  DownloadHsmSecurityDomain: "Microsoft.KeyVault/managedHsm/securitydomain/download/action",

  /**
   * Check status of HSM security domain download.
   */
  DownloadHsmSecurityDomainStatus: "Microsoft.KeyVault/managedHsm/securitydomain/download/read",

  /**
   * Upload an HSM security domain.
   */
  UploadHsmSecurityDomain: "Microsoft.KeyVault/managedHsm/securitydomain/upload/action",

  /**
   * Check the status of the HSM security domain exchange file.
   */
  ReadHsmSecurityDomainStatus: "Microsoft.KeyVault/managedHsm/securitydomain/upload/read",

  /**
   * Download an HSM security domain transfer key.
   */
  ReadHsmSecurityDomainTransferKey: "Microsoft.KeyVault/managedHsm/securitydomain/transferkey/read",

  /**
   * Start an HSM backup.
   */
  StartHsmBackup: "Microsoft.KeyVault/managedHsm/backup/start/action",

  /**
   * Start an HSM restore.
   */
  StartHsmRestore: "Microsoft.KeyVault/managedHsm/restore/start/action",

  /**
   * Read an HSM backup status.
   */
  ReadHsmBackupStatus: "Microsoft.KeyVault/managedHsm/backup/status/action",

  /**
   * Read an HSM restore status.
   */
  ReadHsmRestoreStatus: "Microsoft.KeyVault/managedHsm/restore/status/action",

  /**
   * Generate random numbers.
   */
  RandomNumbersGenerate: "Microsoft.KeyVault/managedHsm/rng/action",
}

/**
 * The role scope.
 */
union RoleScope {
  string,

  /**
   * Global scope
   */
  Global: "/",

  /**
   * Keys scope
   */
  Keys: "/keys",
}

/**
 * The type specifier of the value.
 */
union SettingTypeEnum {
  string,

  /**
   * A boolean setting value.
   */
  boolean: "boolean",
}

/**
 * An authentication method and location for the operation.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Model name has already shipped"
model SASTokenParameter {
  /**
   * Azure Blob storage container Uri
   */
  storageResourceUri: string;

  /**
   * The SAS token pointing to an Azure Blob storage container
   */
  token?: string;

  /**
   * Indicates which authentication method should be used. If set to true, Managed
   * HSM will use the configured user-assigned managed identity to authenticate with
   * Azure Storage. Otherwise, a SAS token has to be specified.
   */
  useManagedIdentity?: boolean;
}

/**
 * The status of a long-running operation.
 */
@lroStatus
union OperationStatus {
  string,

  /** The operation is in progress. */
  InProgress: "InProgress",

  /** The operation successfully completed. */
  Succeeded: "Succeeded",

  /** The operation was canceled. */
  Canceled: "Canceled",

  /** The operation failed. */
  Failed: "Failed",
}

/**
 * Full backup operation
 */
model FullBackupOperation {
  /**
   * Status of the backup operation.
   */
  status?: OperationStatus;

  /**
   * The status details of backup operation.
   */
  statusDetails?: string;

  /**
   * Error encountered, if any, during the full backup operation.
   */
  error?: Error;

  /**
   * The start time of the backup operation in UTC
   */
  @encode("unixTimestamp", int32)
  startTime?: utcDateTime;

  /**
   * The end time of the backup operation in UTC
   */
  @encode("unixTimestamp", int32)
  endTime?: utcDateTime;

  /**
   * Identifier for the full backup operation.
   */
  jobId?: string;

  /**
   * The Azure blob storage container Uri which contains the full backup
   */
  azureStorageBlobContainerUri?: string;
}

/**
 * The key vault server error.
 */
model Error {
  /**
   * The error code.
   */
  @visibility("read")
  code?: string;

  /**
   * The error message.
   */
  @visibility("read")
  message?: string;

  /**
   * The key vault server error.
   */
  @visibility("read")
  @encodedName("application/json", "innererror")
  innerError?: Error;
}

/**
 * The key vault error exception.
 */
@error
model KeyVaultError {
  /**
   * The key vault server error.
   */
  @visibility("read")
  error?: Error;
}

/**
 * The authentication method and location for the backup operation.
 */
@added(KeyVault.Versions.`v7.6_preview.1`)
model PreBackupOperationParameters {
  /**
   * Azure Blob storage container Uri
   */
  storageResourceUri?: string;

  /**
   * The SAS token pointing to an Azure Blob storage container
   */
  token?: string;

  /**
   * Indicates which authentication method should be used. If set to true, Managed
   * HSM will use the configured user-assigned managed identity to authenticate with
   * Azure Storage. Otherwise, a SAS token has to be specified.
   */
  useManagedIdentity?: boolean;
}

/**
 * The authentication method and location for the restore operation.
 */
@added(KeyVault.Versions.`v7.6_preview.1`)
model PreRestoreOperationParameters {
  /**
   * A user-provided SAS token to an Azure blob storage container.
   */
  sasTokenParameters?: SASTokenParameter;

  /**
   * The Folder name of the blob where the previous successful full backup was stored
   */
  folderToRestore?: string;
}

/**
 * Restore operation
 */
model RestoreOperation {
  /**
   * Status of the restore operation.
   */
  status?: OperationStatus;

  /**
   * The status details of restore operation.
   */
  statusDetails?: string;

  /**
   * Error encountered, if any, during the restore operation.
   */
  error?: Error;

  /**
   * Identifier for the restore operation.
   */
  jobId?: string;

  /**
   * The start time of the restore operation
   */
  @encode("unixTimestamp", int32)
  startTime?: utcDateTime;

  /**
   * The end time of the restore operation
   */
  @encode("unixTimestamp", int32)
  endTime?: utcDateTime;
}

/**
 * The authentication method and location for the restore operation.
 */
model RestoreOperationParameters {
  /**
   * A user-provided SAS token to an Azure blob storage container.
   */
  sasTokenParameters: SASTokenParameter;

  /**
   * The Folder name of the blob where the previous successful full backup was stored
   */
  folderToRestore: string;
}

/**
 * The authentication method and location for the selective key restore operation.
 */
model SelectiveKeyRestoreOperationParameters {
  /**
   * A user-provided SAS token to an Azure blob storage container.
   */
  sasTokenParameters: SASTokenParameter;

  /**
   * The Folder name of the blob where the previous successful full backup was stored
   */
  folder: string;
}

/**
 * Selective Key Restore operation
 */
model SelectiveKeyRestoreOperation {
  /**
   * Status of the restore operation.
   */
  status?: OperationStatus;

  /**
   * The status details of restore operation.
   */
  statusDetails?: string;

  /**
   * Error encountered, if any, during the selective key restore operation.
   */
  error?: Error;

  /**
   * Identifier for the selective key restore operation.
   */
  jobId?: string;

  /**
   * The start time of the restore operation
   */
  @encode("unixTimestamp", int32)
  startTime?: utcDateTime;

  /**
   * The end time of the restore operation
   */
  @encode("unixTimestamp", int32)
  endTime?: utcDateTime;
}

/**
 * Role definition.
 */
model RoleDefinition {
  /**
   * The role definition ID.
   */
  @visibility("read")
  id?: string;

  /**
   * The role definition name.
   */
  @visibility("read")
  name?: string;

  /**
   * The role definition type.
   */
  @visibility("read")
  type?: RoleDefinitionType;

  /**
   * Role definition properties.
   */
  properties?: RoleDefinitionProperties;
}

/**
 * Role definition properties.
 */
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
  @encodedName("application/json", "type")
  roleType?: RoleType;

  /**
   * Role definition permissions.
   */
  permissions?: Permission[];

  /**
   * Role definition assignable scopes.
   */
  assignableScopes?: RoleScope[];
}

/**
 * Role definition permissions.
 */
model Permission {
  /**
   * Action permissions that are granted.
   */
  actions?: string[];

  /**
   * Action permissions that are excluded but not denied. They may be granted by
   * other role definitions assigned to a principal.
   */
  notActions?: string[];

  /**
   * Data action permissions that are granted.
   */
  dataActions?: DataAction[];

  /**
   * Data action permissions that are excluded but not denied. They may be granted
   * by other role definitions assigned to a principal.
   */
  notDataActions?: DataAction[];
}

/**
 * Role definition create parameters.
 */
model RoleDefinitionCreateParameters {
  /**
   * Role definition properties.
   */
  properties: RoleDefinitionProperties;
}

/**
 * Role definition list operation result.
 */
model RoleDefinitionListResult is Azure.Core.Page<RoleDefinition>;

/**
 * Role Assignments
 */
model RoleAssignment {
  /**
   * The role assignment ID.
   */
  @visibility("read")
  id?: string;

  /**
   * The role assignment name.
   */
  @visibility("read")
  name?: string;

  /**
   * The role assignment type.
   */
  @visibility("read")
  type?: string;

  /**
   * Role assignment properties.
   */
  properties?: RoleAssignmentPropertiesWithScope;
}

/**
 * Role assignment properties with scope.
 */
model RoleAssignmentPropertiesWithScope {
  /**
   * The role scope.
   */
  scope?: RoleScope;

  /**
   * The role definition ID.
   */
  roleDefinitionId?: string;

  /**
   * The principal ID.
   */
  principalId?: string;
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
 * Role assignment properties.
 */
model RoleAssignmentProperties {
  /**
   * The role definition ID used in the role assignment.
   */
  roleDefinitionId: string;

  /**
   * The principal ID assigned to the role. This maps to the ID inside the Active
   * Directory. It can point to a user, service principal, or security group.
   */
  principalId: string;
}

/**
 * Role assignment list operation result.
 */
model RoleAssignmentListResult is Azure.Core.Page<RoleAssignment>;

/**
 * The update settings request object.
 */
model UpdateSettingRequest {
  /**
   * The value of the pool setting.
   */
  value: string;
}

/**
 * A Key Vault account setting.
 */
model Setting {
  /**
   * The account setting to be updated
   */
  name: string;

  /**
   * The value of the pool setting.
   */
  value: string;

  /**
   * The type specifier of the value.
   */
  type?: SettingTypeEnum;
}

/**
 * The settings list result.
 */
model SettingsListResult {
  /**
   * A response message containing a list of account settings with their associated
   * value.
   */
  @visibility("read")
  settings?: Setting[];
}

/**
 * The object attributes managed by the KeyVault service.
 */
model Attributes {
  /**
   * Determines whether the object is enabled.
   */
  enabled?: boolean;

  /**
   * Not before date in UTC.
   */
  @encodedName("application/json", "nbf")
  @encode("unixTimestamp", int32)
  notBefore?: utcDateTime;

  /**
   * Expiry date in UTC.
   */
  @encodedName("application/json", "exp")
  @encode("unixTimestamp", int32)
  expires?: utcDateTime;

  /**
   * Creation time in UTC.
   */
  @visibility("read")
  @encode("unixTimestamp", int32)
  created?: utcDateTime;

  /**
   * Last updated time in UTC.
   */
  @visibility("read")
  @encode("unixTimestamp", int32)
  updated?: utcDateTime;
}

/**
 * Role Assignments filter
 */
model RoleAssignmentFilter {
  /**
   * Returns role assignment of the specific principal.
   */
  principalId?: string;
}

/**
 * Role Definitions filter
 */
model RoleDefinitionFilter {
  /**
   * Returns role definition with the specific name.
   */
  roleName?: string;
}
