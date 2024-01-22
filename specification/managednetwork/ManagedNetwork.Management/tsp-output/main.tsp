import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./ManagedNetwork.tsp";
import "./ScopeAssignment.tsp";
import "./ManagedNetworkGroup.tsp";
import "./ManagedNetworkPeeringPolicy.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * The Microsoft Azure Managed Network management API provides a RESTful set of web services that interact with Microsoft Azure Networks service to programmatically view, control, change, and monitor your entire Azure network centrally and with ease.
 */
@armProviderNamespace
@service({
  title: "ManagedNetworkManagementClient",
})
@versioned(Versions)
namespace Microsoft.ManagedNetwork;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2019-06-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2019_06_01_preview: "2019-06-01-preview",
}
