import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HealthBot;
/**
 * Azure Health Bot resource definition
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" ""
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
@Azure.ResourceManager.Private.armResourceInternal(HealthBotProperties)
@TypeSpec.Http.Private.includeInapplicableMetadataInPayload(false)
model HealthBot extends Foundations.TrackedResource {
  ...ResourceNameParameter<
    Resource = HealthBot,
    KeyName = "botName",
    SegmentName = "healthBots",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;

  /**
   * SKU of the Azure Health Bot.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku: Sku;

  /**
   * The identity of the Azure Health Bot.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" ""
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(true)
  identity?: Identity;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" ""
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" ""
  @doc("The set of properties specific to Azure Health Bot resource.")
  @Azure.ResourceManager.Private.conditionalClientFlatten
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(true)
  properties?: HealthBotProperties;
}

@armResourceOperations
interface HealthBots {
  /**
   * Get a HealthBot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Bots_Get")
  get is ArmResourceRead<HealthBot, Error = Error>;

  /**
   * Create a new Azure Health Bot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Bots_Create")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem"
  @patch(#{ implicitOptionality: false })
  @operationId("Bots_Update")
  update is ArmCustomPatchAsync<
    HealthBot,
    PatchModel = HealthBotUpdateParameters,
    Error = Error,
    Response = ArmResponse<HealthBot> | ArmResourceCreatedResponse<
      HealthBot,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Delete a HealthBot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Bots_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    HealthBot,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = Error
  >;

  /**
   * Returns all the resources of a particular type belonging to a resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Bots_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    HealthBot,
    Response = ArmResponse<BotResponseList>,
    Error = Error
  >;

  /**
   * Returns all the resources of a particular type belonging to a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Bots_List")
  list is ArmListBySubscription<
    HealthBot,
    Response = ArmResponse<BotResponseList>,
    Error = Error
  >;

  /**
   * List all secrets of a HealthBot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Bots_ListSecrets")
  listSecrets is ArmResourceActionSync<
    HealthBot,
    void,
    ArmResponse<HealthBotKeysResponse>,
    Error = Error
  >;

  /**
   * Regenerate the API JWT Secret of a HealthBot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Bots_RegenerateApiJwtSecret")
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
