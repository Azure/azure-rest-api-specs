import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SBTopic.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceBus;
/**
 * Description of subscription resource.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(SBTopic)
model SBSubscription
  is Azure.ResourceManager.ProxyResource<SBSubscriptionProperties> {
  ...ResourceNameParameter<
    Resource = SBSubscription,
    KeyName = "subscriptionName",
    SegmentName = "subscriptions",
    NamePattern = ""
  >;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  location?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface SBSubscriptions {
  /**
   * Returns a subscription description for the specified topic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639402.aspx")
  get is ArmResourceRead<SBSubscription, Error = ErrorResponse>;

  /**
   * Creates a topic subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639385.aspx")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    SBSubscription,
    Response = ArmResourceUpdatedResponse<SBSubscription>,
    Error = ErrorResponse
  >;

  /**
   * Deletes a subscription from the specified topic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639381.aspx")
  delete is ArmResourceDeleteSync<SBSubscription, Error = ErrorResponse>;

  /**
   * List all the subscriptions under a specified topic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://msdn.microsoft.com/en-us/library/azure/mt639400.aspx")
  listByTopic is ArmResourceListByParent<
    SBSubscription,
    Parameters = {
      /**
       * Skip is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skip parameter that specifies a starting point to use for subsequent calls.
       */
      @maxValue(1000)
      @query("$skip")
      $skip?: int32;

      /**
       * May be used to limit the number of results to the most recent N usageDetails.
       */
      @maxValue(1000)
      @minValue(1)
      @query("$top")
      $top?: int32;
    },
    Error = ErrorResponse
  >;
}

@@maxLength(SBSubscription.name, 50);
@@minLength(SBSubscription.name, 1);
@@doc(SBSubscription.name, "The subscription name.");
@@doc(SBSubscription.properties, "Properties of subscriptions resource.");
@@doc(SBSubscriptions.createOrUpdate::parameters.resource,
  "Parameters supplied to create a subscription resource."
);
