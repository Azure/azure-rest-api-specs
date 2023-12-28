import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.BotService;
@doc("Bot resource definition")
model Bot is TrackedResource<BotProperties> {
  @doc("The name of the Bot resource.")
  @maxLength(64)
  @minLength(2)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
  @key("resourceName")
  @segment("botServices")
  name: string;
}

@armResourceOperations
interface Bots {
  @doc("Returns a BotService specified by the parameters.")
  get is ArmResourceRead<Bot>;
  @doc("Creates a Bot Service. Bot Service is a resource group wide resource type.")
  create is ArmResourceCreateOrReplaceSync<Bot>;
  @doc("Updates a Bot Service")
  update is ArmCustomPatchSync<Bot, Bot>;
  @doc("Deletes a Bot Service from the resource group. ")
  delete is ArmResourceDeleteSync<Bot>;
  @doc("Returns all the resources of a particular type belonging to a resource group")
  listByResourceGroup is ArmResourceListByParent<Bot>;
  @doc("Returns all the resources of a particular type belonging to a subscription.")
  list is ArmListBySubscription<Bot>;
}

@armResourceOperations
interface DirectLine {
  @doc("Regenerates secret keys and returns them for the DirectLine Channel of a particular BotService resource")
  regenerateKeys is ArmResourceActionSync<
    Bot,
    SiteInfo,
    BotChannel,
    {
      ...BaseParameters<Bot>;

      @doc("The name of the Channel resource for which keys are to be regenerated.")
      @path
      channelName: RegenerateKeysChannelName;
    }
  >;
}

@armResourceOperations
interface Email {
  @doc("Creates an email channel sign in url for a Bot Service")
  createSignInUrl is ArmResourceActionSync<
    Bot,
    void,
    CreateEmailSignInUrlResponse
  >;
}

@armResourceOperations
interface PrivateLinkResources {
  @doc("Gets the private link resources that need to be created for a Bot.")
  // FIXME: PrivateLinkResources_ListByBotResource could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BotService/botServices/{resourceName}/privateLinkResources")
  @get
  ListByBotResource is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the Bot resource group in the user subscription.")
      @maxLength(64)
      @minLength(2)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
      @path
      resourceGroupName: string;

      @doc("The name of the Bot resource.")
      @maxLength(64)
      @minLength(2)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
      @path
      resourceName: string;

      @doc("Azure Subscription ID.")
      @path
      subscriptionId: string;
    },
    PrivateLinkResourceListResult
  >;
}
