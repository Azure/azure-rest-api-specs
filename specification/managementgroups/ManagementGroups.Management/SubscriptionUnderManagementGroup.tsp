import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagementGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

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
}

@armResourceOperations
interface SubscriptionUnderManagementGroups {
  /**
   * Retrieves details about given subscription which is associated with the management group.
   *
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  getSubscription is Extension.Read<
    Extension.Tenant,
    SubscriptionUnderManagementGroup,
    Parameters = {
      /**
       * Indicates whether the request should utilize any caches. Populate the header with 'no-cache' value to bypass existing caches.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
      @header("Cache-Control")
      `Cache-Control`?: string = "no-cache";
    }
  >;

  /**
   * Associates existing subscription with the management group.
   *
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  create is Azure.ResourceManager.Legacy.Extension.CreateOrReplaceSync<
    Extension.Tenant,
    SubscriptionUnderManagementGroup,
    Request = void,
    Parameters = {
      /**
       * Indicates whether the request should utilize any caches. Populate the header with 'no-cache' value to bypass existing caches.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
      @header("Cache-Control")
      `Cache-Control`?: string = "no-cache";
    },
    Response = ArmResourceUpdatedResponse<SubscriptionUnderManagementGroup>
  >;

  /**
   * De-associates subscription from the management group.
   *
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  delete is Extension.DeleteSync<
    Extension.Tenant,
    SubscriptionUnderManagementGroup,
    Parameters = {
      /**
       * Indicates whether the request should utilize any caches. Populate the header with 'no-cache' value to bypass existing caches.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
      @header("Cache-Control")
      `Cache-Control`?: string = "no-cache";
    }
  >;

  /**
   * Retrieves details about all subscriptions which are associated with the management group.
   *
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  getSubscriptionsUnderManagementGroup is Extension.ListByTarget<
    Extension.Tenant,
    SubscriptionUnderManagementGroup,
    Parameters = {
      /**
       * Page continuation token is only used if a previous operation returned a partial result.
       * If a previous response contains a nextLink element, the value of the nextLink element will include a token parameter that specifies a starting point to use for subsequent calls.
       *
       */
      @query("$skiptoken")
      $skiptoken?: string;
    },
    Response = ArmResponse<ListSubscriptionUnderManagementGroup>
  >;
}

@@doc(SubscriptionUnderManagementGroup.name, "Subscription ID.");
@@doc(SubscriptionUnderManagementGroup.properties,
  "The generic properties of subscription under a management group."
);
