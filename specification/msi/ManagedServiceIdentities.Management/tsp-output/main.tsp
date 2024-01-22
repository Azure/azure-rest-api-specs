import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./SystemAssignedIdentity.tsp";
import "./Identity.tsp";
import "./FederatedIdentityCredential.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * The Managed Service Identity Client.
 */
@armProviderNamespace
@service({
  title: "ManagedServiceIdentityClient",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v4)
namespace Microsoft.ManagedIdentity;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2023-01-31 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_01_31: "2023-01-31",
}
