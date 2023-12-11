import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Quota;
@doc("List of quota requests with details.")
model QuotaRequestDetail is ExtensionResource<QuotaRequestProperties> {
  @doc("Quota request ID.")
  @path
  @key("id")
  @segment("quotaRequests")
  name: string;
}

@armResourceOperations
interface QuotaRequestDetails {
  @doc("Get the quota request details and status by quota request ID for the resources of the resource provider at a specific location. The quota request ID **id** is returned in the response of the PUT operation.")
  get is ArmResourceRead<QuotaRequestDetail>;
  @doc("For the specified scope, get the current quota requests for a one year period ending at the time is made. Use the **oData** filter to select quota requests.")
  list is ArmResourceListByParent<
    QuotaRequestDetail,
    {
      ...BaseParameters<QuotaRequestDetail>;

      @doc("""
| Field                    | Supported operators  
|---------------------|------------------------

|requestSubmitTime | ge, le, eq, gt, lt
 |provisioningState eq {QuotaRequestState}
 |resourceName eq {resourceName}

""")
      @query("$filter")
      $filter?: string;

      @doc("Number of records to return.")
      @query("$top")
      $top?: int32;

      @doc("The **Skiptoken** parameter is used only if a previous operation returned a partial result. If a previous response contains a **nextLink** element, its value includes a **skiptoken** parameter that specifies a starting point to use for subsequent calls.")
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;
}
