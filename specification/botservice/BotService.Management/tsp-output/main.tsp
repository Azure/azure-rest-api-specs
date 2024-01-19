import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Bot.tsp";
import "./BotChannel.tsp";
import "./ConnectionSetting.tsp";
import "./PrivateEndpointConnection.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "Azure Bot Service",
})
@versioned(Versions)
// FIXME: Common type version v1 is not supported for now.
// @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v1)
@doc("Azure Bot Service is a platform for creating smart conversational agents.")
namespace Microsoft.BotService;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2022-09-15 API version.")
  v2022_09_15: "2022-09-15",
}
