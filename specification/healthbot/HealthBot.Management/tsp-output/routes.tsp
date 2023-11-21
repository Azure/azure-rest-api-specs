import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace HealthbotClient;

interface BotsOperations {
  @doc("Create a new Azure Health Bot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthBot/healthBots/{botName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;

      @doc("The name of the Bot resource group in the user subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Bot resource.")
      @path
      botName: string;

      @doc("The parameters to provide for the created Azure Health Bot.")
      @body
      parameters: HealthBot;
    },
    HealthBot
  >;

  @doc("Get a HealthBot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthBot/healthBots/{botName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;

      @doc("The name of the Bot resource group in the user subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Bot resource.")
      @path
      botName: string;
    },
    HealthBot
  >;

  @doc("Patch a HealthBot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthBot/healthBots/{botName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;

      @doc("The name of the Bot resource group in the user subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Bot resource.")
      @path
      botName: string;

      @doc("The parameters to provide for the required Azure Health Bot.")
      @body
      parameters: HealthBotUpdateParameters;
    },
    HealthBot
  >;

  @doc("Delete a HealthBot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthBot/healthBots/{botName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;

      @doc("The name of the Bot resource group in the user subscription.")
      @path
      resourceGroupName: string;

      @doc("The name of the Bot resource.")
      @path
      botName: string;
    },
    void
  >;

  @doc("Returns all the resources of a particular type belonging to a resource group")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthBot/healthBots")
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
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.HealthBot/healthBots")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;
    },
    BotResponseList
  >;
}

interface OperationsOperations {
  @doc("Lists all the available Azure Health Bot operations.")
  @route("/providers/Microsoft.HealthBot/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, AvailableOperations>;
}
