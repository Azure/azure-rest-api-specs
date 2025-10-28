import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CognitiveServices;
/**
 * Cognitive Services Rai External Safety provider Schema.
 */
@subscriptionResource
model RaiExternalSafetyProviderSchema
  is Azure.ResourceManager.ProxyResource<RaiExternalSafetyProviderSchemaProperties> {
  ...ResourceNameParameter<
    Resource = RaiExternalSafetyProviderSchema,
    KeyName = "safetyProviderName",
    SegmentName = "raiExternalSafetyProviders",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;

  /**
   * Resource Etag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  tags?: Record<string>;
}

@armResourceOperations
interface RaiExternalSafetyProviderSchemas {
  /**
   * Gets the specified external safety provider associated with the Subscription
   */
  get is ArmResourceRead<
    RaiExternalSafetyProviderSchema,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Create the rai safety provider associated with the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    RaiExternalSafetyProviderSchema,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResourceUpdatedResponse<RaiExternalSafetyProviderSchema> | ArmResourceCreatedSyncResponse<RaiExternalSafetyProvider>
  >;

  /**
   * Deletes the specified custom topic associated with the subscription.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    RaiExternalSafetyProviderSchema,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Gets the safety providers associated with the subscription
   */
  list is ArmResourceListByParent<
    RaiExternalSafetyProviderSchema,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<RaiExternalSafetyProviderResult>
  >;
}

@@doc(RaiExternalSafetyProviderSchema.name,
  "The name of the Rai External Safety Provider associated with the Cognitive Services Account"
);
@@encodedName(RaiExternalSafetyProviderSchema.etag, "application/json", "etag");
@@doc(RaiExternalSafetyProviderSchema.properties,
  "Properties of Cognitive Services Rai External Safety provider."
);
@@doc(RaiExternalSafetyProviderSchemas.createOrUpdate::parameters.resource,
  "Properties describing the rai external safety provider."
);
