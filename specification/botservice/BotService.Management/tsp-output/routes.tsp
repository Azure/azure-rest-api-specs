import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.BotService;

interface QnAMakerEndpointKeysOperations {
  @doc("Lists the QnA Maker endpoint keys")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.BotService/listQnAMakerEndpointKeys")
  @post
  get is Azure.Core.Foundations.Operation<
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
  get is Azure.Core.Foundations.Operation<
    {
      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;
    },
    HostSettingsResponse
  >;
}
