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

@@clientName(KeyVault.SASTokenParameter, "SASTokenParameters", "go");
@@clientName(KeyVault.RestoreOperationParameters.sasTokenParameters,
  "SASTokenParameters",
  "go"
);
@@clientName(KeyVault.SelectiveKeyRestoreOperationParameters.sasTokenParameters,
  "SASTokenParameters",
  "go"
);
@@clientName(KeyVault.PreRestoreOperationParameters.sasTokenParameters,
  "SASTokenParameters",
  "go"
);
