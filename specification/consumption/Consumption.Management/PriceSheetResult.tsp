import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Consumption;
/**
 * An pricesheet resource.
 */
@singleton("default")
@subscriptionResource
model PriceSheetResult is Azure.ResourceManager.ProxyResource<PriceSheetModel> {
  ...ResourceNameParameter<
    Resource = PriceSheetResult,
    KeyName = "pricesheet",
    SegmentName = "pricesheets",
    NamePattern = ""
  >;

  /**
   * eTag of the resource. To handle concurrent update scenario, this field will be used to determine whether the user is updating the latest version or not.
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
interface PriceSheetResults {
  /**
   * Gets the price sheet for a subscription. Price sheet is available via this API only for May 1, 2014 or later.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/consumption/")
  get is ArmResourceRead<
    PriceSheetResult,
    Parameters = {
      /**
       * May be used to expand the properties/meterDetails within a price sheet. By default, these fields are not included when returning price sheet.
       */
      @query("$expand")
      $expand?: string;

      /**
       * Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skiptoken")
      $skiptoken?: string;

      /**
       * May be used to limit the number of results to the top N results.
       */
      @maxValue(1000)
      @minValue(1)
      @query("$top")
      $top?: int32;
    },
    Error = ErrorResponse
  >;
}

alias PriceSheetGroup = Extension.ExternalResource<
  "Microsoft.Billing",
  "billingPeriods",
  "billingPeriodName",
  Description = "Billing Period Name.",
  ParentType = "Subscription"
>;

@armResourceOperations
interface PriceSheet {
  /**
   * Get the price sheet for a scope by subscriptionId and billing period. Price sheet is available via this API only for May 1, 2014 or later.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/consumption/")
  getByBillingPeriod is Extension.Read<
    PriceSheetGroup,
    PriceSheetResult,
    Parameters = {
      /**
       * May be used to expand the properties/meterDetails within a price sheet. By default, these fields are not included when returning price sheet.
       */
      @query("$expand")
      $expand?: string;

      /**
       * Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skiptoken")
      $skiptoken?: string;

      /**
       * May be used to limit the number of results to the top N results.
       */
      @maxValue(1000)
      @minValue(1)
      @query("$top")
      $top?: int32;
    },
    Error = ErrorResponse
  >;
}

@@doc(PriceSheetResult.name, "");
@@doc(PriceSheetResult.properties,
  "price sheet result. It contains the pricesheet associated with billing period"
);
