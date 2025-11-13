// client.tsp
import "../../administration.tsp";
import "../../../Security.KeyVault.Common/common.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@TypeSpec.Versioning.useDependency(KeyVault.Versions.`v7.6_preview.2`)
namespace ClientCustomizations;

@client(
  {
    name: "KeyVaultClient",
    service: KeyVault,
  },
  "go"
)
namespace BackupRestoreClient {
  op fullBackupStatus is KeyVault.fullBackupStatus;
  op fullBackup is KeyVault.fullBackup;
  op preFullBackup is KeyVault.preFullBackup;
  op restoreStatus is KeyVault.restoreStatus;
  op preFullRestoreOperation is KeyVault.preFullRestoreOperation;
  op selectiveKeyRestoreStatus is KeyVault.selectiveKeyRestoreStatus;
  op selectiveKeyRestoreOperation is KeyVault.selectiveKeyRestoreOperation;
}
