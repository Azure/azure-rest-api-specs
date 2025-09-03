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
}

alias PriceSheetResultOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Consumption";
  },
  {},
  {
    /** undefined */
    @path
    @segment("pricesheets")
    @key
    default: string;
  }
>;

@armResourceOperations
interface PriceSheetResults {
  /**
   * Gets the price sheet for a subscription. Price sheet is available via this API only for May 1, 2014 or later.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PriceSheet_Get")
  get is PriceSheetResultOps.Read<
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
    }
  >;
}
alias PriceSheetOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Billing";

    /** Billing Period Name. */
    @path
    @segment("billingPeriods")
    @key
    billingPeriodName: string;
  },
  {
    ...Extension.ExtensionProviderNamespace<PriceSheetResult>;
  },
  {
    ...Extension.ExtensionProviderNamespace<PriceSheetResult>;

    /** undefined */
    @path
    @segment("pricesheets")
    @key
    default: string;
  }
>;

@armResourceOperations
interface PriceSheet {
  /**
   * Get the price sheet for a scope by subscriptionId and billing period. Price sheet is available via this API only for May 1, 2014 or later.
   */
  getByBillingPeriod is PriceSheetOps.Read<
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
    }
  >;
}

@@doc(PriceSheetResult.name, "");
@@doc(PriceSheetResult.properties,
  "price sheet result. It contains the pricesheet associated with billing period"
);
