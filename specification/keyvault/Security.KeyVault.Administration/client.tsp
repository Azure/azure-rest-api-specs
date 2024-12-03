// client.tsp
import "./administration.tsp";
import "../Security.KeyVault.Common/common.tsp";
import "@azure-tools/typespec-client-generator-core";
using Azure.ClientGenerator.Core;
@TypeSpec.Versioning.useDependency(KeyVault.Versions.`v7.6_preview.1`)
namespace ClientCustomizations;
@@clientName(KeyVault.Setting, "KeyVaultSetting", "csharp");
@@clientName(KeyVault.Setting.value, "Content", "csharp");
@@clientName(KeyVault.Setting.type, "SettingType", "csharp");
@@clientName(KeyVault.SettingTypeEnum, "KeyVaultSettingType", "csharp");
@@clientName(KeyVault.Permission, "KeyVaultPermission", "csharp");
@@clientName(KeyVault.RoleScope, "KeyVaultRoleScope", "csharp");
@@clientName(KeyVault.RoleType, "KeyVaultRoleType", "csharp");
@@clientName(KeyVault.RoleAssignment, "KeyVaultRoleAssignment", "csharp");
@@clientName(KeyVault.FullBackupOperation,
  "FullBackupDetailsInternal",
  "csharp"
);
@@clientName(KeyVault.SettingsListResult, "GetSettingsResult", "csharp");
@@clientName(KeyVault.RoleAssignmentPropertiesWithScope,
  "KeyVaultRoleAssignmentProperties",
  "csharp"
);
@@clientName(KeyVault.RoleDefinitionType,
  "KeyVaultRoleDefinitionType",
  "csharp"
);
@@clientName(KeyVault.Permission, "KeyVaultPermission", "csharp");
@@clientName(Error, "KeyVaultServiceError", "csharp");
@@clientName(KeyVault.DataAction, "KeyVaultDataAction", "csharp");
@@clientName(KeyVault.RestoreOperation, "RestoreDetailsInternal", "csharp");
@@access(KeyVault.RoleAssignmentCreateParameters, Access.internal, "csharp");
@@access(KeyVault.RoleDefinitionCreateParameters, Access.internal, "csharp");
@@access(KeyVault.SASTokenParameter, Access.internal, "csharp");
@@access(KeyVault.SelectiveKeyRestoreOperationParameters,
  Access.internal,
  "csharp"
);
@@access(KeyVault.RoleDefinitionProperties, Access.internal, "csharp");
@client({
  name: "BackupRestoreRestClient",
  service: KeyVault,
})
interface BackupRestoreRestClient {
  fullBackup is KeyVault.fullBackup;
  fullBackupStatus is KeyVault.fullBackupStatus;
  preFullBackup is KeyVault.preFullBackup;
  restoreStatus is KeyVault.restoreStatus;
  preFullRestoreOperation is KeyVault.preFullRestoreOperation;
  fullRestoreOperation is KeyVault.fullRestoreOperation;
  selectiveKeyRestoreOperation is KeyVault.selectiveKeyRestoreOperation;
}
@client({
  name: "RoleAssignmentsRestClient",
  service: KeyVault,
})
interface RoleAssignmentsRestClient {
  delete is KeyVault.RoleAssignments.delete;
  create is KeyVault.RoleAssignments.create;
  get is KeyVault.RoleAssignments.get;
  listForScope is KeyVault.RoleAssignments.listForScope;
}
@client({
  name: "RoleDefinitionsRestClient",
  service: KeyVault,
})
interface RoleDefinitionsRestClient {
  delete is KeyVault.RoleDefinitions.delete;
  createOrUpdate is KeyVault.RoleDefinitions.createOrUpdate;
  get is KeyVault.RoleDefinitions.get;
  list is KeyVault.RoleDefinitions.list;
}
@client({
  name: "SettingsRestClient",
  service: KeyVault,
})
interface SettingsRestClient {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  updateSetting is KeyVault.updateSetting;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getSetting is KeyVault.getSetting;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getSettings is KeyVault.getSettings;
}
