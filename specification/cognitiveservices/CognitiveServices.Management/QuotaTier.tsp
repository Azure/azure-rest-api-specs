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
 * The quota tier information for the subscription
 */
@subscriptionResource
model QuotaTier is Azure.ResourceManager.ProxyResource<QuotaTierProperties> {
  ...ResourceNameParameter<
    Resource = QuotaTier,
    KeyName = "default",
    SegmentName = "quotaTiers",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface QuotaTiers {
  /**
   * Gets the Quota Tier information for the given subscription. QuotaTiers is a subscription wide resource type. It holds current tier information.
   */
  get is ArmResourceRead<
    QuotaTier,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Update the Quota Tier information for the given subscription. QuotaTiers is a subscription wide resource type. It holds current tier information.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    QuotaTier,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Update the Quota Tier information for the given subscription. QuotaTiers is a subscription wide resource type. It holds current tier information.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    QuotaTier,
    PatchModel = QuotaTier,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Returns all the resources of a particular type belonging to a subscription.
   */
  listBySubscription is ArmResourceListByParent<
    QuotaTier,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = QuotaTierListResult
  >;
}

@@doc(QuotaTier.name, "Default parameter. Leave the value as default.");
@@doc(QuotaTier.properties, "Properties of quota tier resource.");
@@doc(QuotaTiers.createOrUpdate::parameters.resource,
  "The parameters to provide for the quota tier resource."
);
@@doc(QuotaTiers.update::parameters.properties,
  "The parameters to provide for the quota tier resource."
);
@@summary(QuotaTiers.get, "Gets the Quota Tier for a subscription");
@@summary(QuotaTiers.createOrUpdate,
  "Updates the Quota Tier resource for a subscription."
);
@@summary(QuotaTiers.update,
  "Updates the Quota Tier resource for a subscription. The only properties that can be updated are  \"tierUpgradePolicy\""
);
