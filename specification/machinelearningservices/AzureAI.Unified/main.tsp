import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./assistants/main.tsp";
import "./common/models.tsp";
import "./credentials/models.tsp";
import "./connections/main.tsp";
import "./data/main.tsp";
import "./evaluations/main.tsp";
import "./files/main.tsp";
import "./indexes/main.tsp";
import "./inferencing/main.tsp";
import "./messages/main.tsp";
import "./models/main.tsp";
import "./run_steps/main.tsp";
import "./runs/main.tsp";
import "./streaming/events.tsp";
import "./threads/main.tsp";
import "./tools/models.tsp";
import "./tools/tool_resources.tsp";
import "./vector_stores/main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
      scopes: ["https://ai.azure.com/.default"],
    }
  ]>
)
@service({
  title: "Azure AI Data Plane",
})
@server(
  "{endpoint}/projects/{projectName}",
  "Azure AI Data Plane APIs",
  {
    @doc("""
      Global endpoint in the form of: https://[hub-id]/api.ai.azure.com
      """)
    endpoint: url,

    @doc("The name of the AI project.")
    projectName: string,
  }
)
@versioned(Versions)
namespace Microsoft.MachineLearningServices;

@doc("Azure AI api versions.")
enum Versions {
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("Azure AI api version 2024-11-01-preview.")
  `2024-11-01-preview`,
}
