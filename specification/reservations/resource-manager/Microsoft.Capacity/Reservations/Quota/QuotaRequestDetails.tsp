import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Quota;
/**
 * Quota request details.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(LocationProxy)
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
model QuotaRequestDetails {
  /** Quota request ID. */
  @visibility(Lifecycle.Read)
  id?: string;

  /** Quota request name. */
  @visibility(Lifecycle.Read)
  name?: string;

  /** Quota request details. */
  properties?: QuotaRequestProperties;

  /** Resource type */
  @visibility(Lifecycle.Read)
  type?: string;
}

alias QuotaRequestDetailsOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...Azure.ResourceManager.ProviderNamespace<QuotaRequestDetails>;

    /**
     * Azure resource provider ID.
     */
    @segment("resourceProviders")
    @path
    @key
    providerId: string;

    /**
     * Azure region.
     */
    @segment("locations")
    @path
    @key
    location: string;
  },
  {
    /** Quota Request ID. */
    @path
    @segment("serviceLimitsRequests")
    @key
    id: string;
  },
  ErrorType = ExceptionResponse
>;

@armResourceOperations(#{ omitTags: true })
interface QuotaRequestStatus {
  /**
   * For the specified Azure region (location), get the details and status of the quota request by the quota request ID for the resources of the resource provider. The PUT request for the quota (service limit) returns a response with the requestId parameter.
   */
  @tag("QuotaRequests")
  get is QuotaRequestDetailsOps.Read<QuotaRequestDetails>;

  /**
   * For the specified Azure region (location), subscription, and resource provider, get the history of the quota requests for the past year. To select specific quota requests, use the oData filter.
   */
  @tag("QuotaRequests")
  list is QuotaRequestDetailsOps.List<
    QuotaRequestDetails,
    Parameters = {
      /**
       * | Field | Supported operators |
       * |---------------------|------------------------|
       * |requestSubmitTime | ge, le, eq, gt, lt |
       */
      @query("$filter")
      $filter?: string;

      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element includes a skiptoken parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skiptoken")
      $skiptoken?: string;
    },
    Response = ArmResponse<QuotaRequestDetailsList>
  >;
}

@@doc(QuotaRequestDetails.properties, "Quota request details.");
