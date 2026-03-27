// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.Search;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ServicesOperationGroup {
  /**
   * Checks whether or not the given search service name is available for use. Search service names must be globally unique since they are part of the service URI (https://<name>.search.windows.net).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://aka.ms/search-manage")
  @autoRoute
  @tag("Services")
  checkNameAvailability is ArmProviderActionSync<
    Request = CheckNameAvailabilityInput,
    Response = CheckNameAvailabilityOutput,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @format("uuid")
      @header("x-ms-client-request-id")
      @OpenAPI.extension(
        "x-ms-parameter-grouping",
        #{ name: "search-management-request-options" }
      )
      @OpenAPI.extension("x-ms-client-request-id", true)
      clientRequestId?: string;
    },
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface UsagesOperationGroup {
  /**
   * Get a list of all Azure AI Search quota usages across the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  @get
  @action("usages")
  @externalDocs("https://aka.ms/search-manage")
  @list
  @tag("Usages")
  listBySubscription is ArmProviderActionSync<
    Request = void,
    Response = QuotaUsagesListResult,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @format("uuid")
      @header("x-ms-client-request-id")
      @OpenAPI.extension(
        "x-ms-parameter-grouping",
        #{ name: "search-management-request-options" }
      )
      @OpenAPI.extension("x-ms-client-request-id", true)
      clientRequestId?: string;

      ...LocationResourceParameter;
    },
    Error = CloudError
  >;
}

/**
 * Gets the quota usage for a search SKU in the given subscription.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Search/locations/{location}/usages/{skuName}")
@get
@externalDocs("https://aka.ms/search-manage")
@tag("Usages")
op usageBySubscriptionSku(
  ...ApiVersionParameter,

  /**
   * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @format("uuid")
  @header("x-ms-client-request-id")
  @OpenAPI.extension(
    "x-ms-parameter-grouping",
    #{ name: "search-management-request-options" }
  )
  @OpenAPI.extension("x-ms-client-request-id", true)
  clientRequestId?: string,

  ...LocationResourceParameter,
  ...SubscriptionIdParameter,

  /**
   * The unique SKU name that identifies a billable tier.
   */
  @path
  skuName: string,
): ArmResponse<QuotaUsageResult> | CloudError;

/**
 * Offerings API operations
 * Released in 2025-02-01-preview and added back to TypeSpec as the migration is based on 2025-05-01 and does not include it.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2026_03_01_preview)
interface Offerings {
  /**
   * Lists all of the features and SKUs offered by the Azure AI Search service in each region. Note: This API returns a non-ARM resource collection and is not RPC-compliant. It will be replaced with an action-style API in the next preview as a breaking change. Customers should avoid taking new dependencies on the current shape.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Pre-existing API contract"
  @autoRoute
  @get
  @action("offerings")
  @tag("Offerings")
  @OpenAPI.extension("x-ms-pageable", #{ nextLinkName: null })
  list is ArmProviderActionSync<
    Request = void,
    Response = OfferingsListResult,
    Scope = TenantActionScope,
    Parameters = {},
    Error = CloudError
  >;
}
