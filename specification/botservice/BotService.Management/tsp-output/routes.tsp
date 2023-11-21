import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace AzureBotService;

interface BotsOperations {
  @doc("Creates a Bot Service. Bot Service is a resource group wide resource type.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BotService/botServices/{resourceName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the Bot resource group in the user subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Bot resource.")
      @path
      resourceName: string;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;

      @doc("The parameters to provide for the created bot.")
      @body
      parameters: Bot;
    },
    Bot
  >;

  @doc("Updates a Bot Service")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BotService/botServices/{resourceName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the Bot resource group in the user subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Bot resource.")
      @path
      resourceName: string;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;

      @doc("The parameters to provide for the created bot.")
      @body
      parameters: Bot;
    },
    Bot
  >;

  @doc("Deletes a Bot Service from the resource group. ")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BotService/botServices/{resourceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the Bot resource group in the user subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Bot resource.")
      @path
      resourceName: string;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Returns a BotService specified by the parameters.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BotService/botServices/{resourceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the Bot resource group in the user subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Bot resource.")
      @path
      resourceName: string;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;
    },
    Bot
  >;

  @doc("Returns all the resources of a particular type belonging to a resource group")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BotService/botServices")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the Bot resource group in the user subscription.")
      @path
      resourceGroupName: string;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;
    },
    BotResponseList
  >;

  @doc("Returns all the resources of a particular type belonging to a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.BotService/botServices")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;
    },
    BotResponseList
  >;

  @doc("Check whether a bot name is available.")
  @route("/providers/Microsoft.BotService/checkNameAvailability")
  @post
  GetCheckNameAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("The request body parameters to provide for the check name availability request")
      @body
      parameters: CheckNameAvailabilityRequestBody;
    },
    CheckNameAvailabilityResponseBody
  >;
}

interface ChannelsOperations {
  @doc("Creates a Channel registration for a Bot Service")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BotService/botServices/{resourceName}/channels/{channelName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the Bot resource group in the user subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Bot resource.")
      @path
      resourceName: string;

      @doc("The name of the Channel resource.")
      @path
      channelName: ChannelName;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;

      @doc("The parameters to provide for the created bot.")
      @body
      parameters: BotChannel;
    },
    BotChannel
  >;

  @doc("Updates a Channel registration for a Bot Service")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BotService/botServices/{resourceName}/channels/{channelName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the Bot resource group in the user subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Bot resource.")
      @path
      resourceName: string;

      @doc("The name of the Channel resource.")
      @path
      channelName: ChannelName;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;

      @doc("The parameters to provide for the created bot.")
      @body
      parameters: BotChannel;
    },
    BotChannel
  >;

  @doc("Deletes a Channel registration from a Bot Service")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BotService/botServices/{resourceName}/channels/{channelName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the Bot resource group in the user subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Bot resource.")
      @path
      resourceName: string;

      @doc("The name of the Bot resource.")
      @path
      channelName: string;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Returns a BotService Channel registration specified by the parameters.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BotService/botServices/{resourceName}/channels/{channelName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the Bot resource group in the user subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Bot resource.")
      @path
      resourceName: string;

      @doc("The name of the Bot resource.")
      @path
      channelName: string;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;
    },
    BotChannel
  >;

  @doc("Lists a Channel registration for a Bot Service including secrets")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BotService/botServices/{resourceName}/channels/{channelName}/listChannelWithKeys")
  @post
  ListWithKeys is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the Bot resource group in the user subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Bot resource.")
      @path
      resourceName: string;

      @doc("The name of the Channel resource.")
      @path
      channelName: ChannelName;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;
    },
    ListChannelWithKeysResponse
  >;

  @doc("Returns all the Channel registrations of a particular BotService resource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BotService/botServices/{resourceName}/channels")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the Bot resource group in the user subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Bot resource.")
      @path
      resourceName: string;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;
    },
    ChannelResponseList
  >;
}

