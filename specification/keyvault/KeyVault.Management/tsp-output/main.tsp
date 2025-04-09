import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Vault.tsp";
import "./DeletedVault.tsp";
import "./PrivateEndpointConnection.tsp";
import "./ManagedHsm.tsp";
import "./DeletedManagedHsm.tsp";
import "./MhsmPrivateEndpointConnection.tsp";
import "./Secret.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * The Azure management API provides a RESTful set of web services that interact with Azure Key Vault.
 */
@armProviderNamespace
@service({
  title: "KeyVaultManagementClient",
})
@versioned(Versions)
namespace Microsoft.KeyVault;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2023-02-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_02_01: "2023-02-01",
}
