import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Bot.tsp";
import "./BotChannel.tsp";
import "./ConnectionSetting.tsp";
import "./AzureBotServicePrivateEndpointConnection.tsp";
import "./NetworkSecurityPerimeterConfiguration.tsp";
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
@doc("Azure Bot Service is a platform for creating smart conversational agents.")
namespace Microsoft.BotService;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_09_15_preview: "2023-09-15-preview",
}
