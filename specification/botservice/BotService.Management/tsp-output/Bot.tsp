import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.BotService;
/**
 * Bot resource definition
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(BotProperties)
model Bot extends TrackedResourceBase {
  /**
   * The name of the Bot resource.
   */
  @maxLength(64)
  @minLength(2)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
  @path
  @key("resourceName")
  @segment("botServices")
  @visibility("read")
  name: string;

  /**
   * The set of properties specific to bot resource
   */
  @extension("x-ms-client-flatten", true)
  properties?: BotProperties;
}

@armResourceOperations
interface Bots {
  /**
   * Returns a BotService specified by the parameters.
   */
  get is ArmResourceRead<Bot>;

  /**
   * Creates a Bot Service. Bot Service is a resource group wide resource type.
   */
  create is ArmResourceCreateOrReplaceSync<Bot>;

  /**
   * Updates a Bot Service
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<Bot, Bot>;

  /**
   * Deletes a Bot Service from the resource group.
   */
  delete is ArmResourceDeleteSync<Bot>;

  /**
   * Returns all the resources of a particular type belonging to a resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Bots_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Bot>;

  /**
   * Returns all the resources of a particular type belonging to a subscription.
   */
  list is ArmListBySubscription<Bot>;

  /**
   * Regenerates secret keys and returns them for the DirectLine Channel of a particular BotService resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DirectLine_RegenerateKeys")
  regenerateKeys is ArmResourceActionSync<
    Bot,
    SiteInfo,
    BotChannel,
    {
      ...BaseParameters<Bot>;

      /**
       * The name of the Channel resource for which keys are to be regenerated.
       */
      @path
      channelName: RegenerateKeysChannelName;
    }
  >;

  /**
   * Creates an email channel sign in url for a Bot Service
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Email_CreateSignInUrl")
  createSignInUrl is ArmResourceActionSync<
    Bot,
    void,
    CreateEmailSignInUrlResponse
  >;

  /**
   * Check whether a bot name is available.
   */
  getCheckNameAvailability is checkGlobalNameAvailability<
    CheckNameAvailabilityRequestBody,
    CheckNameAvailabilityResponseBody
  >;

  /**
   * Gets the private link resources that need to be created for a Bot.
   */
  // FIXME: PrivateLinkResources_ListByBotResource could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkResources_ListByBotResource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BotService/botServices/{resourceName}/privateLinkResources")
  @get
  listByBotResource is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the Bot resource group in the user subscription.
       */
      @maxLength(64)
      @minLength(2)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
      @path
      resourceGroupName: string;

      /**
       * The name of the Bot resource.
       */
      @maxLength(64)
      @minLength(2)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
      @path
      resourceName: string;

      /**
       * Azure Subscription ID.
       */
      @path
      subscriptionId: string;
    },
    PrivateLinkResourceListResult
  >;
}

@@projectedName(Bots.create::parameters.resource, "json", "parameters");
@@extension(Bots.create::parameters.resource, "x-ms-client-name", "parameters");
@@doc(Bots.create::parameters.resource,
  "The parameters to provide for the created bot."
);
@@projectedName(Bots.update::parameters.properties, "json", "parameters");
@@extension(Bots.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Bots.update::parameters.properties,
  "The parameters to provide for the created bot."
);
@@projectedName(Bots.regenerateKeys::parameters.body, "json", "parameters");
@@extension(Bots.regenerateKeys::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(Bots.regenerateKeys::parameters.body,
  "The parameters to provide for the created bot."
);
