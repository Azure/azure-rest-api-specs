import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Bot.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.BotService;
/**
 * Bot channel resource definition
 */
@parentResource(Bot)
model BotChannel is Azure.ResourceManager.TrackedResource<Channel> {
  ...ResourceNameParameter<
    Resource = BotChannel,
    KeyName = "channelName",
    SegmentName = "channels",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;
}

@armResourceOperations
interface BotChannels {
  /**
   * Returns a BotService Channel registration specified by the parameters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Channels_Get")
  get is ArmResourceRead<BotChannel>;

  /**
   * Creates a Channel registration for a Bot Service
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Channels_Create")
  create is ArmResourceCreateOrReplaceSync<BotChannel>;

  /**
   * Updates a Channel registration for a Bot Service
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("Channels_Update")
  update is ArmCustomPatchSync<
    BotChannel,
    PatchModel = BotChannel,
    Response = ArmResponse<BotChannel> | ArmResourceCreatedSyncResponse<BotChannel>
  >;

  /**
   * Deletes a Channel registration from a Bot Service
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Channels_Delete")
  delete is ArmResourceDeleteSync<BotChannel>;

  /**
   * Returns all the Channel registrations of a particular BotService resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Channels_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    BotChannel,
    Response = ArmResponse<ChannelResponseList>
  >;

  /**
   * Lists a Channel registration for a Bot Service including secrets
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("listChannelWithKeys")
  @operationId("Channels_ListWithKeys")
  listWithKeys is ArmResourceActionSync<
    BotChannel,
    void,
    ArmResponse<ListChannelWithKeysResponse>
  >;

  /**
   * Regenerates secret keys and returns them for the DirectLine Channel of a particular BotService resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("regeneratekeys")
  @operationId("DirectLine_RegenerateKeys")
  regenerateKeys is ArmResourceActionSync<
    BotChannel,
    SiteInfo,
    ArmResponse<BotChannel>
  >;
}

@@maxLength(BotChannel.name, 64);
@@minLength(BotChannel.name, 2);
@@doc(BotChannel.name, "The name of the Bot resource.");
@@doc(BotChannel.properties,
  "The set of properties specific to bot channel resource"
);
@@doc(BotChannels.create::parameters.resource,
  "The parameters to provide for the created bot."
);
@@doc(BotChannels.update::parameters.properties,
  "The parameters to provide for the created bot."
);
@@doc(BotChannels.regenerateKeys::parameters.body,
  "The parameters to provide for the created bot."
);
