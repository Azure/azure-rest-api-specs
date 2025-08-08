import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "../Security.KeyVault.Common/common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;
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
 * Role definition.
 */
model RoleDefinition {
  /**
   * The role definition ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The role definition name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The role definition type.
   */
  @visibility(Lifecycle.Read)
  type?: RoleDefinitionType;

  /**
   * Role definition properties.
   */
  #suppress "deprecated" "Property flattening is necessary for Key Vault"
  @flattenProperty
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
   * Action permissions that are excluded but not denied. They may be granted by other role definitions assigned to a principal.
   */
  notActions?: string[];

  /**
   * Data action permissions that are granted.
   */
  dataActions?: DataAction[];

  /**
   * Data action permissions that are excluded but not denied. They may be granted by other role definitions assigned to a principal.
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
@pagedResult
model RoleDefinitionListResult {
  /**
   * Role definition list.
   */
  @items
  value?: RoleDefinition[];

  /**
   * The URL to use for getting the next set of results.
   */
  @TypeSpec.nextLink
  nextLink?: string;
}

/**
 * Role Assignments
 */
model RoleAssignment {
  /**
   * The role assignment ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The role assignment name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The role assignment type.
   */
  @visibility(Lifecycle.Read)
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
   * The principal ID assigned to the role. This maps to the ID inside the Active Directory. It can point to a user, service principal, or security group.
   */
  principalId: string;
}

/**
 * Role assignment list operation result.
 */
@pagedResult
model RoleAssignmentListResult {
  /**
   * Role assignment list.
   */
  @items
  value?: RoleAssignment[];

  /**
   * The URL to use for getting the next set of results.
   */
  @TypeSpec.nextLink
  nextLink?: string;
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
