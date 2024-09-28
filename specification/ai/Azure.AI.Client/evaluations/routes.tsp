import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./model.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;

@server(
    "https://{region}.api.azureml.ms/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}",
    "Azure AI Evaluations",
    {
      @doc("The region of the workspace.")
      region: string,

      @doc("The ID of the target subscription.")
      subscriptionId: string,

      @doc("The name of the Resource Group.")
      resourceGroupName: string,

      @doc("The name of the workspace (Azure AI Studio hub).")
      workspaceName: string,
    }
  )
namespace AzureAI.Evaluations {
    @post
    @route("/evaluations/create")
    @doc("Creates an evaluation.")
    op create is Azure.Core.Foundations.Operation<
      {
        @doc("Properties of Evaluation.")
        @body
        evaluation: Evaluation;
      },
      ResourceCreatedResponse<Evaluation>
    >;
}