interface DirectLineOperations {
  @doc("""
Regenerates secret keys and returns them for the DirectLine Channel of a
particular BotService resource
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BotService/botServices/{resourceName}/channels/{channelName}/regeneratekeys")
  @post
  RegenerateKeys is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the Bot resource group in the user subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Bot resource.")
      @path
      resourceName: string;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;

      @doc("The name of the Channel resource for which keys are to be regenerated.")
      @path
      channelName: RegenerateKeysChannelName;

      @doc("The parameters to provide for the created bot.")
      @body
      parameters: SiteInfo;
    },
    BotChannel
  >;
}

interface EmailOperations {
  @doc("Creates an email channel sign in url for a Bot Service")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BotService/botServices/{resourceName}/createEmailSignInUrl")
  @post
  CreateSignInUrl is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the Bot resource group in the user subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Bot resource.")
      @path
      resourceName: string;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;
    },
    CreateEmailSignInUrlResponse
  >;
}

interface OperationsOperations {
  @doc("Lists all the available BotService operations.")
  @route("/providers/Microsoft.BotService/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationEntityListResult>;
}

interface BotConnectionOperations {
  @doc("Lists the available Service Providers for creating Connection Settings")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.BotService/listAuthServiceProviders")
  @post
  ListServiceProviders is Azure.Core.Foundations.Operation<
    {
      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;
    },
    ServiceProviderResponseList
  >;

  @doc("Get a Connection Setting registration for a Bot Service")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BotService/botServices/{resourceName}/connections/{connectionName}/listWithSecrets")
  @post
  ListWithSecrets is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the Bot resource group in the user subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Bot resource.")
      @path
      resourceName: string;

      @doc("The name of the Bot Service Connection Setting resource.")
      @path
      connectionName: string;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;
    },
    ConnectionSetting
  >;

  @doc("Register a new Auth Connection for a Bot Service")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BotService/botServices/{resourceName}/connections/{connectionName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the Bot resource group in the user subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Bot resource.")
      @path
      resourceName: string;

      @doc("The name of the Bot Service Connection Setting resource.")
      @path
      connectionName: string;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;

      @doc("The parameters to provide for creating the Connection Setting.")
      @body
      parameters: ConnectionSetting;
    },
    ConnectionSetting
  >;

  @doc("Updates a Connection Setting registration for a Bot Service")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BotService/botServices/{resourceName}/connections/{connectionName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the Bot resource group in the user subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Bot resource.")
      @path
      resourceName: string;

      @doc("The name of the Bot Service Connection Setting resource.")
      @path
      connectionName: string;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;

      @doc("The parameters to provide for updating the Connection Setting.")
      @body
      parameters: ConnectionSetting;
    },
    ConnectionSetting
  >;

  @doc("Get a Connection Setting registration for a Bot Service")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BotService/botServices/{resourceName}/connections/{connectionName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the Bot resource group in the user subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Bot resource.")
      @path
      resourceName: string;

      @doc("The name of the Bot Service Connection Setting resource.")
      @path
      connectionName: string;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;
    },
    ConnectionSetting
  >;

  @doc("Deletes a Connection Setting registration for a Bot Service")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BotService/botServices/{resourceName}/connections/{connectionName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the Bot resource group in the user subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Bot resource.")
      @path
      resourceName: string;

      @doc("The name of the Bot Service Connection Setting resource.")
      @path
      connectionName: string;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("""
Returns all the Connection Settings registered to a particular BotService
resource
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BotService/botServices/{resourceName}/connections")
  @get
  ListByBotService is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the Bot resource group in the user subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Bot resource.")
      @path
      resourceName: string;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;
    },
    ConnectionSettingResponseList
  >;
}

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
  @doc("""
Get per subscription settings needed to host bot in compute resource such as
Azure App Service
""")
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

interface PrivateEndpointConnectionsOperations {
  @doc("List all the private endpoint connections associated with the Bot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BotService/botServices/{resourceName}/privateEndpointConnections")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the Bot resource group in the user subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Bot resource.")
      @path
      resourceName: string;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;
    },
    PrivateEndpointConnectionListResult
  >;

  @doc("Gets the specified private endpoint connection associated with the Bot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BotService/botServices/{resourceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the Bot resource group in the user subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Bot resource.")
      @path
      resourceName: string;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;

      @doc("The name of the private endpoint connection associated with the Azure resource")
      @path
      privateEndpointConnectionName: string;
    },
    PrivateEndpointConnection
  >;

  @doc("""
Update the state of specified private endpoint connection associated with the
Bot.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BotService/botServices/{resourceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the Bot resource group in the user subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Bot resource.")
      @path
      resourceName: string;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;

      @doc("The name of the private endpoint connection associated with the Azure resource")
      @path
      privateEndpointConnectionName: string;

      @doc("The private endpoint connection properties.")
      @body
      properties: PrivateEndpointConnection;
    },
    PrivateEndpointConnection
  >;

  @doc("Deletes the specified private endpoint connection associated with the Bot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BotService/botServices/{resourceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the Bot resource group in the user subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Bot resource.")
      @path
      resourceName: string;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;

      @doc("The name of the private endpoint connection associated with the Azure resource")
      @path
      privateEndpointConnectionName: string;
    },
    void
  >;
}

interface PrivateLinkResourcesOperations {
  @doc("Gets the private link resources that need to be created for a Bot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BotService/botServices/{resourceName}/privateLinkResources")
  @get
  ListByBotResource is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the Bot resource group in the user subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Bot resource.")
      @path
      resourceName: string;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;
    },
    PrivateLinkResourceListResult
  >;
}
