// client.tsp
import "./administration.tsp";
import "../Security.KeyVault.Common/common.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@TypeSpec.Versioning.useDependency(KeyVault.Versions.`v7.6_preview.1`)
namespace ClientCustomizations;

//Java customizations
@@clientName(KeyVault.DataAction, "KeyVaultDataAction", "java");
@@clientName(KeyVault.RoleDefinitionType, "KeyVaultRoleDefinitionType", "java");
@@clientName(KeyVault.RoleType, "KeyVaultRoleType", "java");
@@clientName(KeyVault.RoleScope, "KeyVaultRoleScope", "java");
@@clientName(KeyVault.SettingTypeEnum, "KeyVaultSettingType", "java");

//C# customizations
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

@@clientName(KeyVault.FullBackupOperation.azureStorageBlobContainerUri,
  "folderUri",
  "javascript"
);

@client(
  {
    name: "BackupRestoreRestClient",
    service: KeyVault,
  },
  "csharp"
)
interface BackupRestoreRestClient {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  fullBackup is KeyVault.fullBackup;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name has already shipped"
  fullBackupStatus is KeyVault.fullBackupStatus;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  preFullBackup is KeyVault.preFullBackup;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name has already shipped"
  restoreStatus is KeyVault.restoreStatus;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  preFullRestoreOperation is KeyVault.preFullRestoreOperation;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  fullRestoreOperation is KeyVault.fullRestoreOperation;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  selectiveKeyRestoreOperation is KeyVault.selectiveKeyRestoreOperation;
}

@client(
  {
    name: "RoleAssignmentsRestClient",
    service: KeyVault,
  },
  "csharp"
)
interface RoleAssignmentsRestClient {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  delete is KeyVault.RoleAssignments.delete;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  create is KeyVault.RoleAssignments.create;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  get is KeyVault.RoleAssignments.get;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  listForScope is KeyVault.RoleAssignments.listForScope;
}

@client(
  {
    name: "RoleDefinitionsRestClient",
    service: KeyVault,
  },
  "csharp"
)
interface RoleDefinitionsRestClient {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  delete is KeyVault.RoleDefinitions.delete;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  createOrUpdate is KeyVault.RoleDefinitions.createOrUpdate;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  get is KeyVault.RoleDefinitions.get;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  list is KeyVault.RoleDefinitions.list;
}

@client(
  {
    name: "SettingsRestClient",
    service: KeyVault,
  },
  "csharp"
)
interface SettingsRestClient {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  updateSetting is KeyVault.updateSetting;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getSetting is KeyVault.getSetting;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getSettings is KeyVault.getSettings;
}
