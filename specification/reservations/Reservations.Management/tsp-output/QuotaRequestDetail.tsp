import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Capacity;
@doc("Quota request details.")
@locationResource
model QuotaRequestDetail is ProxyResource<QuotaRequestProperties> {
  @doc("Quota Request ID.")
  @path
  @key("id")
  @segment("serviceLimitsRequests")
  name: string;
}

@armResourceOperations
interface QuotaRequestDetails {
  @doc("For the specified Azure region (location), get the details and status of the quota request by the quota request ID for the resources of the resource provider. The PUT request for the quota (service limit) returns a response with the requestId parameter.")
  get is ArmResourceRead<QuotaRequestDetail>;
  @doc("For the specified Azure region (location), subscription, and resource provider, get the history of the quota requests for the past year. To select specific quota requests, use the oData filter.")
  list is ArmResourceListByParent<
    QuotaRequestDetail,
    {
      ...BaseParameters<QuotaRequestDetail>;

      @doc("""
| Field | Supported operators |
|---------------------|------------------------|
|requestSubmitTime | ge, le, eq, gt, lt |
""")
      @query("$filter")
      $filter?: string;

      @doc("Number of records to return.")
      @query("$top")
      $top?: int32;

      @doc("Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element includes a skiptoken parameter that specifies a starting point to use for subsequent calls.")
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;
}
