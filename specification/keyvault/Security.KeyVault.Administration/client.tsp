// client.tsp
import "./administration.tsp";
import "../Security.KeyVault.Common/common.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@TypeSpec.Versioning.useDependency(KeyVault.Versions.`v7.6_preview.2`)
namespace ClientCustomizations;

//Java customizations
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
  @operationGroup
    interface RoleDefinitions{
        #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
        deleteRoleDefinition is KeyVault.RoleDefinitions.delete;
        #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
        createOrUpdateRoleDefinition is KeyVault.RoleDefinitions.createOrUpdate;
        #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
        getRoleDefinition is KeyVault.RoleDefinitions.get;
        #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
        listRoleDefinitions is KeyVault.RoleDefinitions.list;
    }
  @operationGroup
    interface RoleAssignments{
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
        name: "KeyVaultClient",
        service: KeyVault,
        }, 
        "csharp")
      interface KeyVaultClient {
        #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
        fullBackup is KeyVault.fullBackup;
        #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
        fullRestore is KeyVault.fullRestoreOperation;
        #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
        fullBackupStatus is KeyVault.fullBackupStatus;
        #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
        preFullBackup is KeyVault.preFullBackup;
        #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
        restoreStatus is KeyVault.restoreStatus;
        #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
        preFullRestore is KeyVault.preFullRestoreOperation;
        #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
        selectiveKeyRestoreStatus is KeyVault.selectiveKeyRestoreStatus;
        #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
        selectiveKeyRestore is KeyVault.selectiveKeyRestoreOperation;
        #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
        updateSetting is KeyVault.updateSetting;
        #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
        getSetting is KeyVault.getSetting;
        #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
        getSettings is KeyVault.getSettings;
      }

@@access(KeyVault, Access.internal, "csharp");
@@access(KeyVault.fullBackup, Access.internal, "csharp");

@@clientName(KeyVault.Setting.type, "SettingType", "csharp");
@@clientName(KeyVault.Setting.value, "Content", "csharp");
@@access(KeyVault, Access.internal, "csharp");
@@clientName(KeyVaultError, "KeyVaultServiceError", "csharp");

// JavaScript customizations
@@clientName(KeyVault.FullBackupOperation.azureStorageBlobContainerUri,
  "folderUri",
  "javascript"
);
