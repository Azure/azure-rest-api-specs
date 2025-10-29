// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.Search;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ServicesOperationGroup {
  /**
   * Checks whether or not the given search service name is available for use. Search service names must be globally unique since they are part of the service URI (https://<name>.search.windows.net).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Services_CheckNameAvailability")
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = CheckNameAvailabilityInput,
    Response = CheckNameAvailabilityOutput,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format"
      @format("uuid")
      @header
      clientRequestId?: string;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface UsagesOperationGroup {
  /**
   * Get a list of all Azure AI Search quota usages across the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Usages_ListBySubscription")
  @autoRoute
  @get
  @action("usages")
  listBySubscription is ArmProviderActionSync<
    Response = QuotaUsagesListResult,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format"
      @format("uuid")
      @header
      clientRequestId?: string;

      ...LocationParameter;
    }
  >;
}

/**
 * Gets the quota usage for a search SKU in the given subscription.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Search/locations/{location}/usages/{skuName}")
@get
op usageBySubscriptionSku(
  ...ApiVersionParameter,

  /**
   * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  @header
  clientRequestId?: string,

  ...LocationResourceParameter,
  ...SubscriptionIdParameter,

  /**
   * The unique SKU name that identifies a billable tier.
   */
  @path
  skuName: string,
): ArmResponse<QuotaUsageResult> | ErrorResponse;
