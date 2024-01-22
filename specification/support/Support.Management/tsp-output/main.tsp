import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Service.tsp";
import "./ProblemClassification.tsp";
import "./SupportTicketDetails.tsp";
import "./SupportTicketDetails.tsp";
import "./CommunicationDetails.tsp";
import "./CommunicationDetails.tsp";
import "./ChatTranscriptDetails.tsp";
import "./ChatTranscriptDetails.tsp";
import "./FileWorkspaceDetails.tsp";
import "./FileWorkspaceDetails.tsp";
import "./FileDetails.tsp";
import "./FileDetails.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Microsoft Azure Support Resource Provider.
 */
@armProviderNamespace
@service({
  title: "Microsoft.Support",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.Support;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2022-09-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_09_01_preview: "2022-09-01-preview",
}
