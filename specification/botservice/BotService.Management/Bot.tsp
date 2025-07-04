import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.BotService;
/**
 * Bot resource definition
 */
model Bot is Azure.ResourceManager.TrackedResource<BotProperties> {
  ...ResourceNameParameter<
    Resource = Bot,
    KeyName = "resourceName",
    SegmentName = "botServices",
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
interface Bots {
  /**
   * Returns a BotService specified by the parameters.
   */
  get is ArmResourceRead<Bot, Error = Error>;

  /**
   * Creates a Bot Service. Bot Service is a resource group wide resource type.
   */
  create is ArmResourceCreateOrReplaceSync<Bot, Error = Error>;

  /**
   * Updates a Bot Service
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    Bot,
    PatchModel = Bot,
    Response = ArmResponse<Bot> | ArmResourceCreatedSyncResponse<Bot>,
    Error = Error
  >;

  /**
   * Deletes a Bot Service from the resource group.
   */
  delete is ArmResourceDeleteSync<Bot, Error = Error>;

  /**
   * Returns all the resources of a particular type belonging to a resource group
   */
  listByResourceGroup is ArmResourceListByParent<
    Bot,
    Response = ArmResponse<BotResponseList>,
    Error = Error
  >;

  /**
   * Returns all the resources of a particular type belonging to a subscription.
   */
  list is ArmListBySubscription<
    Bot,
    Response = ArmResponse<BotResponseList>,
    Error = Error
  >;

  /**
   * Creates an email channel sign in url for a Bot Service
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("createEmailSignInUrl")
  createSignInUrl is ArmResourceActionSync<
    Bot,
    void,
    ArmResponse<CreateEmailSignInUrlResponse>,
    Error = Error
  >;

  /**
   * Gets the private link resources that need to be created for a Bot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @action("privateLinkResources")
  listByBotResource is ArmResourceActionSync<
    Bot,
    void,
    ArmResponse<PrivateLinkResourceListResult>,
    Error = Error
  >;
}

@@maxLength(Bot.name, 64);
@@minLength(Bot.name, 2);
@@doc(Bot.name, "The name of the Bot resource.");
@@doc(Bot.properties, "The set of properties specific to bot resource");
@@doc(Bots.create::parameters.resource,
  "The parameters to provide for the created bot."
);
@@doc(Bots.update::parameters.properties,
  "The parameters to provide for the created bot."
);
