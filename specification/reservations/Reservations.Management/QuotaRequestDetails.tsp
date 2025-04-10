import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Capacity;
/**
 * Quota request details.
 */
@subscriptionResource
@parentResource(SubscriptionLocationResource)
model QuotaRequestDetails
  is Azure.ResourceManager.ProxyResource<QuotaRequestProperties> {
  ...ResourceNameParameter<
    Resource = QuotaRequestDetails,
    KeyName = "id",
    SegmentName = "serviceLimitsRequests",
    NamePattern = ""
  >;
}

@armResourceOperations
interface QuotaRequestStatus {
  /**
   * For the specified Azure region (location), get the details and status of the quota request by the quota request ID for the resources of the resource provider. The PUT request for the quota (service limit) returns a response with the requestId parameter.
   */
  get is ArmResourceRead<
    QuotaRequestDetails,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * For the specified Azure region (location), subscription, and resource provider, get the history of the quota requests for the past year. To select specific quota requests, use the oData filter.
   */
  list is ArmResourceListByParent<
    QuotaRequestDetails,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
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

@@doc(QuotaRequestDetails.name, "Quota Request ID.");
@@doc(QuotaRequestDetails.properties, "Quota request details.");
