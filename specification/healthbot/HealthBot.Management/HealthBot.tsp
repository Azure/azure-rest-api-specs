import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HealthBot;
/**
 * Azure Health Bot resource definition
 */
model HealthBot
  is Azure.ResourceManager.TrackedResource<HealthBotProperties, true> {
  ...ResourceNameParameter<
    Resource = HealthBot,
    KeyName = "botName",
    SegmentName = "healthBots",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;

  /**
   * SKU of the Azure Health Bot.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku: Sku;

  /**
   * The identity of the Azure Health Bot.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: Identity;
}

@armResourceOperations
interface HealthBots {
  /**
   * Get a HealthBot.
   */
  get is ArmResourceRead<HealthBot, Error = Error>;

  /**
   * Create a new Azure Health Bot.
   */
  create is ArmResourceCreateOrReplaceAsync<
    HealthBot,
    Error = Error,
    Response = ArmResourceUpdatedResponse<HealthBot> | ArmResourceCreatedResponse<
      HealthBot,
      ArmAsyncOperationHeader & Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Patch a HealthBot.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    HealthBot,
    PatchModel = HealthBotUpdateParameters,
    Error = Error,
    Response = ArmResponse<HealthBot> | ArmResourceCreatedResponse<
      HealthBot,
      ArmLroLocationHeader<FinalResult = HealthBot> &
        Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Delete a HealthBot.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    HealthBot,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader> | ArmDeletedNoContentResponse,
    Error = Error
  >;

  /**
   * Returns all the resources of a particular type belonging to a resource group
   */
  listByResourceGroup is ArmResourceListByParent<
    HealthBot,
    Response = ArmResponse<BotResponseList>,
    Error = Error
  >;

  /**
   * Returns all the resources of a particular type belonging to a subscription.
   */
  list is ArmListBySubscription<
    HealthBot,
    Response = ArmResponse<BotResponseList>,
    Error = Error
  >;

  /**
   * List all secrets of a HealthBot.
   */
  listSecrets is ArmResourceActionSync<
    HealthBot,
    void,
    ArmResponse<HealthBotKeysResponse>,
    Error = Error
  >;

  /**
   * Regenerate the API JWT Secret of a HealthBot.
   */
  regenerateApiJwtSecret is ArmResourceActionSync<
    HealthBot,
    void,
    ArmResponse<HealthBotKey>,
    Error = Error
  >;
}

@@maxLength(HealthBot.name, 64);
@@minLength(HealthBot.name, 2);
@@doc(HealthBot.name, "The name of the Bot resource.");
@@doc(HealthBot.properties,
  "The set of properties specific to Azure Health Bot resource."
);
@@doc(HealthBots.create::parameters.resource,
  "The parameters to provide for the created Azure Health Bot."
);
@@doc(HealthBots.update::parameters.properties,
  "The parameters to provide for the required Azure Health Bot."
);
