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

// JavaScript customizations
@@clientName(KeyVault.FullBackupOperation.azureStorageBlobContainerUri,
  "folderUri",
  "javascript"
);
