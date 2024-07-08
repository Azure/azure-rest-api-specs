import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagementGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Management;
/**
 * The details of subscription under management group.
 */
@parentResource(ManagementGroup)
model SubscriptionUnderManagementGroup
  is Azure.ResourceManager.ProxyResource<SubscriptionUnderManagementGroupProperties> {
  ...ResourceNameParameter<
    Resource = SubscriptionUnderManagementGroup,
    KeyName = "subscriptionId",
    SegmentName = "subscriptions",
    NamePattern = ""
  >;

  /**
   * The fully qualified ID for the subscription.  For example, /providers/Microsoft.Management/managementGroups/0000000-0000-0000-0000-000000000000/subscriptions/0000000-0000-0000-0000-000000000001
   */
  @visibility("read")
  id?: string;

  /**
   * The type of the resource.  For example, Microsoft.Management/managementGroups/subscriptions
   */
  @visibility("read")
  type?: string;
}

@armResourceOperations
interface SubscriptionUnderManagementGroups {
  /**
   * Retrieves details about given subscription which is associated with the management group.
   *
   */
  getSubscription is ArmResourceRead<
    SubscriptionUnderManagementGroup,
    {
      ...Azure.ResourceManager.Foundations.BaseParameters<SubscriptionUnderManagementGroup>;

      /**
       * Indicates whether the request should utilize any caches. Populate the header with 'no-cache' value to bypass existing caches.
       */
      @header
      `Cache-Control`?: string = "no-cache";
    }
  >;

  /**
   * Associates existing subscription with the management group.
   *
   */
  create is ArmResourceCreateOrReplaceSync<
    SubscriptionUnderManagementGroup,
    {
      ...Azure.ResourceManager.Foundations.BaseParameters<SubscriptionUnderManagementGroup>;

      /**
       * Indicates whether the request should utilize any caches. Populate the header with 'no-cache' value to bypass existing caches.
       */
      @header
      `Cache-Control`?: string = "no-cache";
    }
  >;

  /**
   * De-associates subscription from the management group.
   *
   */
  delete is ArmResourceDeleteSync<
    SubscriptionUnderManagementGroup,
    {
      ...Azure.ResourceManager.Foundations.BaseParameters<SubscriptionUnderManagementGroup>;

      /**
       * Indicates whether the request should utilize any caches. Populate the header with 'no-cache' value to bypass existing caches.
       */
      @header
      `Cache-Control`?: string = "no-cache";
    }
  >;

  /**
   * Retrieves details about all subscriptions which are associated with the management group.
   *
   */
  getSubscriptionsUnderManagementGroup is ArmResourceListByParent<
    SubscriptionUnderManagementGroup,
    {
      ...Azure.ResourceManager.Foundations.BaseParameters<SubscriptionUnderManagementGroup>;

      /**
       * Page continuation token is only used if a previous operation returned a partial result.
       * If a previous response contains a nextLink element, the value of the nextLink element will include a token parameter that specifies a starting point to use for subsequent calls.
       *
       */
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;
}

@@doc(SubscriptionUnderManagementGroup.name, "Subscription ID.");
