import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Bot.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.BotService;
@doc("Bot channel resource definition")
@parentResource(Bot)
model BotChannel is TrackedResource<Channel> {
  @doc("The name of the Bot resource.")
  @maxLength(64)
  @minLength(2)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
  @path
  @key("channelName")
  @segment("channels")
  name: string;
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
}
