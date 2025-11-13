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
  interface RoleDefinitions extends KeyVault.RoleDefinitions {}
  interface RoleAssignments extends KeyVault.RoleAssignments {}
}
