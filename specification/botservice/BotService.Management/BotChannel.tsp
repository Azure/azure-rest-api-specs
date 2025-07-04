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

  /**
   * Gets or sets the SKU of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: Sku;

  /**
   * Required. Gets or sets the Kind of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: Kind;

  /**
   * Entity Tag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;

  /**
   * Entity zones
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  zones?: string[];
}

@armResourceOperations
interface BotChannels {
  /**
   * Returns a BotService Channel registration specified by the parameters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get is ArmResourceRead<BotChannel, Error = Error>;

  /**
   * Creates a Channel registration for a Bot Service
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is ArmResourceCreateOrReplaceSync<BotChannel, Error = Error>;

  /**
   * Updates a Channel registration for a Bot Service
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    BotChannel,
    PatchModel = BotChannel,
    Response = ArmResponse<BotChannel> | ArmResourceCreatedSyncResponse<BotChannel>,
    Error = Error
  >;

  /**
   * Deletes a Channel registration from a Bot Service
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteSync<BotChannel, Error = Error>;

  /**
   * Returns all the Channel registrations of a particular BotService resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  listByResourceGroup is ArmResourceListByParent<
    BotChannel,
    Response = ArmResponse<ChannelResponseList>,
    Error = Error
  >;

  /**
   * Lists a Channel registration for a Bot Service including secrets
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("listChannelWithKeys")
  listWithKeys is ArmResourceActionSync<
    BotChannel,
    void,
    ArmResponse<ListChannelWithKeysResponse>,
    Error = Error
  >;

  /**
   * Regenerates secret keys and returns them for the DirectLine Channel of a particular BotService resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("regeneratekeys")
  regenerateKeys is ArmResourceActionSync<
    BotChannel,
    SiteInfo,
    ArmResponse<BotChannel>,
    Error = Error
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
