import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Bot.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.BotService;
@doc("Bot channel resource definition")
@parentResource(Bot)
model BotChannel is TrackedResource<Channel> {
  @doc("The name of the Channel resource.")
  @path
  @key("channelName")
  @segment("channels")
  name: ChannelName;
}

@armResourceOperations
interface BotChannels {
  @doc("Returns a BotService Channel registration specified by the parameters.")
  get is ArmResourceRead<BotChannel>;
  @doc("Creates a Channel registration for a Bot Service")
  create is ArmResourceCreateOrReplaceSync<BotChannel>;
  @doc("Updates a Channel registration for a Bot Service")
  update is ArmResourcePatchSync<BotChannel, Channel>;
  @doc("Deletes a Channel registration from a Bot Service")
  delete is ArmResourceDeleteSync<BotChannel>;
  @doc("Returns all the Channel registrations of a particular BotService resource")
  listByResourceGroup is ArmResourceListByParent<BotChannel>;
  @doc("Lists a Channel registration for a Bot Service including secrets")
  listWithKeys is ArmResourceActionSync<
    BotChannel,
    {},
    ListChannelWithKeysResponse
  >;
}
