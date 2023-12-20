import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./SupportAzureService.tsp";
import "./ProblemClassification.tsp";
import "./SubscriptionSupportTicket.tsp";
import "./TenantSupportTicket.tsp";
import "./SupportTicketCommunication.tsp";
import "./SupportTicketNoSubCommunication.tsp";
import "./SupportTicketChatTranscript.tsp";
import "./SupportTicketNoSubChatTranscript.tsp";
import "./SubscriptionFileWorkspace.tsp";
import "./TenantFileWorkspace.tsp";
import "./SupportTicketFile.tsp";
import "./SupportTicketNoSubFile.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "Microsoft.Support",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
@doc("Microsoft Azure Support Resource Provider.")
namespace Azure.ResourceManager.Support;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_09_01_preview: "2022-09-01-preview",
}
