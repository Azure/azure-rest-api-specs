import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@TypeSpec.Versioning.useDependency(KeyVault.Versions.`v7.5`)
namespace ClientCustomizations;

@client({
  name: "Client",
  service: KeyVault,
})

interface Client {
  FullBackup is KeyVault.fullBackup;
  FullRestore is KeyVault.fullRestoreOperation;
  SelectiveKeyRestore is KeyVault.selectiveKeyRestoreOperation;
}

@@clientName(KeyVault.SASTokenParameter, "SASTokenParameters", "go");
@@clientName(KeyVault.RestoreOperationParameters.sasTokenParameters, "SASTokenParameters", "go");
@@clientName(KeyVault.SelectiveKeyRestoreOperationParameters.sasTokenParameters, "SASTokenParameters", "go");
