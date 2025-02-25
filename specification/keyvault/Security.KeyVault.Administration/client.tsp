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
@@clientName(KeyVault.Setting.type, "SettingType", "csharp");
@@clientName(KeyVault.Setting.value, "Content", "csharp");
@@access(KeyVault, Access.internal, "csharp");

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

// JavaScript customizations
@@clientName(KeyVault.FullBackupOperation.azureStorageBlobContainerUri,
  "folderUri",
  "javascript"
);
