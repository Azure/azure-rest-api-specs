import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@TypeSpec.Versioning.useDependency(KeyVault.Versions.`v7.5`)
namespace ClientCustomizations;

@client(
  {
    name: "Client",
    service: KeyVault,
  },
  "go"
)
interface Client {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  fullBackup is KeyVault.fullBackup;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  fullRestore is KeyVault.fullRestoreOperation;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  selectiveKeyRestore is KeyVault.selectiveKeyRestoreOperation;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  preFullBackup is KeyVault.preFullBackup;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  preFullRestore is KeyVault.preFullRestoreOperation;
}

using KeyVault;

@@clientName(SASTokenParameter, "SASTokenParameters", "go");
@@clientName(RestoreOperationParameters.sasTokenParameters,
  "SASTokenParameters",
  "go"
);
@@clientName(SelectiveKeyRestoreOperationParameters.sasTokenParameters,
  "SASTokenParameters",
  "go"
);
@@clientName(PreRestoreOperationParameters.sasTokenParameters,
  "SASTokenParameters",
  "go"
);

@@alternateType(FullBackupOperation.status, string, "go");
@@alternateType(RestoreOperation.status, string, "go");
@@alternateType(SelectiveKeyRestoreOperation.status, string, "go");
@@alternateType(FullBackupOperation.error, string, "go");
@@alternateType(RestoreOperation.error, string, "go");
@@alternateType(SelectiveKeyRestoreOperation.error, string, "go");
