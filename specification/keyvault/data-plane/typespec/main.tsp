import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
    title: "KeyVaultClient"
  })
@versioned(Versions)
/**
* The key vault client performs cryptographic key operations and vault operations against the Key Vault service.
*/
namespace KeyVaultClient;

/**
* The available API versions.
*/
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  /**
  * The 7.5 API version.
  */
  v7_5: "7.5",
}