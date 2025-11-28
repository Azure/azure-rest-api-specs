import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.BotService;

interface QnAMakerEndpointKeysOperations {
  @doc("Lists the QnA Maker endpoint keys")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.BotService/listQnAMakerEndpointKeys")
  @post
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;

      @doc("The request body parameters to provide for the check name availability request")
      @body
      parameters: QnAMakerEndpointKeysRequestBody;
    },
    QnAMakerEndpointKeysResponse
  >;
}

interface HostSettingsOperations {
  @doc("Get per subscription settings needed to host bot in compute resource such as Azure App Service")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.BotService/hostSettings")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;
    },
    HostSettingsResponse
  >;
}

interface OperationResultsOperations {
  @doc("Get the operation result for a long running operation.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.BotService/operationresults/{operationResultId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;

      @doc("The ID of the operation result to get.")
      @path
      operationResultId: string;
    },
    OperationResultsDescription | void
  >;
}
