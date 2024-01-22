import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./SignalRResource.tsp";
import "./CustomCertificate.tsp";
import "./CustomDomain.tsp";
import "./PrivateEndpointConnection.tsp";
import "./SharedPrivateLinkResource.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * REST API for Azure SignalR Service
 */
@armProviderNamespace
@service({
  title: "SignalRManagementClient",
})
@versioned(Versions)
// FIXME: Common type version v2 is not supported for now.
// @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v2)
namespace Microsoft.SignalRService;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2022-02-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_02_01: "2022-02-01",
}
