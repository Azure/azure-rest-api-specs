import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Bot.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.BotService;
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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns a BotService Channel registration specified by the parameters.")
  @operationId("Channels_Get")
  get is ArmResourceRead<BotChannel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates a Channel registration for a Bot Service")
  @operationId("Channels_Create")
  create is ArmResourceCreateOrReplaceSync<BotChannel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates a Channel registration for a Bot Service")
  @operationId("Channels_Update")
  update is ArmCustomPatchSync<BotChannel, BotChannel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a Channel registration from a Bot Service")
  @operationId("Channels_Delete")
  delete is ArmResourceDeleteSync<BotChannel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns all the Channel registrations of a particular BotService resource")
  @operationId("Channels_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<BotChannel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists a Channel registration for a Bot Service including secrets")
  @operationId("Channels_ListWithKeys")
  listWithKeys is ArmResourceActionSync<
    BotChannel,
    void,
    ListChannelWithKeysResponse
  >;
}

@@projectedName(BotChannels.create::parameters.resource, "json", "parameters");
@@extension(BotChannels.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(BotChannels.create::parameters.resource,
  "The parameters to provide for the created bot."
);
@@projectedName(BotChannels.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(BotChannels.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(BotChannels.update::parameters.properties,
  "The parameters to provide for the created bot."
);
