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
namespace SettingsClient {
  op updateSetting is KeyVault.updateSetting;
  op getSetting is KeyVault.getSetting;
  op getSettings is KeyVault.getSettings;
}
