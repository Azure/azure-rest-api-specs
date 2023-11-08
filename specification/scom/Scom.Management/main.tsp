import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./ManagedInstance.tsp";
import "./MonitoredResource.tsp";
import "./ManagedGateway.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

/** Azure Monitor Operations Manager Managed Instance (SCOM MI) management APIs */
@armProviderNamespace
@service({
  title: "Azure API for managing SCOM managed instances and monitored resources.",
})
@versioned(Versions)
namespace Microsoft.Scom;

/** The available API versions. */
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_07_07_preview: "2023-07-07-preview",
}
