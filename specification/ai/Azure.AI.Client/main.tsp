import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./endpoints/routes.tsp";
import "./agents/routes.tsp";
import "./evaluations/routes.tsp";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

#suppress "@azure-tools/typespec-azure-core/casing-style"
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
      scopes: ["https://management.azure.com/.default"],
    }
  ]>
)
@service({
  title: "Azure AI",
})
@versioned(Versions)
@clientName("MyClient")
namespace AzureAI {
  @doc("Azure AI API versions")
  enum Versions {
    @doc("Azure AI API version 2024-07-01-preview.")
    @useDependency(Azure.Core.Versions.v1_0_Preview_2)
    `2024-07-01-preview`,
  }

  using AzureAI.Evaluations;
  using AzureAI.Agents;
}
