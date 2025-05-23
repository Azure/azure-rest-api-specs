// client.tsp
import "./administration.tsp";
import "../Security.KeyVault.Common/common.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@TypeSpec.Versioning.useDependency(KeyVault.Versions.`v7.6_preview.2`)
namespace ClientCustomizations;

//Java customizations
@@clientName(KeyVault, "KeyVaultAdministration", "java");
@@clientName(KeyVault.DataAction, "KeyVaultDataAction", "java");
@@clientName(KeyVault.RoleDefinitionType, "KeyVaultRoleDefinitionType", "java");
@@clientName(KeyVault.RoleType, "KeyVaultRoleType", "java");
@@clientName(KeyVault.RoleScope, "KeyVaultRoleScope", "java");
@@clientName(KeyVault.SettingTypeEnum, "KeyVaultSettingType", "java");

//C# customizations
@client(
  {
    name: "KeyVaultAccessControlRestClient",
    service: KeyVault,
  },
  "csharp"
)
interface KeyVaultAccessControlRestClient {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deleteRoleDefinition is KeyVault.RoleDefinitions.delete;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  createOrUpdateRoleDefinition is KeyVault.RoleDefinitions.createOrUpdate;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getRoleDefinition is KeyVault.RoleDefinitions.get;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  listRoleDefinitions is KeyVault.RoleDefinitions.list;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deleteRoleAssignment is KeyVault.RoleAssignments.delete;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  createRoleAssignment is KeyVault.RoleAssignments.create;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getRoleAssignment is KeyVault.RoleAssignments.get;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  listRoleAssignments is KeyVault.RoleAssignments.listForScope;
}

@client(
  {
    name: "KeyVaultRestClient",
    service: KeyVault,
  },
  "csharp"
)
interface KeyVaultClient {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  fullBackup is KeyVault.fullBackup;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  preFullBackup is KeyVault.preFullBackup;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  fullRestoreOperation is KeyVault.fullRestoreOperation;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  preFullRestoreOperation is KeyVault.preFullRestoreOperation;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
  fullBackupStatus is KeyVault.fullBackupStatus;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
  restoreStatus is KeyVault.restoreStatus;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
  selectiveKeyRestoreStatus is KeyVault.selectiveKeyRestoreStatus;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  selectiveKeyRestoreOperation is KeyVault.selectiveKeyRestoreOperation;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  updateSetting is KeyVault.updateSetting;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getSetting is KeyVault.getSetting;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getSettings is KeyVault.getSettings;
}

@@access(KeyVault.fullBackup, Access.internal, "csharp");
@@access(KeyVault.fullRestoreOperation, Access.internal, "csharp");
@@access(KeyVault.fullBackupStatus, Access.internal, "csharp");
@@access(KeyVault.preFullBackup, Access.internal, "csharp");
@@access(KeyVault.restoreStatus, Access.internal, "csharp");
@@access(KeyVault.preFullRestoreOperation, Access.internal, "csharp");
@@access(KeyVault.selectiveKeyRestoreStatus, Access.internal, "csharp");
@@access(KeyVault.selectiveKeyRestoreOperation, Access.internal, "csharp");
@@access(KeyVault.updateSetting, Access.internal, "csharp");
@@access(KeyVault.getSetting, Access.internal, "csharp");
@@access(KeyVault.getSettings, Access.internal, "csharp");

@@access(KeyVault.RoleDefinitions.delete, Access.internal, "csharp");
@@access(KeyVault.RoleDefinitions.createOrUpdate, Access.internal, "csharp");
@@access(KeyVault.RoleDefinitions.get, Access.internal, "csharp");
@@access(KeyVault.RoleDefinitions.list, Access.internal, "csharp");
@@access(KeyVault.RoleAssignments.delete, Access.internal, "csharp");
@@access(KeyVault.RoleAssignments.create, Access.internal, "csharp");
@@access(KeyVault.RoleAssignments.get, Access.internal, "csharp");
@@access(KeyVault.RoleAssignments.listForScope, Access.internal, "csharp");

@@clientName(KeyVault.Setting.type, "SettingType", "csharp");
@@clientName(KeyVault.Setting.value, "Content", "csharp");
@@access(KeyVault, Access.internal, "csharp");

// JavaScript customizations
@@clientName(KeyVault.FullBackupOperation.azureStorageBlobContainerUri,
  "folderUri",
  "javascript"
);
